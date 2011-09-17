#!/usr/bin/python

age = 21
prenom = "Marie"

# Affichage avec des guillemets doubles
s1 = "s1 : %s a %s ans" % (prenom,str(age))
print s1

#Affichage avec des guillemets simples
s2 = 's2 : %s a %s ans' % (prenom,str(age))
print s2

#Concatenation
s3 = "s3 : " + prenom + " a " + str(age) + " ans"
print s3

# exercise
exo = "exo : " + prenom + " aura " + str(age+1) + " ans la semaine prochaine"
print exo


