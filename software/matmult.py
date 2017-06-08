import random as r
import time as t
import sys

#n columns, m rows
def getMat(n,m,sml,lrg):
  rtnList = []
  for i in range(m):
    inner = []
    for j in range(n):
      val = r.randint(sml,lrg)
      inner.append(val)
    rtnList.append(inner)
  return rtnList

def matmult(a,b):
    zip_b = zip(*b)
    # uncomment next line if python 3 : 
    zip_b = list(zip_b)
    return [[sum(ele_a*ele_b for ele_a, ele_b in zip(row_a, col_b)) 
             for col_b in zip_b] for row_a in a]

n = 10

if len(sys.argv) == 2:
  n = int(sys.argv[1])

x = getMat(n,n,0,20)
y = getMat(n,n,0,20)

start = t.time()
ans = matmult(x,y)
finish = t.time()

elapsed = finish-start
print("Solution of %dx%d matrix took %f seconds"%(n,n,elapsed))
mults = n**3
adds = (n-1)*(n**2)
print("Totals:")
print("\t Multiplications: %d (%f per second)"%(mults,mults/elapsed))
print("\t Additions: %d (%f per second)"%(adds,adds/elapsed))

#print(matmult(x,y))

"""
for i in range(10,100,10):
  print(str(i)+"x"+str(i)+" matrix:")
  x = getMat(i,i,0,20)
  y = getMat(i,i,0,20)
  print(x)
  print(y)
  print(matmult(x,y))
"""
