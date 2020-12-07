% Trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% O trabalho é a reprodução de curvas estastíticas características, como FDA, FMP
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro
% Este é um dos documentos de solução das questões.

FDPWeibull = @(x, k, lambda) (k/lambda).*((x/lambda).^(k-1)).*exp(-(x/lambda).^k); % Definição das funções de FDP e FDA de Weibull
FDAWeibull = @(x, k, lambda) 1 - exp(-(x/lambda).^k);

a = 0; b = 1; % intervalos da integral
lambda2 = 1.0;
k2 =      5.0;
h = 0.01; % passo de x
x = a:h:2.5;
n = length(x);
x_igual_1 = a + 1/h + 1; % pega index da posição onde x = 1

wrapper_FDPWeibull = @(x) FDPWeibull(x, k2, lambda2); % define função de 1 variável fixando k e lambda

% Valores reais da função
FDAW2 = FDAWeibull(x, k2, lambda2);

% Definição dos vetores resultantes das integrações
TR_1 = zeros(1,n);
TR_4 = zeros(1,n);
TR_6 = zeros(1,n);
TR_10 = zeros(1,n);
SR_2 = zeros(1,n);
SR_4 = zeros(1,n);
SR_6 = zeros(1,n);
SR_10 = zeros(1,n);

% Legendas
coluna = {"I-TR-1", "I-TR-4", "I-TR-6", "I-TR-10", "I-SR-2", "I-SR-4", "I-SR-6", "I-SR-10"};
leg1 = {"Lambda = 1.0, k = 5.0", coluna{1:4}};
leg2 = {"Lambda = 1.0, k = 5.0", coluna{5:8}};

% Calculo dos valores aproximados
for i = 1:n
    % Método 1: integração por Trapézios usando a função pronta do professor
    TR_1(i) = integralTrapeziosRepetidaFunc(wrapper_FDPWeibull, a, x(i), 1, false);
    TR_4(i) = integralTrapeziosRepetidaFunc(wrapper_FDPWeibull, a, x(i), 4, false);
    TR_6(i) = integralTrapeziosRepetidaFunc(wrapper_FDPWeibull, a, x(i), 6, false);
    TR_10(i) = integralTrapeziosRepetidaFunc(wrapper_FDPWeibull, a, x(i), 10, false); 

    % Método 2: integração por Simpson 1/3 usando a função pronta do professor
    SR_2(i) = integralSimpsonRepetidaFunc(wrapper_FDPWeibull, a, x(i), 2, false);
    SR_4(i) = integralSimpsonRepetidaFunc(wrapper_FDPWeibull, a, x(i), 4, false);
    SR_6(i) = integralSimpsonRepetidaFunc(wrapper_FDPWeibull, a, x(i), 6, false);
    SR_10(i) = integralSimpsonRepetidaFunc(wrapper_FDPWeibull, a, x(i), 10, false);
end
resultados = [TR_1; TR_4; TR_6; TR_10; SR_2; SR_4; SR_6; SR_10;]; % Matrix resultados

% -------- Print da tabela
fprintf(" Tabela com resultados das aproximacoes de FDA com metodos de integracao\n");
% Definição da divisão
sep = repmat(['-'], 1, 50);
% Print da divisão
fprintf("%.40s\n", sep);
% Print da primeira linha
p1 = sprintf("%.28s", sprintf("%-28s", "Valor exato em x = 1"));
p2 = sprintf("%.14s", sprintf("%-14s", sprintf("%.3e",FDAW2(x_igual_1))));
linha = [p1 p2 '\n'];
fprintf(linha);
% Print da segunda linha
p1 = sprintf("%.14s", sprintf("%-14s", "Metodo"));
p2 = sprintf("%.14s", sprintf("%-14s", "Valor"));
p3 = sprintf("%.14s", sprintf("%-14s", "Erro"));
linha = [p1 p2 p3 '\n'];
fprintf(linha);
% Print da divisão
fprintf("%.40s\n", sep);
% Print das linhas de resultado
for i = 1:8
    nome = sprintf(coluna{i});
    p1 = sprintf("%.14s", sprintf("%-14s", nome));
    p2 = sprintf("%.14s", sprintf("%-14s", sprintf("%.3e",-resultados(i, x_igual_1))));
    p3 = sprintf("%.14s", sprintf("%-14s", sprintf("%.3e",-resultados(i, x_igual_1)+FDAW2(x_igual_1))));
    linha = [p1 p2 p3 '\n'];
    fprintf(linha)
end
% Print da divisão
fprintf("%.40s\n\n", sep);
% -------- Fim print da tabela

% Plots dos gráficos
figure ('name', 'FDA e FDA por integracao numerica: Trapezios') % Plots da FDA de Weibull
plot(x, FDAW2, '-g--');
hold on;
plot(x, TR_1, '-r-');
plot(x, TR_4, '-c-');
plot(x, TR_6, '-m-');
plot(x, TR_10, '-g-');
hold off;
title("Distribuicao de Weibull: FDA e FDA por integracao numerica: Trapezios");
legend(leg1,'Location','northwest');

fprintf(" Plotando os graficos de FDA de Weibull e aproximacoes de trapezios.\n");
pause(0.1); % Pause para forçar render dos gráficos

figure ('name', 'FDA e FDA por integracao numerica: Simpson 1/3') % Plots da FDA de Weibull
plot(x, FDAW2, '-g--');
hold on;
plot(x, SR_2, '-r-');
plot(x, SR_4, '-c-');
plot(x, SR_6, '-m-');
plot(x, SR_10, '-g-');
title("Distribuicao de Weibull: FDA e FDA por integracao numerica: Simpson 1/3");
legend(leg2,'Location','northwest');
hold off;

fprintf(" Plotando os graficos de FDA de Weibull e aproximacoes de Simpson.\n");
pause(0.1); % Pause para forçar render dos gráficos