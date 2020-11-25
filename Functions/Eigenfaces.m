function position=Eigenfaces(A,training,img,norm,med,hqb,proiections)
Z=zeros(1,training*40);
img=double(reshape(img,10304,1));
img=img-med;
img_pr=img'*hqb;
for i=1:size(A,2)
    switch norm
        case 'n1',Z(i)=norm(img_pr-proiectiions(i,:),1);
        case 'n2',Z(i)=norm(img_pr-proiections(i,:),2);
        case 'ninf',Z(i)=norm(img_pr-proiections(i,:),inf);
        case 'ncos',Z(i)=1-dot(img_pr,proiections(i,:))/(norm(img_pr)*norm(proiections(i,:)));
    end
end
[distance,position]=min(Z);
