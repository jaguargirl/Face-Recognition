function varargout = Mainpage(varargin)
% MAINPAGE MATLAB code for Mainpage.fig
%      MAINPAGE, by itself, creates a new MAINPAGE or raises the existing
%      singleton*.
%
%      H = MAINPAGE returns the handle to a new MAINPAGE or the handle to
%      the existing singleton*.
%
%      MAINPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPAGE.M with the given input arguments.
%
%      MAINPAGE('Property','Value',...) creates a new MAINPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mainpage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mainpage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mainpage

% Last Modified by GUIDE v2.5 24-Oct-2019 11:08:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Mainpage_OpeningFcn, ...
    'gui_OutputFcn',  @Mainpage_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Mainpage is made visible.
function Mainpage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Mainpage (see VARARGIN)

% Choose default command line output for Mainpage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Mainpage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Mainpage_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in inc.
function inc_Callback(hObject, eventdata, handles)
global poza;
global bd;
if isequal(bd,'orl')
    cd('ORL');
elseif isequal(bd,'ctovd')
    cd('CTOVD');
end
[FileName, PathName] = uigetfile({'.pgm; *.PGM', 'PGM Files (.pgm, *.PGM)';...
    '.tif; *.TIF', 'TIF Files (.tif, *.TIF)';...
    '.jpg; *.JPG', 'JPG Files (.jpg, *.JPG)';...
    '.gif; *.GIF', 'GIF Files (.gif, *.GIF)';...
    '.bmp; *.BMP', 'BMP Files (.bmp, *.BMP)';...
    '.', 'All Files(.)'}, 'Select the input file');

if isequal(FileName, 0) || isequal(PathName, 0)
    warndlg('Error: user pressed cancel. Select an image file.', 'Load Error')
else
    [~, ~, ext] = fileparts(FileName);
    if isequal(ext, '.tif') || isequal(ext, '.TIF') ||...
            isequal(ext, '.jpg') || isequal(ext, '.JPG') ||...
            isequal(ext, '.bmp') || isequal(ext, '.BMP') ||...
            isequal(ext, '.gif') || isequal(ext, '.GIF') ||...
            isequal(ext, '.png') || isequal(ext, '.pgm')
        cd(PathName)
        handles.FileName = FileName;
        poza = imread(FileName);
        axes(handles.original);
        cla;
        colormap(gray);
        imagesc(poza);
        axis image;
        grid off;
        handles.poza = poza;
        guidata(hObject, handles);
    else
        warndlg('Error: Format de fisier invalid. Selectati fisierul imagine.', 'Eroare la incarcare');
    end
    cd ..;
    cd ..;
end
%uigetfile
% hObject    handle to inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ct.
function ct_Callback(hObject, eventdata, handles)
global poza;
global alg;
global A;
global training;
global norma;
global k;
global media;
global hqb;
global proiectii;
switch alg
    case 'nn', pozitia=NN(A,training,poza,norma);
    case 'knn', pozitia=KNN(A,training,poza,norma,k);
    case 'eigen', pozitia=Eigenfaces(A,training,poza,norma,media,hqb,proiectii);
    case 'eigenrc', pozitia=EigenfacesRC(A,training,poza,norma,media,hqb,proiectii);
    case 'lan', pozitia=Lanczos(A,training,poza,norma,hqb,proiectii);
end
axes(handles.result);% setam axes curent
cla;%curatam axes
gasit=A(:,pozitia);
gasit=reshape(gasit,112,92);
axis image;
grid off;
imagesc(gasit);
axis image;
grid off;
handles.poza = poza;
guidata(hObject, handles);
% hObject    handle to ct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stat.
function stat_Callback(hObject, ~, handles)
global training;
global alg;
global bd;
global A;
RT=zeros(4,40);
TMI=zeros(5,4);
nr_teste=(10-training)*40;
if isequal(alg,'nn')
    pas=1;
    valk=1;
elseif isequal(alg,'knn')
    valk=[3,5,7,9,11];
else
    pas=20;
    valk=20:pas:100;
end
if isequal(bd,'orl')
    dir='ORL';
elseif isequal(bd,'ctovd')
    dir='CTOVD';
