% clear all;close all;
% %% LW-CD 
% %A weak CD framework tailored for low-illumination wide-field scenes. 
% % Firstly, a basic Gaussian filter is applied to address complex noise by reducing interference from light sources and sensors.
% % Subsequently, two feature enhancement algorithms are employed to tackle the issue of blurred features in the denoised regions.
% % The first algorithm enhances image brightness using the acoth function and constructs an inverse hyperbolic cotangent logarithmic ratio operator(IHCLRO) to perceive subtle changes in dark environments. 
% % The second algorithm leverages the improved multi-scale dense optical flow (IMDOF) to mitigate the impact of illumination variations and noise, generating a Difference Image (DI) from a fresh perspective. 
% % Following this, a Fractal Theory-based Self-similarity Weighted Fusion (FT-SWF) algorithm is utilized to integrate DIs containing different enhanced features. 
% % Finally, a simple thresholding-based denoising technique is applied to obtain the final change detection results.

q = 1;  % Example image index

segma = 1;
alpha = 40;
eta = 0.5;
pyramid_depth = 3;
N_warps = 2; 
ite = 1;
displayFlow = 0; 
ffd = 30;
a = 1;
b = 14;
max_radius = 2;
scale = 0.5;

% Read the input images
folderPathA = 'E:\LW_CD\380\test\';
folderPathB = 'E:\LW_CD\380\test\';
folderPathGT = 'E:\LW_CD\380\test\';
I1im = imread(fullfile(folderPathA, 'A', [num2str(q) '.jpg']));
I2im = imread(fullfile(folderPathB, 'B', [num2str(q) '.jpg']));
im_gt = imread(fullfile(folderPathGT, 'LABEL', [num2str(q) '.jpg']));
tic
% Call the processing function
[BW] = LWCDProcessing(I1im, I2im, im_gt, q, segma, alpha, eta, pyramid_depth, N_warps, ite, displayFlow, ffd, a, b, max_radius, scale);
t1 = toc;

% Display the results
figure;
subplot(1,2,1); imshow(im_gt); title("Ground Truth");
subplot(1,2,2); imshow(BW); title("Processed Result");

%%
im_gt=double((im_gt));
im_gt(im_gt>=128)=255;
im_gt(im_gt<128)=0;
BW=im2double(BW);
BW(BW>0)=255;
BW(BW<=0)=0;
[m,n]=size(BW);
fprintf(' ... ... Calculate various evaluation indexes ... ...\n');
[FN,FP,OE,O,TP,TN]=PingJia_ture(BW,im_gt);
 N=m*n;
 PCC=O/N;
P=TP/(TP + FP);
R=TP/(TP + FN);
F1_score=(2*P*R)/(P+R);
F1_score(isnan(F1_score)==1) = 0;
Po=PCC;
Pe=(TN+FP)*(TN+FN)/(N*N)+(TP+FP)*(TP+FN)/(N*N);
Kappa=(Po-Pe)/(1-Pe);
FPR = FP/(FP+TN);  
TPR = TP/(TP+FN);  
t=t1;





