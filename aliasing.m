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