end
fileNameTMI=strcat(bd,'_',num2str(training),'_',alg,'_tmi.txt');
TP=zeros(1,size(valk,2));
RR=zeros(size(valk,2),4);
linie=1;
fileName=strcat(bd,'_',num2str(training),'_',alg,'_rr.txt');
if ~(exist(fileName,'file')&&exist(fileNameTMI,'file'))
    if ~(isequal(alg,'nn')||isequal(alg,'knn'))
        fileNameTP=strcat(bd,'_',num2str(training),'_',alg,'_tp.txt');
        fileID1=fopen(fileNameTP,'w+');
    end
    fileID=fopen(fileName,'w+');
    fileID2=fopen(fileNameTMI,'w+');
    for k=valk
        if ~(isequal(alg,'nn')||isequal(alg,'knn'))
            tic
            if isequal(alg,'lan')
                [hqb,proiectii]=preprocesare_lan(A,k);
            else
                [media,hqb,proiectii]=preprocesare(A,alg,training,k);
            end
            TP(k/pas)=toc;
        end
        cd(dir);
        coloana=1;
        for norma={'n1','n2','ninf','ncos'}
            norma=char(norma);
            contor=0;%contorul reusitelor
            teste=1;%contorul testelor
            ti=zeros(1,nr_teste);
            for i=1:40
                cd(strcat('s',num2str(i)));
                for j=training+1:10
                    poza=imread(strcat(num2str(j),'.pgm'));
                    poza=reshape(poza,10304,1);
                    cd ..;
                    cd ..;
                    tic;
                    switch alg
                        case 'nn', pozitia=NN(A,training,poza,norma);
                        case 'knn', pozitia=KNN(A,training,poza,norma,k);
                        case 'eigen',pozitia=Eigenfaces(A,training,poza,norma,media,hqb,proiectii);
                        case 'eigenrc',pozitia=EigenfacesRC(A,training,poza,norma,media,hqb,proiectii);
                        case 'lan',pozitia=Lanczos(A,training,poza,norma,hqb,proiectii);
                    end
                    ti(teste)=toc;
                    teste=teste+1;
                    if mod(pozitia,training)~=0
                        gasit=floor(pozitia/training)+1;
                    else
                        gasit=pozitia/training;
                    end
                    if gasit==i
                        contor=contor+1;
                    end
                    rr=contor/teste;
                    cd(dir);
                    cd(strcat('s',num2str(i)));
                    RT(i,10-j+1)=rr;
                end
                cd ..;
            end
            TMI(linie,coloana)=mean(ti);
            m=mean(nonzeros(mean(nonzeros(RT),1)));
            RR(linie,coloana)=m;
            coloana=coloana+1;
        end
        cd ..;
        linie=linie+1;
    end
    for ii = 1:size(RR,1)
        fprintf(fileID,'%g\t',RR(ii,:));
        fprintf(fileID,'\n');
        fprintf(fileID2,'%g\t',TMI(ii,:));
        fprintf(fileID2,'\n');
    end
    if ~(isequal(alg,'nn')||isequal(alg,'knn'))
        fprintf(fileID1,'%g\t',TP(1,:));
        % setappdata(0,'tp',fileNameTP);
    end
    fclose('all');
end
setappdata(0,'bd',bd);
setappdata(0,'training',training);
setappdata(0,'algoritm',alg);
setappdata(0,'valk',valk);
figure(Statistics);
% hObject    handle to stat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
global A; %matricea baza de date
global training;%nr poze antrenare per persoana
global alg;
global norma;
global bd; %baza de date
global k;
global media;
global hqb;
global proiectii;
bd=get(get(handles.bd,'SelectedObject'),'Tag');
config=get(get(handles.config,'SelectedObject'),'Tag');
alg=get(get(handles.alg,'SelectedObject'),'Tag');
norma=get(get(handles.norma,'SelectedObject'),'Tag');
strk=get(handles.k,'String');
valk=get(handles.k,'Value');
k=char(strk(valk));
k=str2double(k);
switch config
    case 'c64', training=6;
    case 'c82', training=8;
    case 'c91', training=9;
end
A=zeros(10304,training*40);
if isequal(bd,'orl')
    cd('ORL');
elseif isequal(bd,'ctovd')
    cd('CTOVD');
end
for i=1:40
    cd(strcat('s',num2str(i)));
    for j=1:training
        poza=imread(strcat(num2str(j),'.pgm'));
        poza=reshape(poza,10304,1);
        A(:,(i-1)*training+j)=poza;
    end
    cd ..;% intoarce in folder parinte
end
cd ..;
if ~(isequal(alg,'nn')||isequal(alg,'knn'))
    if isequal(alg,'lan')
        [hqb,proiectii]=preprocesare_lan(A,k);
    else
    [media,hqb,proiectii]=preprocesare(A,alg,training,k);
    end
end

% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in k.
function k_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns k contents as cell array
%        contents{get(hObject,'Value')} returns selected item from k


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in knn.
function knn_Callback(hObject, eventdata, handles)
% hObject    handle to knn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of knn


% --- Executes on button press in nn.
function nn_Callback(hObject, eventdata, handles)
% hObject    handle to nn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nn


% --- Executes when selected object is changed in alg.
function alg_SelectionChangedFcn(hObject, ~, handles)
if get(handles.nn,'Value')==1
    set(handles.k,'Visible','off');
else
    set(handles.k,'Visible','on');
end
if get(handles.knn,'Value')==1
    set(handles.k,'String',{'3','5','7','9','11'})
else
    set(handles.k,'String',{'20','40','60','80','100'})
end
% hObject    handle to the selected object in alg
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
