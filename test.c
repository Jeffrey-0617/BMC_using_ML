extern int __VERIFIER_nondet_int(void);

int f(int x) {
  int result = 0, i;
  if(x>42){
    result = (x / 42);
  }

  for(i = 0; i<2; i++){
    result = result+1;
  }

  while(i>0){
    i--;
  }

  do{
    i++;
  }while(i<3);


  return result;
}

int main(){
  const int SIDE = 10;
  int a[3];
  int b,i;
  for(i = 0; i < 2; i++){
    a[i] = 43;
  }
  //a[4] = 50;
assert(a[1]==43);

int* numbers = (int*) alloca(10 * sizeof(int));

for(int k = 0; k < 11; k++)
{
  numbers[k] = 1;
}


  b = f(a[0]);
  return 0;
}
