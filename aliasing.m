a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);
f = 2250;

fig = figure('Name', 'Echantillonage et aliasing');
subplot(2,1,1)
g = gf(f, range);
plot(range, g)
axis([-0.02 0.02 -5 5])
title('Fonction g(t)')

subplot(2,1,2)
G = imag(tfour(g));
plot(freq, G)
title('Transformée de Fourier de g')