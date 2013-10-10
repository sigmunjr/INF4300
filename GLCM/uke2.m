zebra1 = imread('zebra_1.tif');
zebra1 = zebra1.*((16-1)/255) + 1;
[N M] = size(zebra1);
idx = zeros(N, M);

x = repmat(1:16, 16, 1);
y = x';
inert = @(glcm) sum(sum(abs(x-y).^2 .* glcm));

%idx(200:230, 200:230) = true;%logical(ones(31));
%idx(370:400, 1:31) = true;

%zebra1(logical(idx)) = 0;

% glcm1 = GLCM(zebra1(200:230, 200:230), 16, [0 3]);
% glcm2 = GLCM(zebra1(180:210, 240:270), 16, [0 3]);
% glcm3 = GLCM(zebra1(370:400, 1:31), 16, [0 3]);
% 
% inert(glcm1)
% inert(glcm2)
% inert(glcm3)
% 
% figure(99)
% imshow(zebra1, [])
% 
% figure(1), imshow(glcm1, [])
% colormap(jet)
% colorbar
% 
% figure(2), imshow(glcm2, [])
% colormap(jet)
% colorbar
% 
% figure(3), imshow(glcm3, [])
% colormap(jet)
% colorbar

%Finding features
feature1 = glidingGLCM(zebra1, inert, 0, 3, 31);
feature2 = glidingGLCM(zebra1, inert, 3, 0, 31);

isZebra = feature1>8 | feature2>10;

foundZebras = zebra1(16:end-15, 16:end-15);
foundZebras(~isZebra) = 0;

imshow(foundZebras, [])