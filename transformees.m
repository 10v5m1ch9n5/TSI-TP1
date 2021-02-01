%% Initialisation
N = 32768;
a = -5;
b = 5;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = (-fe/2):(fe/N):(fe/2-fe/N);
f = 4;
mkdir figures

%% Fonction constante
x0 = 42 * ones(1,N);

f0 = figure('Name', 'Constante');
subplot(3,1,1)
plot(range, x0);
title('Fonction constante')

subplot(3,1,2)
X0 = real(tfour(x0));
plot(freq, X0);
title('Transformée de Fourier de la fonction constante')

subplot(3,1,3)
xo = real(tfourinv(X0));
plot(range,xo)
title('Récupération de la fonction avec tfourinv');
saveas(f0, 'figures/fig_const.png')

%% Fonction cosinus
x1 = cos(2*pi*f*range);

f1 = figure('Name', 'Cosinus');
subplot(3,1,1)
plot(range, x1);
xlabel('Temps (s)')
title('Fonction Cosinus')

subplot(3,1,2)
X1 = real(tfour(x1));
plot(freq, X1);
axis([-10 10 -10 100])
xlabel('Fréquence (Hz)')
title('Transformée de Fourier du Cosinus (partie réelle)')

subplot(3,1,3)
x1 = real(tfourinv(X1));
plot(range,x1)
title('Récupération de la fonction avec tfourinv');
saveas(f1, 'figures/fig_cos.png')

%% Fonction sinus
x2 = sin(2*pi*f*range);

f2 = figure('Name', 'Sinus');
subplot(3,1,1)
plot(range, x2);
xlabel('Temps (s)')
title('Fonction Sinus')

subplot(3,1,2)
X2 = imag(tfour(x2));
plot(freq, X2);
axis([-10 10 -500 500])
title('Transformée de Fourier du Sinus (partie imaginaire)')
xlabel('Fréquence (Hz)')


subplot(3,1,3)
x2 = real(tfourinv(X2));
plot(range,x2)
title('Récupération de la fonction avec tfourinv');

saveas(f2, 'figures/fig_sin.png')

%% Fonction pic de Dirac (sans décalage temporel)
x3 = zeros(1,N); x3(1,N/2+1) = 1;

f3 = figure('Name', 'TF du Dirac');
subplot(2,1,1)
X3 = real(tfour(x3));
plot(freq, X3)
title('Transformée de Fourier du Dirac avec Δt = 0')
xlabel('Fréquence (Hz)')


subplot(2,1,2)
x3 = real(tfourinv(X3));
plot(range,x3)
title('Récupération de la fonction avec tfourinv');

saveas(f3, 'figures/fig_dirac_0.png')

%% Fonction pic de Dirac (avec décalage temporel)
delta_t = 0.005;
x3d = zeros(1,N); x3d(1, N/2+1 - round(delta_t/Te)) = 1;

X3d = tfour(x3d);
f3d = figure('Name', 'Dirac avec décalage temporel');
subplot(3,1,1)
plot(freq, real(X3d))
title(['Transformée de Fourier du Dirac avec Δt=',num2str(delta_t),' (partie réelle)'])
xlabel('Fréquence (Hz)')

subplot(3,1,2)
plot(freq, imag(X3d))
title(['Transformée de Fourier du Dirac avec Δt=',num2str(delta_t),' (partie imaginaire)'])
xlabel('Fréquence (Hz)')


subplot(3,1,3)
x3 = real(tfourinv(X3d));
plot(range,x3)
title('Récupération de la fonction avec tfourinv');

saveas(f3d, 'figures/fig_dirac_deltat.png')

%% Exponentielle complexe
x4 = exp(1i*2*pi*f*range);
f4 = figure('Name', 'Exponentielle complexe');

subplot(3,2,1)
plot(range, real(x4))
title('Exponentielle complexe : Partie Réelle')

subplot(3,2,2)
plot(range, imag(x4))
title('Exponentielle complexe : Partie Imaginaire')

X4 = tfour(x4);
subplot(3,2,[3,4])
plot(freq, real(X4))
title('Transformée de Fourier : Partie Réelle')
axis([-20 20 0 1000])
xticks([-20 -15 -10 -5 0 4 5 10 15 20])


subplot(3,1,3)
x4 = real(tfourinv(X4));
plot(range,x4)
title('Récupération de la fonction avec tfourinv');

saveas(f4, 'figures/fig_exp.png')

%% Fonction rectangle apériodique
x5 = zeros(1, N);
for i=1:N
    if(a + i*Te > -0.05 && a + i*Te < 0.05)
        x5(1,i) = 1;
    end
end

f5 = figure('Name', 'Fonction rectangle apériodique');
subplot(3,1,1)
plot(range, x5);
axis([-0.1 0.1 0 1.5])
title('Fonction rectangle apériodique')

subplot(3,1,2)
X5 = tfour(x5);
plot(freq, real(X5))
axis([-500 500 -100 400])
title('Transformée de Fourier de la fonction rectangle (partie réelle)')


subplot(3,1,3)
x5 = real(tfourinv(X5));
plot(range,x5)
axis([-0.1 0.1 0 1.5])
title('Récupération de la fonction avec tfourinv');

saveas(f5, 'figures/fig_rect.png')

%% Fonction rectangle périodique
x5p = ones(1,N);
periode = 0.2;
for i=1:N
    x = mod(a+i*Te, periode) - periode/2;
    
    if(x > -0.05 && x < 0.05)
        x5p(1,i) = 0;
    end
end

f5p = figure('Name', 'Fonction rectangle périodique');
subplot(3,1,1)
plot(range, x5p)
axis([-0.4 0.4 0 1.5])
title('Fonction rectangle périodique')

subplot(3,1,2)
X5p = tfour(x5p);
plot(freq, real(X5p))
axis([-500 500 -3500 17000])
title('Transformée de Fourier de la fonction rectangle périodique (partie réelle)')


subplot(3,1,3)
x5p = real(tfourinv(X5p));
plot(range,x5p)
axis([-0.4 0.4 0 1.5])
title('Récupération de la fonction avec tfourinv');

saveas(f5p, 'figures/fig_rect_per.png')
%% Courbe de Gauss
x6 = exp(-pi*range.^2);

f6 = figure('Name', 'Courbe de Gauss');
subplot(3,1,1)
plot(range, x6)
title('Courbe de Gauss')

subplot(3,1,2)
X6 = real(tfour(x6));
plot(freq, X6)
axis([-5 5 0 3500])
title('Transformée de Fourier')


subplot(3,1,3)
x6 = real(tfourinv(X6));
plot(range,x6)
title('Récupération de la fonction avec tfourinv');

saveas(f6, 'figures/fig_gauss.png')