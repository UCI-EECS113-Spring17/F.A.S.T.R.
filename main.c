//
//  main.c
//  matmult
//
//  Created by Jordan on 6/1/17.
//  Copyright © 2017 Jordan Dickson. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int *getMatrix(int, int, int, int);
void printMatrix(int*, int, int);
int* matmult(int* a, int* b, int n);
int intPow(int base, int exp);
double get_elasped_time(struct timeval start, struct timeval end);

int main(int argc, const char * argv[]) {
  // insert code here...
  int n = 4;
  if (argc != 2) {
    
  } else {
    n = atoi(argv[1]);
  }
  
  
  int *mat1 = getMatrix(n, n, 0, 20);
  //printMatrix(mat1, n, n);
  int *mat2 = getMatrix(n, n, 0, 20);
  //printMatrix(mat2, n, n);
  
  
  struct timeval start, end;
  
  gettimeofday(&start, NULL);
  int* result = matmult(mat1, mat2, n);
  gettimeofday(&end, NULL);
  //printMatrix(result, n, n);
  
  double elapsedTime = (get_elasped_time(start, end)/1000.0);
  
  printf("Solution for %dx%d matrix took %f seconds\n",n,n,elapsedTime);
  int mults = intPow(n, 3);
  int adds = (n-1)*intPow(n, 2);
  printf("Totals:\n");
  printf("\t Multiplications: %d (%f per second)\n",mults,(mults/elapsedTime));
  printf("\t Additions: %d (%f per second)\n",adds,(adds/elapsedTime));

  free(mat1);
  free(mat2);
  free(result);
  
  
  return 0;
}

//n columns, m rows
int* getMatrix(int n, int m, int min, int max){
  int i = 0;
  int val = 0;
  int* rtnMatrix = (int*)malloc(n*m*sizeof(unsigned int));
  for(i = 0; i < m; i++){
    int j = 0;
    for (j = 0; j < n; j++) {
      val = min + rand()%(max-min);
      rtnMatrix[i*n + j] = val;
    }
  }
  return rtnMatrix;
}

void printMatrix(int *ptr, int n, int m){
  int i = 0;
  for (i = 0; i < m; i++) {
    int j = 0;
    for (j = 0; j < n; j++) {
      if(j == 0){
        printf("[%2d",ptr[i*n + j]);
      } else {
        printf(", %2d",ptr[i*n + j]);
      }
    }
    printf("]\n");
  }
}

int* matmult(int* a, int* b, int n){
  int* rtnMatrix = (int*)calloc(n*n, sizeof(unsigned int));
  int i = 0;
  int val = 0;
  for(i = 0; i < n; i++){
    int j = 0;
    for (j = 0; j < n; j++) {
      int k = 0;
      for (k = 0; k < n; k++){
        val += a[i*n + k] * b[k*n + j];
      }
      rtnMatrix[i*n + j] = val;
      val = 0;
    }
  }
  return rtnMatrix;
}

int intPow(int x, int pow) {
  int ret = 1;
  while ( pow != 0 )
  {
    if ( (pow & 1) == 1 )
      ret *= x;
    x *= x;
    pow >>= 1;
  }
  return ret;
}

double get_elasped_time(struct timeval start, struct timeval end) {
  double mtime = 0;
  long seconds  = end.tv_sec  - start.tv_sec;
  long useconds = end.tv_usec - start.tv_usec;
  
  mtime = ((seconds) * 1000.0 + useconds/1000.0) + 0.5;
  
  return mtime;
}
