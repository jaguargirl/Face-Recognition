function [hqb,proiectii]=preprocesare_lan(A,k)
beta=zeros(k+1);
hqb=ones(size(A,1),k+1);
hqb(:,1)=zeros(size(A,1),1);
hqb(:,2)=hqb(:,2)/norm(hqb(:,2));
for i=2:k+1
    w=A*(A'*hqb(:,i))-beta(i)*hqb(:,i-1);
    alpha=dot(w,hqb(:,i));
    w=w-alpha*hqb(:,i);
    beta(i+1)=norm(w,2);
    hqb(:,i+1)=w/beta(i+1);
end

hqb=hqb(:,2:k+1);
proiectii=A'*hqb;
