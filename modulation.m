%% Initialisation
a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

f_porteuse_1 = 200;
f_porteuse_2 = 500;
f_porteuse_lim = 401;
%% s_1
s_1 = zeros(1, N);
for n=1:10
    s_1 = s_1 + n*cos(2*pi*10*n*range);
end
f1 = figure('Name', 'S1');
subplot(2,1,1)
plot(range, s_1)
title('Signal s_1 (représentation temporelle)')

S_1 = real(tfour(s_1));
subplot(2,1,2)
plot(freq, S_1)
axis([-110 110 0 165000])
title('TF de s_1 (représentation fréquentielle)')
saveas(f1, 'figures/fig_s1.png')
%% s_2
s_2 = zeros(1, N);
for n=1:10
    s_2 = s_2 + (11-n)*cos(2*pi*10*n*range);
end
f2 = figure('Name', 'S2');
subplot(2,1,1)
plot(range, s_2)
title('Signal s_2 (représentation temporelle)')

S_2 = real(tfour(s_2));
subplot(2,1,2)
plot(freq, S_2)
axis([-110 110 0 165000])
title('Signal s_2 (représentation fréquentielle)')
saveas(f2, 'figures/fig_s2.png');
%% modulation
cos_s1 = cos(2*pi*f_porteuse_1*range);
cos_s2 = cos(2*pi*f_porteuse_2*range);
m = s_1.*cos_s1 + s_2.*cos_s2;

f3 = figure('Name', 'Signal modulé');
plot(freq, real(tfour(m)))
title('Signal modulé m(t) (représentation fréquentielle)')
axis([-(f_porteuse_2+100) f_porteuse_2+100 -1 90000])
saveas(f3, 'figures/fig_modulation.png')

% Cas limite
cos_s2_lim = cos(2*pi*f_porteuse_lim*range);
m_lim = s_1.*cos_s1 + s_2.*cos_s2_lim;
f42 = figure('Name', 'Cas limite');
M_LIM = real(tfour(m_lim));
subplot(2,1,1)
plot(freq, M_LIM)
title('Signal modulé m(t)')
axis([-(f_porteuse_lim+100) f_porteuse_lim+100 -1 90000])
subplot(2,1,2)
plot(freq, M_LIM)
title('Zoom sur la frontière des signaux')
axis([230 370 -1 90000])
saveas(f42, 'figures/fig_modulation_limite.png')
%% demodulation de s_1
d_1 = m.*cos_s1;
D_1 = real(tfour(d_1));
d_2 = m.*cos_s2;
D_2 = real(tfour(d_2));

f4 = figure('Name', 'd1(t)');
plot(freq, D_1)
title('Transformée de Fourier de d_1(t)')
axis([-800 800 -1 90000])
xticks([-800 -600 -400 -200 -100 0 100 200 400 600 800])
xtickangle(45)
saveas(f4, 'figures/fig_d1.png')

f5 = figure('Name', 'd2(t)');
plot(freq, D_2)
