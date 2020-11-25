function pozitia=EigenfacesRC(A,training,poza,norma,media,hqb,proiectii)
Z=zeros(1,40);
poza=double(reshape(poza,10304,1));
poza=poza-media;
pr_poza=poza'*hqb;
for i=1:size(A,2)/training
    switch norma
        case 'n1',Z(i)=norm(pr_poza-proiectii(i,:),1);
        case 'n2',Z(i)=norm(pr_poza-proiectii(i,:),2);
        case 'ninf',Z(i)=norm(pr_poza-proiectii(i,:),inf);
        case 'ncos',Z(i)=1-dot(pr_poza,proiectii(i,:))/(norm(pr_poza)*norm(proiectii(i,:)));
    end
end
[distanta,pozitia]=min(Z);
pozitia=(pozitia-1)*training+1;