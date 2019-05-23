function im = firstappend(image1,image2)
%FIRSTAPPEND 此处显示有关此函数的摘要
%   此处显示详细说明
rows1 = size(image1,1);
rows2 = size(image2,1);

if (rows1 < rows2)
     image1(rows2,1) = 0;
else
     image2(rows1,1) = 0;
end

% Now append both images side-by-side.
im = [image1 image2];   


