function [pozitia] = KNN(A,training,poza,norma,k)
Z=zeros(1,training*40);
poza=double(reshape(poza,10304,1));
for i=1:size(A,2)
    switch norma
        case 'n1',Z(i)=norm(poza-A(:,i),1);
        case 'n2',Z(i)=norm(poza-A(:,i),2);
        case 'ninf',Z(i)=norm(poza-A(:,i),inf);
        case 'ncos',Z(i)=1-dot(poza,A(:,i))/(norm(poza)*norm(A(:,i)));
    end
    [distante,pozitii]=sort(Z);
    vecini=zeros(1,k);
    for i=1:k
        if mod(pozitii(i),training)~=0
            vecini(i)=floor(pozitii(i)/training)+1;
        else
            vecini(i)=pozitii(i)/training;
        end
    end
end
gasit=mode(vecini);%vecinul care se repeta cel mai des
pozitia=(gasit-1)*training+1;%pozitia primei poze a persoanei gasite