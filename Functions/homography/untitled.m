[k,l]=size(ima);
Hba=inv(Hab);
A=Hba*[1;1;1];
A=A/A(3)

B=Hba*[k;1;1];
B=B/B(3)

C=Hba*[1;l;1];
C=C/C(3)

D=Hba*[k;l;1];
D=D/D(3)

Z=[A B C D]


