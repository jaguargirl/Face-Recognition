function pozitia=Lanczos(A,training,poza,norma,hqb,proiectii)
Z=zeros(1,training*40);
poza=double(reshape(poza,10304,1));
pr_poza=poza'*hqb;
for i=1:size(A,2)
    switch norma
        case 'n1',Z(i)=norm(pr_poza-proiectii(i,:),1);
        case 'n2',Z(i)=norm(pr_poza-proiectii(i,:),2);
        case 'ninf',Z(i)=norm(pr_poza-proiectii(i,:),inf);
        case 'ncos',Z(i)=1-dot(pr_poza,proiectii(i,:))/(norm(pr_poza)*norm(proiectii(i,:)));
    end
end
[distanta,pozitia]=min(Z);