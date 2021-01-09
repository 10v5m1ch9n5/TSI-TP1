function [y] = gf(f, t)
%Fonction paramétrique g_f(t)
delta_f = 50;
y = sin(2*pi*f*t) + sin(2*pi*(f+delta_f)*t) + sin(2*pi*(f+2*delta_f)*t) + 2*sin(2*pi*(f+3*delta_f)*t);
end

