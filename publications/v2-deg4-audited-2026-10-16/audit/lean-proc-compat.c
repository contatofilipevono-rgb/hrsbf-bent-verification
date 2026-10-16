#define _GNU_SOURCE
#include <unistd.h>
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
ssize_t readlink(const char *p,char *buf,size_t n){
 static ssize_t(*real)(const char*,char*,size_t)=0;
 if(!real)real=dlsym(RTLD_NEXT,"readlink");
 ssize_t r=real(p,buf,n);
 char expected[80];snprintf(expected,sizeof(expected),"/proc/%d/exe",getpid());
 if(r<0 && strcmp(p,expected)==0)return real("/proc/self/exe",buf,n);
 return r;
}
