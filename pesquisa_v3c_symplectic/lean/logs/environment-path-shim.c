#define _GNU_SOURCE
#include <unistd.h>
#include <dlfcn.h>
#include <string.h>
#include <stdio.h>
ssize_t readlink(const char *path, char *buf, size_t size) {
  static ssize_t (*original)(const char*,char*,size_t);
  if (!original) original=dlsym(RTLD_NEXT,"readlink");
  ssize_t n=original(path,buf,size);
  if (n<0 && strncmp(path,"/proc/",6)==0 && strstr(path,"/exe")) {
    FILE *f=fopen("/proc/self/cmdline","rb");
    if(f){size_t k=fread(buf,1,size,f);fclose(f);if(k){return strnlen(buf,k);}}
  }
  return n;
}
