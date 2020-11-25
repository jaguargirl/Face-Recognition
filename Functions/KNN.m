function [position] = KNN(A,training,img,norm,k)
Z=zeros(1,training*40);
img=double(reshape(img,10304,1));
for i=1:size(A,2)
    switch norm
        case 'n1',Z(i)=norm(img-A(:,i),1);
        case 'n2',Z(i)=norm(img-A(:,i),2);
        case 'ninf',Z(i)=norm(img-A(:,i),inf);
        case 'ncos',Z(i)=1-dot(img,A(:,i))/(norm(img)*norm(A(:,i)));
    end
    [distances,positions]=sort(Z);
    neighbours=zeros(1,k);
    for i=1:k
        if mod(positions(i),training)~=0
            neighbours(i)=floor(positions(i)/training)+1;
        else
            neighbours(i)=positions(i)/training;
        end
    end
end
found=mode(neighbours);
position=(found-1)*training+1;
