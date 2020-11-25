function varargout = Statistics(varargin)
% STATISTICS MATLAB code for Statistics.fig
%      STATISTICS, by itself, creates a new STATISTICS or raises the existing
%      singleton*.
%
%      H = STATISTICS returns the handle to a new STATISTICS or the handle to
%      the existing singleton*.
%
%      STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICS.M with the given input arguments.
%
%      STATISTICS('Property','Value',...) creates a new STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Statistics

% Last Modified by GUIDE v2.5 09-Oct-2019 21:01:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @Statistics_OutputFcn, ...
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


% --- Executes just before Statistics is made visible.
function Statistics_OpeningFcn(hObject, eventdata, handles, varargin)
bd=getappdata(0,'bd');
alg=getappdata(0,'algoritm');
training=getappdata(0,'training');
set(handles.statistici,'Title',strcat('Statistici_',bd,'_',num2str(training),'_',alg));
valk=getappdata(0,'valk');
if isequal(alg,'nn')||isequal(alg,'knn')
    set(handles.timppre,'Visible','off');
    set(handles.tptext,'Visible','off');
else
    set(handles.timppre,'Visible','on');
    set(handles.tptext,'Visible','on');
end
fis_rr=strcat(bd,'_',num2str(training),'_',alg,'_rr.txt');
fis_tmi=strcat(bd,'_',num2str(training),'_',alg,'_tmi.txt');
if ~(isequal(alg,'nn')||isequal(alg,'knn'))
    fis_tp=strcat(bd,'_',num2str(training),'_',alg,'_tp.txt');
    TP=dlmread(fis_tp);
end
RR=dlmread(fis_rr);
TMI=dlmread(fis_tmi);
axes(handles.rata);
if isequal(alg,'nn')
        valk=[1,2,3,4];
        plot(valk,RR(1,:)*100,'p-','Color',[0.05,0.45,0.14]);%rr(:,1)=k,rr(:,2)=norma1
        grid on;
        xticks([1 2 3 4]);
        xticklabels({'n1','n2','ninf','ncos'});
        xlabel('Norma');
        ylabel('Rata de recunoastere (%)');
        axes(handles.timpmed);
        plot(valk,TMI(1,:),'p-','Color',[0.54, 0.36,0.50]);
        grid on;
        xticks([1 2 3 4]);
        xticklabels({'n1','n2','ninf','ncos'});
        xlabel('Norma');
        ylabel('Timp mediu de interogare (sec)');
else
        plot(valk,RR(:,1)*100,'p-','Color',[0.05,0.45,0.14]);
        grid on;
        hold on;
        plot(valk,RR(:,2)*100,'p-','Color',[0.44,0.54,0.70]);
        plot(valk,RR(:,3)*100,'p-','Color',[0.43,0.67,0.66]);
        plot(valk,RR(:,4)*100,'p-','Color',[0.70,0.44,0.56]);
        if isequal(alg,'knn')
            xticks([3 5 7 9 11]);
            %xticklabels({'20','40','60','80','100'});
        else
            xticks([20 40 60 80 100]);
        end
        xlabel('k');
        ylabel('Rata de recunoastere (%)');
        legend('Norma 1','Norma 2','Norma inf','Norma cos');
        axes(handles.timpmed);
        plot(valk,TMI(:,1),'p-','Color',[0.05,0.45,0.14]);
        grid on;
        hold on;
        plot(valk,TMI(:,2),'p-','Color',[0.44,0.54,0.70]);
        plot(valk,TMI(:,3),'p-','Color',[0.43,0.67,0.66]);
        plot(valk,TMI(:,4),'p-','Color',[0.70,0.44,0.56]);
        if isequal(alg,'knn')
            xticks([3 5 7 9 11]);
            %xticklabels({'20','40','60','80','100'});
        else
            xticks([20 40 60 80 100]);
        end
        xlabel('k');
        ylabel('Timp mediu de interogare (sec)');
        legend('Norma 1','Norma 2','Norma inf','Norma cos');
end
if ~(isequal(alg,'nn')||isequal(alg,'knn'))
        axes(handles.timppre);
        valk=[1,2,3,4,5];       
        plot(valk,TP(1,:),'p-','Color',[0.70,0.44,0.56]);
        grid on;
        xticks([1 2 3 4 5]);
        xticklabels({'20','40','60','80','100'});
        xlabel('k');
        ylabel('Timp de preprocesare (sec)');        
        
        
end
fclose('all');
%axes(handles,rrn2)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Statistics (see VARARGIN)

% Choose default command line output for Statistics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Statistics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
