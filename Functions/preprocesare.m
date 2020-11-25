function [media,hqb,proiectii]=preprocesare(A,alg,training,k)
switch alg
    case 'eigen', [media,hqb,proiectii]=preprocesare_eign(A,training,k);
    case 'eigenrc',[media,hqb,proiectii]=preprocesare_eign_rc(A,training,k);
end
