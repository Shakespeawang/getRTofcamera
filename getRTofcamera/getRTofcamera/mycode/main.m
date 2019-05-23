clear 
close all
clc

%% Set parameters.
% Parameter for extracting SIFT key points.
% Parameters for resizing input images.
imreszierate1 = 0.5;
imreszierate2 = 0.5;
% Parameters for refining matching results.
sigma3 = 0.005; % The scale controlling parameter in Eq.(3).
thr=0.0001;
MaxIter = 100;

%% Load and pre-process two multi-source images
% Set the path of images.
image1='images\books\11.jpg';
image2='images\books\33.jpg';
%image1='images\books\book_nir.png';
%image2='images\books\book_rgb.png';
% 读取图片
im1 = imread(image1);
im2 = imread(image2);

%读取相机内参
 load('E:\fireFox-download\hypergraph-matching-master\test18-2.mat');
 K=(params.IntrinsicMatrix)';

% 放大/缩小图片
% Rotations can also be involved here.
%im1 = imresize(im1,imreszierate1);
%im2 = imresize(im2,imreszierate2);
if isrgb(im1)
%     imshow(image);
    im1 = rgb2gray(im1);
end
if isrgb(im2)
%     imshow(image);
    im2 = rgb2gray(im2);
end

%% Raw matching.
%第一次匹配
[match,num,loc1,loc2] = picmatch(im1,im2);
%剔除误差点，选择精度高的特征点
[loc1_m ,loc2_m] = selectpoint(loc1,loc2,num,match);
%排除异常值，并计算变换矩阵T
%使用M-estimator SAmple Consensus（MSAC）算法排除异常值。MSAC算法是随机样本共识（RANSAC）算法的变体
%由于MSAC算法的随机性，运行之间的结果可能不相同
[T,inlierloc2_m,inlierloc1_m] = estimateGeometricTransform(loc2_m,loc1_m,'projective');
%
num2 = secondmatch(inlierloc1_m,inlierloc2_m,im1,im2);


[E,F]=eightPoint(inlierloc1_m, inlierloc2_m, K, K);

%恢复R t
t1 = poseCandidatesFromE(E);
[P1,P2,T1,R] = reconstruct3D(t1,inlierloc1_m,inlierloc2_m)

