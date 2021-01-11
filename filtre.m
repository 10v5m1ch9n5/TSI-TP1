[im, map] = imread('images-ndg/Thorg.bmp');
K = 0.001;
gauss = zeros(1024);
for i=1:1024
    for j=1:1024
        x = i-512;
        y = j-512;
        gauss(i,j) = exp(-K*(x^2 + y^2));
    end
end

fft_img = fft2(double(im));
fft_img = fftshift(fft_img);

logIM = log(abs(fft_img)+1);
maxi = max(max(logIM));
mini = min(min(logIM));

figure(2)
image((logIM-mini)/(maxi-mini)*255)
colormap(map)

% Traitements
fft_img = fft_img.*gauss;

im_traitee = real(ifft2(fftshift(fft_img)));
figure(2)
image(im_traitee)
colormap(map)

%{
subplot(2,2,1)
image(real(fft_img))
subplot(2,2,2)
image(imag(fft_img))
subplot(2,2,3)
image(abs(fft_img))
subplot(2,2,4)
image(angle(fft_img))
%}
