function [media,hqb,proiectii]=preprocesare_eign_rc(A,training,k)
media=mean(A,2);
O=ones(1,training*40);
A=A-media*O;
RC=zeros(size(A,1),size(A,2)/training);
for i=1:size(RC,2)
    RC(:,i)=mean((A(:,((i-1)*training+1):(training*i))),2);%media pozelor persoanei i
    RC(:,i)=A(:,(i-1)*training+1+floor(training*rand()));
end
L=A'*A;
[V,D]=eigs(L,k);
V=A*V;
proiectii=RC'*V;
hqb=V;
end