function [pozitia] = NN(A,training,poza,norma)
Z=zeros(1,training*40);
poza=double(reshape(poza,10304,1));
for i=1:size(A,2)
    switch norma
        case 'n1',Z(i)=norm(poza-A(:,i),1);
        case 'n2',Z(i)=norm(poza-A(:,i),2);
        case 'ninf',Z(i)=norm(poza-A(:,i),inf);
        case 'ncos',Z(i)=1-dot(poza,A(:,i))/(norm(poza)*norm(A(:,i)));
    end
end
[distanta,pozitia]=min(Z);

