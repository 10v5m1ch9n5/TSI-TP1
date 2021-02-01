function [] = plotg(f)
%plotg Calcule et affiche la fonction g_f(t)
a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

subplot(2,1,1)
g = gf(f, range);
plot(range, g)
axis([-0.02 0.02 -5 5])
title('Fonction g(t)')

subplot(2,1,2)
G = imag(tfour(g));
plot(freq, G)
title(['Transformée de Fourier de g avec f=',num2str(f)])
xticks([-2000 -1500 -1150 -1100 -1050 -1000 -500 0 500 1000 1050 1100 1150 1500 2000])
xtickangle(70)
end
