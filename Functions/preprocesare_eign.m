function [media,hqb,proiectii]=preprocesare_eign(A,training,k)
media=mean(A,2);
O=ones(1,training*40);
A=A-media*O;
C=A*A';
[V,D]=eigs(C,k);
proiectii=A'*V;
hqb=V;
end