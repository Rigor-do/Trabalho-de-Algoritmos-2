% Trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% O trabalho é a reprodução de curvas estastíticas características, como FDA, FMP
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro

close all; % Fecha janelas de plot abertas
clear all; % Limpeza do ambiente
%close all hidden % Limpeza mais detalhada

addpath(['../' '../' 'util'], ['../' '../' 'edo'], ['../' '../' 'integral']); % Inserção das funções auxiliares
available_graphics_toolkits(); % Adiciona um pacote de alteração do gráfico
graphics_toolkit gnuplot;

% ------------------------------- 2.1 -------------------------------
fprintf("\n--------------- Solucao - 2.1 ---------------\n");
FProb = @(n,p) ((1-p).^n)*p; % Definição da função de probabilidade pra facilitar no futuro.
n = 0:1:10; % Vetor de valores de amostras, será usado também futuramente nos plots

FMP = zeros(length(n), 3); % Matriz resultados das funções. Colunas são os resultados para facilitar o print futuramente

FMP(:,1) = FProb(n, 1/5); % resultado ja aplicação da função para os 3 diferentes casos
FMP(:,2) = FProb(n, 1/2);
FMP(:,3) = FProb(n, 4/5);
leg = {"P = 1/5", "P = 1/2", "P = 4/5"};

figure ('name','Funcao FMP para diferentes probabilidades.'); % Primeiros plots
plot(n, FMP(:,1), 'om--');
hold on;
plot(n, FMP(:,2), 'og--');
plot(n, FMP(:,3), 'or--');
title('Funcao FMP para diferentes probabilidades.');
legend(leg);

fprintf(" Plotando os graficos de FMP\n");
pause(0.1); % Pause para forçar render dos gráficos

for j = 1:length(FMP(1,:)) % Calculo das probabilidades acumuladas de cada função.
    for i = 1:length(FMP(:,j))
        FDA(i,j) = sum(FMP(1:i,j)); % Sum equivale a integral para períodos discretos
    end
end

figure ('name', 'Funcao FDA para diferentes probabilidades.'); % Segundos plots
plot(n, FDA(:,1), 'om-');
hold on;
plot(n, FDA(:,2), 'og-');
plot(n, FDA(:,3), 'or-');
title('Funcao FDA para diferentes probabilidades.');
legend(leg, 'Location','southeast');

fprintf(" Plotando os graficos de FDA\n");
pause(0.1); % Pause para forçar render dos gráficos

figure ('name','Funcao FMP em escala semilog para diferentes probabilidades.'); % Terceiro, da escala em semilog
semilogy(n, FMP(:,1), 'om--');
hold on;
semilogy(n, FMP(:,2), 'og--');
semilogy(n, FMP(:,3), 'or--');
title('Funcao FDA para diferentes probabilidades em semilog de y.');
legend(leg, 'Location','southwest');

fprintf(" Plotando os graficos de FDA em escala de semilog.\n");
pause(0.1); % Pause para forçar render dos gráficos

% ------------------------------- 2.1.1 -------------------------------
fprintf("\n--------------- Solucao - 2.1.1 -------------\n");
printf('Chamando funcao meu_geornd com P = 0.5 e n = 20.\n')
printf('meu_geornd(0.5,20)\n')
k = meu_geornd(0.5,20);
printf('Retorno: ');
k

% ------------------------------- 3.1 -------------------------------
fprintf("\n--------------- Solucao - 3.1 ---------------\n");
FDPWeibull = @(x, k, lambda) (k/lambda).*((x/lambda).^(k-1)).*exp(-(x/lambda).^k); % Definição das funções de FDP e FDA de Weibull
FDAWeibull = @(x, k, lambda) 1 - exp(-(x/lambda).^k);

lambda = [1.0 1.0 1.0 1.0 2.0 2.0]; 
k =      [0.5 1.0 2.0 5.0 1.0 5.0];
x = 0:0.01:4; 

for i = 1:length(lambda)
    leg3{i} = sprintf([sprintf('lambda = %.1f', lambda(i)) sprintf(', k = %.1f', k(i))]);
end

FDPW = zeros(length(x), length(lambda)); % Pre alocagem da matriz com os valores de FMP da distribuição de Weibull

for i = 1:length(lambda)
    FDPW(:, i) = FDPWeibull(x, k(i), lambda(i));
end

figure ('name', 'Distribuicao de Weibull: FDP.') % Plots da FDP de Weibull
plot(x(2:length(x)), FDPW(2:length(FDPW(:,1)),1), '-b-');% Pulando o primeiro termo, que deve ser infinito
hold on;
plot(x, FDPW(:,2), '-r-');
plot(x, FDPW(:,3), '-m-');
plot(x, FDPW(:,4), '-g-');
plot(x, FDPW(:,5), '-c-');
plot(x, FDPW(:,6), '-y-');
hold off;
title('Distribuicao de Weibull: FDP.');
legend(leg3);
ylim([0, 2]);

fprintf(" Plotando os graficos de FDP da distribuicao de Weibull.\n");
pause(0.1); % Pause para forçar render dos gráficos

for i = 1:length(lambda)
    FDAW(:, i) = FDAWeibull(x, k(i), lambda(i));
end

figure ('name', 'Distribuicao de Weibull: FDA.') % Plots da FDA de Weibull
plot(x, FDAW(:,1), '-b-');
hold on;
plot(x, FDAW(:,2), '-r-');
plot(x, FDAW(:,3), '-m-');
plot(x, FDAW(:,4), '-g-');
plot(x, FDAW(:,5), '-c-');
plot(x, FDAW(:,6), '-y-');
hold off;
title('Distribuicao de Weibull: FDA.');
legend(leg3,'Location','southeast');

fprintf(" Plotando os graficos de FDA da distribuicao de Weibull.\n");
pause(0.1); % Pause para forçar render dos gráficos

% ------------------------------- 3.1.1 e 3.1.2 -------------------------------
fprintf("\n--------------- Solucao - 3.1.1 e 3.1.2 ---------------\n");
%FDAWeibull = @(x, k, lambda) 1 - exp(-(x/lambda).^k); % Definição das funções de FDP e FDA de Weibull

a = 0; b = 1;
lambda2 = 1.0;
k2 =      5.0;
h = 0.001;
x = a:h:2.5;
n = length(x);
x_igual_1 = a + 1/h + 1;

wrapper_FDPWeibull = @(x) FDPWeibull(x, k2, lambda2);

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
resultados = [TR_1; TR_4; TR_6; TR_10; SR_2; SR_4; SR_6; SR_10;];

fprintf(" Tabela com resultados das aproximacoes de FDA com metodos de integracao\n");
% Definição da divisão
sep = repmat(['-'], 1, 50);
% Print da divisão
fprintf("%.40s\n", sep);
% Print da primeira linha
p1 = sprintf("%.28s", sprintf("%-28s", "Valor exato em x = 1"));
p2 = sprintf("%.14s", sprintf("%-12s", sprintf("%.3e",FDAW2(x_igual_1))));
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
fprintf("%.40s\n", sep);

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

% ------------------------------- 3.1.2 -------------------------------