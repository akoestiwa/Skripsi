from z3 import *
import subprocess
import time

def Cexec(init_string):
  out = subprocess.check_output("./a.out %s" % init_string,shell=True,)
  out1 = int(out.decode('utf-8'))
  print("Oracle: ", out1)

  if out1 = 1:
    return True
  elif out1 == 0:
    return False
  
K1_1, K1_2, K1_3, K1_4, K1_5 = Bools('K1_1 K1_2 K1_3 K1_4 K1_5')
K2_1, K2_2, K2_3, K2_4, K2_5 = Bools('K2_1 K2_2 K2_3 K2_4 K2_5')
A, B, C, D, E = Bools('A B C D E')
Y1, Y2 = Bools('Y1 Y2')

s = Tactic('smt').solver()

def findOutput(k1,k2,k3,k4,k5,A,B,C,D,E):
  g1 = And(A,B)
  g2 = And(B,C)
  g3 = Or(C,D)
  g4 = Not(And(D,E))
  kg1 = Xor(k1,g1)
  kg2 = Not(Xor(k2,g2))
  g5 = Not(And(kg1,kg2))
  g6 = Not(g3)
  kg4 = Not(Xor(k4,g6))
  kg5 = Xor(k5,g4)
  g7 = Or(kg4,kg5)
  kg3 = Xor(g5,k3)
  Y = Or(g7,kg3)
  return Y

#Miter
s.add(findOutput(K1_1, K1_2, K1_3, K1_4, K1_5, A,B,C,D,E) == Y1)
s.add(findOutput(K2_1, K2_2, K2_3, K2_4, K2_5, A,B,C,D,E) == Y1)
s.push()

iteration=0
file_path = 'Dips.txt'
while s.check(Y1 != Y2) == sat:
  m = s.model()
  ia = str(m[A]) + " " + str(m[B]) + " " + str(m[C]) + " " + str(m[D]) + " " + str(m[E])
  words = ia.split()
  replaced = ['1' if word == 'True' else '0' for word in words]
  ia = ' '.join(replaced)
  print("DIP:", ia)
  oa = Cexec(ia)
  print("The two keys are: ")
  print(str(m[K2_1]) + " " + str(m[K2_2]) + " " + str(m[K2_3]) + " " + str(m[K2_4]) + " ")
  print(str(m[K1_1]) + " " + str(m[K1_2]) + " " + str(m[K1_3]) + " " + str(m[K1_4]) + " ")

  s.add(findOutput(K1_1, K1_2, K1_3, K1_4, K1_5, m[A],m[B],m[C],m[D],m[E]) == oa)
  s.add(findOutput(K2_1, K2_2, K2_3, K2_4, K2_5, m[A],m[B],m[C],m[D],m[E]) == oa)
  s.push()
  iteration = iteration + 1
print("Number of iteration:", iteration)

print()
print("The correct keys :")
print(str(m[K2_1]) + " " + str(m[K2_2]) + " " + str(m[K2_3]) + " " + str(m[K2_4]) + " " + str(m[K2_5]))