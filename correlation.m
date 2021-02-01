[im, map] = imread('images-ndg/ImageTest.png');
f1 = figure('Name', 'Localisation de formes par Corrélation');
subplot(1,3,1)
x = 50;
y = 50;
image(im(1:x,1:y))
title('Image de départ')

f_1 = zeros(1024);
f_2 = zeros(1024);
f_1(1,1:8) = 1;
f_2(8,1:8) = 1;
for i=1:8
    f_1(9-i,i) = 1;
    f_2(9-i,i) = 1;
end

f_3 = zeros(8);
f_3(1, 4) = 1;
f_3(2, 3) = 1;
f_3(2, 5) = 1;
f_3(3, 2) = 1;
f_3(3, 6) = 1;
f_3(4, 1) = 1;
f_3(4, 7) = 1;
f_3(5, 2) = 1;
f_3(5, 8) = 1;
f_3(6, 3) = 1;
f_3(6, 7) = 1;
f_3(7, 4) = 1;
f_3(7, 6) = 1;
f_3(8, 5) = 1;

f_select = f_1;

f_neg = fliplr(flipud(f_select));
f_neg(1024, 1024) = 0;

IM = fftshift(fft2(double(im)));
F_NEG = fftshift(fft2(double(f_neg)));

% Convolution
conv = IM.*F_NEG;
resultat = ifft2(fftshift(conv));
resultat = (resultat/3570)*255; % mise à l'échelle de 0 à 255
subplot(1,3,2)
image(resultat(1:x,1:y))
colormap(map)
title('Signal de corrélation')

subplot(1,3,3)
image(255*f_select(1:8,1:8))
colormap(map)
title('Motif recherché')
saveas(f1, 'figures/fig_corr.png')

compte = 0;
for i=1:1024
    for j=1:1024
        if(resultat(i,j) > 254)
            compte = compte + 1;
        end
    end
end
%%
%{
logIM = log(abs(IM)+1);
maxi = max(max(logIM));
mini = min(min(logIM));

logF = log(abs(F_NEG)+1);
maxiF = max(max(logF));
miniF = min(min(logF));
%}

f = figure();
subplot(2,2,1)
img_freq_im = (logIM-mini)/(maxi-mini)*255;
image(img_freq_im)
colormap(map)
title('Spectre de l image')

subplot(2,2,2)
img_freq_f = (logF-miniF)/(maxiF-miniF)*255;
image(img_freq_f)
colormap(map)
title('Spectre du motif')
% Convolution
conv = img_freq_f.*img_freq_im;
subplot(2,2,3)
image(conv)
colormap(map)
title('Spectre du produit')

resultat = real(ifft2(fftshift(conv)));
subplot(2,2,4)
image(resultat)
colormap(map)
title('Résultat de la corrélation')




%% Calcul long
corr = zeros(1024);
for i=1:1024
    for j=1:1024
        somme = 0;
        for l=1:8
            for c=1:8
                if(l+i < 1025 && c+j < 1025)
                    somme = somme + f_3(l, c)*S(i+l,j+c);
                end
            end
        end
        corr(i,j) = (somme/2500)*255;
    end
end
image(corr)
colormap(map)