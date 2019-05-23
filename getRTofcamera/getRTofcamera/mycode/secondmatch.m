function [num2] = secondmatch(loc1_m,loc2_m,im1,im2)
% 经过一次筛选后，再绘图
% 两张图连在一起
im3 = firstappend(im1,im2);

% 绘制匹配点的连线
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold on;
cols1 = size(im1,2);
num2=size(loc1_m,1);
for i = 1: size(loc1_m,1)
    line([loc1_m(i,2) loc2_m(i,2)+cols1],[loc1_m(i,1) loc2_m(i,1)], 'Color', 'c');
end
hold off;

fprintf('Found %d matches.\n', num2);
end

