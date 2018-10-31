function output=fromlineartosrgb(X);
alpha=0.055;
gamma=1/2.4;
output=(1+alpha)*X.^gamma-alpha;
masque=X<=0.0031308;
output(masque)=12.92*X(masque);
end