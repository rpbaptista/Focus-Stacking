function output=fromsrgbtolinear(X);

alpha=0.55;
gamma=2.4;

output=((X+alpha)./(1+alpha)).^gamma;
masque=(X<=0.04045);
output(masque)=X(masque)/12.92;

end