/* Independent bit-parallel CPU replay on four mathematically necessary charts.
   Compile with a C compiler supporting GNU builtins and Windows threads.
   This execution is not, by itself, a Lean kernel certificate. */
#include "model_data.h"
#ifdef _WIN32
typedef struct FILE_ FILE;
extern FILE *fopen(const char *, const char *);
extern int fclose(FILE *);
extern int fprintf(FILE *, const char *, ...);
extern int printf(const char *, ...);
extern int fflush(FILE *);
extern int snprintf(char *, unsigned long long, const char *, ...);
extern int atoi(const char *);
extern void *malloc(unsigned long long);
extern void free(void *);
__declspec(dllimport) void * __stdcall CreateThread(void *, U, unsigned long (__stdcall *)(void *), void *, unsigned long, unsigned long *);
__declspec(dllimport) unsigned long __stdcall WaitForSingleObject(void *, unsigned long);
__declspec(dllimport) int __stdcall CloseHandle(void *);
__declspec(dllimport) U __stdcall GetTickCount64(void);
#else
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#define __stdcall
static U GetTickCount64(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC,&t);return (U)t.tv_sec*1000+(U)t.tv_nsec/1000000;}
#endif

static unsigned high_bits=20, thread_count=4;
static U high_limit, chunk_size, chunks_per_case, next_job=0;
static unsigned failed=0, print_lock=0;
static char prefix[1024]="cpu_replay";
typedef struct { U tested,quadratic,w0,bent; } Counts;
static Counts totals[32][4];
static unsigned parity(U x){return __builtin_parityll(x);}
static U original_coefficient(unsigned chart,U z){
 U c=OFFSET[chart];while(z){unsigned j=__builtin_ctzll(z);c^=BASIS[j];z&=z-1;}return c;
}
static unsigned original_filter(U c,unsigned e){
 unsigned v=parity(ORIGL[e]&c);U z=c;
 while(z){unsigned j=__builtin_ctzll(z);v^=parity(ORIGQ[e][j]&c);z&=z-1;}return v;
}
static void initial_state(unsigned chart,U h,U state[43]){
 for(unsigned e=0;e<43;e++)state[e]=BASE[chart][e];
 U z=h;
 while(z){unsigned j=__builtin_ctzll(z);U upper=h&~((1ULL<<(j+1))-1);
  for(unsigned e=0;e<43;e++)state[e]^=DELTA[chart][j][e]^-(U)parity(HH[j][e]&upper);
  z&=z-1;
 }
}
static int self_test(void){
 U seed=125;
 for(unsigned chart=0;chart<4;chart++)for(unsigned sample=0;sample<2048;sample++){
  seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;
  U z=seed&((1ULL<<36)-1),h=z>>6,state[43];unsigned low=z&63;
  initial_state(chart,h,state);U c=original_coefficient(chart,z);
  for(unsigned e=0;e<43;e++)if(((state[e]>>low)&1)!=original_filter(c,e))return 0;
  unsigned j=sample%30;U next=h^(1ULL<<j),direct[43];initial_state(chart,next,direct);
  for(unsigned e=0;e<43;e++)if((state[e]^DELTA[chart][j][e]^-(U)parity(HH[j][e]&h))!=direct[e])return 0;
 }
 return 1;
}
static int witness(U c,int *frequency,int *value,int *passes_w0){
 U t[64]={0},z=c;
 while(z){unsigned j=__builtin_ctzll(z);for(unsigned w=0;w<64;w++)t[w]^=TRUTH[j][w];z&=z-1;}
 unsigned weight=0;for(unsigned w=0;w<64;w++)weight+=__builtin_popcountll(t[w]);
 int w0=4096-2*(int)weight;*passes_w0=(w0==64||w0==-64);
 if(!*passes_w0){*frequency=0;*value=w0;return 0;}
 int a[4096];for(unsigned x=0;x<4096;x++)a[x]=1-2*(int)((t[x>>6]>>(x&63))&1);
 for(unsigned step=1;step<4096;step*=2)for(unsigned start=0;start<4096;start+=step*2)
  for(unsigned j=start;j<start+step;j++){int x=a[j],y=a[j+step];a[j]=x+y;a[j+step]=x-y;}
 for(unsigned j=0;j<4096;j++)if(a[j]!=64&&a[j]!=-64){*frequency=(int)j;*value=a[j];return 0;}
 *frequency=-1;*value=0;return 1;
}
static void acquire_print(void){while(__atomic_exchange_n(&print_lock,1,__ATOMIC_ACQUIRE)){} }
static void release_print(void){__atomic_store_n(&print_lock,0,__ATOMIC_RELEASE);}
static unsigned long __stdcall worker(void *arg){
 unsigned tid=(unsigned)(U)arg;char name[1200];snprintf(name,sizeof(name),"%s_thread%u.csv",prefix,tid);
 FILE *out=fopen(name,"wb");if(!out){__atomic_store_n(&failed,1,__ATOMIC_RELEASE);return 1;}
 fprintf(out,"chart,free_coefficient,original_coefficient,witness_frequency,walsh_value\n");
 for(;;){U job=__atomic_fetch_add(&next_job,1,__ATOMIC_RELAXED);if(job>=4*chunks_per_case)break;
  unsigned chart=(unsigned)(job/chunks_per_case);U part=job%chunks_per_case,start=part*chunk_size,end=start+chunk_size;
  if(end>high_limit)end=high_limit;
  U h=start^(start>>1),state[43];initial_state(chart,h,state);Counts local={0};
  for(U i=start;i<end;i++){
   U valid=~0ULL;for(unsigned e=0;e<43&&valid;e++)valid&=~state[e];
   while(valid){unsigned low=__builtin_ctzll(valid);valid&=valid-1;U z=(h<<6)|low,c=original_coefficient(chart,z);
    int frequency,value,passes_w0;int bent=witness(c,&frequency,&value,&passes_w0);
    local.quadratic++;local.w0+=passes_w0;local.bent+=bent;
    if(fprintf(out,"%u,%llx,%llx,%d,%d\n",chart,z,c,frequency,value)<0)__atomic_store_n(&failed,1,__ATOMIC_RELEASE);
   }
   if(i+1<end){unsigned bit=__builtin_ctzll(i+1);
    for(unsigned e=0;e<43;e++)state[e]^=DELTA[chart][bit][e]^-(U)parity(HH[bit][e]&h);
    h^=1ULL<<bit;
   }
  }
  local.tested=(end-start)*64;
  totals[tid][chart].tested+=local.tested;totals[tid][chart].quadratic+=local.quadratic;
  totals[tid][chart].w0+=local.w0;totals[tid][chart].bent+=local.bent;
  acquire_print();printf("{\"chart\":%u,\"high_index_start\":%llu,\"high_index_end\":%llu,\"tested\":%llu,\"quadratic\":%llu,\"w0\":%llu,\"bent\":%llu}\n",chart,start,end,local.tested,local.quadratic,local.w0,local.bent);fflush(0);release_print();
 }
 if(fclose(out))__atomic_store_n(&failed,1,__ATOMIC_RELEASE);return 0;
}
#ifndef _WIN32
static void *pthread_worker(void *arg){worker(arg);return 0;}
#endif
int main(int argc,char **argv){
 if(argc>1)high_bits=(unsigned)atoi(argv[1]);if(argc>2)thread_count=(unsigned)atoi(argv[2]);
 if(argc>3)snprintf(prefix,sizeof(prefix),"%s",argv[3]);
 if(high_bits>30||thread_count<1||thread_count>32){printf("Invalid arguments: high bits 0..30, threads 1..32\n");return 2;}
 if(!self_test()){printf("SELF_TEST_FAILED\n");return 3;}printf("SELF_TEST_PASS 8192 affine points and Gray updates\n");fflush(0);
 high_limit=1ULL<<high_bits;chunk_size=high_limit<(1ULL<<24)?high_limit:(1ULL<<24);chunks_per_case=(high_limit+chunk_size-1)/chunk_size;
 U start=GetTickCount64();
#ifdef _WIN32
 void *handles[32];
 for(unsigned i=0;i<thread_count;i++){handles[i]=CreateThread(0,0,worker,(void *)(U)i,0,0);if(!handles[i]){printf("THREAD_CREATE_FAILED\n");return 4;}}
 for(unsigned i=0;i<thread_count;i++){if(WaitForSingleObject(handles[i],0xFFFFFFFFUL)!=0)return 5;CloseHandle(handles[i]);}
#else
 pthread_t handles[32];
 for(unsigned i=0;i<thread_count;i++)if(pthread_create(&handles[i],0,pthread_worker,(void *)(U)i))return 4;
 for(unsigned i=0;i<thread_count;i++)if(pthread_join(handles[i],0))return 5;
#endif
 if(failed){printf("IO_FAILED\n");return 6;}
 Counts all={0};for(unsigned chart=0;chart<4;chart++){Counts sum={0};for(unsigned tid=0;tid<thread_count;tid++){
  sum.tested+=totals[tid][chart].tested;sum.quadratic+=totals[tid][chart].quadratic;sum.w0+=totals[tid][chart].w0;sum.bent+=totals[tid][chart].bent;}
  all.tested+=sum.tested;all.quadratic+=sum.quadratic;all.w0+=sum.w0;all.bent+=sum.bent;
  printf("{\"chart_complete\":%u,\"tested\":%llu,\"quadratic\":%llu,\"w0\":%llu,\"bent\":%llu}\n",chart,sum.tested,sum.quadratic,sum.w0,sum.bent);
 }
 printf("{\"status\":\"%s\",\"high_bits\":%u,\"tested\":%llu,\"quadratic\":%llu,\"w0\":%llu,\"bent\":%llu,\"elapsed_ms\":%llu}\n",high_bits==30?"COMPLETE_NECESSARY_CHARTS":"PILOT_CHART_PREFIX",high_bits,all.tested,all.quadratic,all.w0,all.bent,GetTickCount64()-start);
 return all.bent?10:0;
}
