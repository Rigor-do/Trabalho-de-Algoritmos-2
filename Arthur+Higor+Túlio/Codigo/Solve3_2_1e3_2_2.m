% Trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% O trabalho é a reprodução de curvas estastíticas características, como FDA, FMP
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro
% Este é um dos documentos de solução das questões.

% A definição equação de phi será dividido em várias partes para calcular cada parte individualmente
phi = @(x, k) ( mean(x.^k.*log(x))/mean(x.^k) - mean(log(x))).^-1;
lambda = @(x, k) nthroot(mean(x.^k),k);

n = 1000; % numero de termos da primeira distribuição
vec_k(1) = 5; % k dado
vec_lambda(1) = 1; % lambda dado

fprintf(" Primeiro valor de lambda = %.2f, e de k = %.2f\n", vec_lambda(1), vec_k(1));

X = wblrnd_octave(vec_lambda(1), vec_k(1), ceil(sqrt(n))); % Gerado as amostras. n^1/2 pois o resultado é matrix nxn
x = X(1:1000); % Converte a matriz na brutalidade para vector. A função precisa receber um vetor, n matrix

vec_k(2) = phi(x, vec_k(1)); % nova estimativa
vec_lambda(2) = lambda(x, vec_k(1));

fprintf(" Estimativa do valor de lambda = %.2f, e de k = %.2f na 2 iteracao\n", vec_lambda(2), vec_k(2));