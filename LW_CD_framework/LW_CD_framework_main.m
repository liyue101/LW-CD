% -------- Parameter area --------
q =1;                 % image index
segma = 1;
alpha = 40;
eta = 0.5;
pyramid_depth = 3;
N_warps = 2;
ite = 1;
ffd = 10;
a = 1;
max_radius = 2;
scale = 10e-5;


folderPathA  = 'F:\LW_CD\LWCD1070_512_384test\';
folderPathB  = 'F:\LW_CD\LWCD1070_512_384test\';
folderPathGT = 'F:\LW_CD\LWCD1070_512_384test\';

filename = sprintf('%06d.png', q);

% read image
I1im  = imread(fullfile(folderPathA,  'T1', filename));
I2im  = imread(fullfile(folderPathB,  'T2', filename));
im_gt = imread(fullfile(folderPathGT, 'GT', filename));
Size = [384 512];  
I1im = imresize(I1im,Size);
I2im = imresize(I2im,Size);
im_gt = imresize(im_gt,Size);

tic

 [BW] = LWCDProcessing(I1im, I2im,segma, alpha, eta, ite, pyramid_depth, N_warps,...
                                     ffd, a, max_radius, scale);
t1 = toc;


figure;
subplot(1,2,1); imshow(im_gt); title("Ground Truth");
subplot(1,2,2); imshow(BW); title("Processed Result");
 %% evaluation

im_gt=double((im_gt));
im_gt(im_gt>=128)=255;
im_gt(im_gt<128)=0;
BW=im2double(BW);
BW(BW>0)=255;
BW(BW<=0)=0;
[m,n]=size(BW);


filename = sprintf('Limain_data%06d.png', q);
% imwrite(BW, fullfile(saveBWPath, filename));
fprintf(' ... ... Calculate various evaluation indexes ... ...\n');
[FN,FP,OE,O,TP,TN]=PingJia_ture(BW,im_gt);
N=m*n;
PCC=O/N;
P=TP/(TP + FP);%
R=TP/(TP + FN);%
F1_score=(2*P*R)/(P+R);
F1_score(isnan(F1_score)==1) = 0;
FPR = FP/(FP+TN); 
TPR = TP/(TP+FN);  
t=t1;


