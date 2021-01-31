[im, map] = imread('images-ndg/Thorg.bmp');
K = 10;


gauss = zeros(1024);
for i=1:1024
    for j=1:1024
        x = i-512;
        y = j-512;
        gauss(i,j) = exp(-K*(x^2 + y^2));
    end
end


fig_filtre3 = figure('Name', 'Fonction gaussienne');
subplot(2,1,1)
plot(gauss);
title('Fonction gaussienne')

fft_img = fft2(double(im));
fft_img = fftshift(fft_img);

logIM = log(abs(fft_img)+1);
maxi = max(max(logIM));
mini = min(min(logIM));

%figure(2)
%image((logIM-mini)/(maxi-mini)*255)
%colormap(map)

% Traitements
fft_img = fft_img.*gauss;
im_traitee = real(ifft2(fftshift(fft_img)));

subplot(2,1,2)
image(im_traitee);
title('Image traitée par le filtre gaussien')

%figure(2)
%image(im_traitee)
colormap(map)
saveas(fig_filtre3, 'figures/fig_filtre3.png')
