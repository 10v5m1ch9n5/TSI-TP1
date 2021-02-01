%% Echantillonage de g1000 et g2250
fig_g = figure('Name', 'Fonction g1000(t)');
plotg(1000)
saveas(fig_g, 'figures/fig_g1.png')
fig_g2 = figure('Name', 'Fonction g2250(t)');
plotg(2250)
saveas(fig_g2, 'figures/fig_g2.png')

%% Valeurs de f donnant un simple sinus
a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

nbPics = 0;

disp('Fréquences pour lesquelles gf(t) est un simple sinus')
for f=0:16380
    g = gf(f, range);
    spectre = imag(tfour(g));
    %plot(freq, spectre)
    nbPics = 0;
    for i=1:N
        if(abs(spectre(1,i)) >= 1)
            nbPics = nbPics + 1;
        end
        if(nbPics > 2)
            break
        end
    end
    if(nbPics == 2)
        disp(f)
    end
    %disp(nbPics)
end

%% Fréquences intéressantes
%plotg(8117)
%plotg(16309)
%3201.8
%3226.8

f16334 = figure('Name', 'Valeur de f donnant un simple sinus');
plotg(16334)
saveas(f16334, 'figures/fig_f16334.png')

f_sin = figure('Name', 'Repliement de spectre');
a = -5;
b = 5;
N = 32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

f = 8142;
g = gf(f, range);
plot(range, g)
axis([-0.02 0.02 -5 5])
title('Fonction g(t)')

hold on

N = 0.5*32768;
Te = (b-a)/N;
fe = 1/Te;
range = a:Te:b-Te;
freq = -fe/2:fe/N:(fe/2 - fe/N);

g = gf(f, range);
plot(range, g)
axis([-0.02 0.02 -5 5])
title('Fonction g(t)')
hold off
saveas(f_sin, 'figures/fig_sin.png')

