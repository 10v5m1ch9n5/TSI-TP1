%% Initialisation
a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

f_porteuse_1 = 201;
f_porteuse_2 = 402;
%% s_1
s_1 = zeros(1, N);
for n=1:10
    s_1 = s_1 + n*cos(2*pi*10*n*range);
end
f1 = figure('Name', 'S1');
subplot(2,1,1)
plot(range, s_1)
title('Signal s1 (représentation temporelle)')

S_1 = real(tfour(s_1));
subplot(2,1,2)
plot(freq, S_1)
axis([-110 110 0 165000])
title('TF de s1 (représentation fréquentielle)')

%% s_2
s_2 = zeros(1, N);
for n=1:10
    s_2 = s_2 + (11-n)*cos(2*pi*10*n*range);
end
S_2 = real(tfour(s_2));
plot(freq, S_2)
axis([-110 110 0 165000])

%% modulation
cos_s1 = cos(2*pi*f_porteuse_1*range);
cos_s2 = cos(2*pi*f_porteuse_2*range);
m = s_1.*cos_s1 + s_2.*cos_s2;

subplot(2,1,1)
plot(range, m);
subplot(2,1,2)
plot(freq, real(tfour(m)))

%% demodulation de s_1
d_1 = m.*cos_s1;
D_1 = tfour(d_1);
plot(freq, D_1)