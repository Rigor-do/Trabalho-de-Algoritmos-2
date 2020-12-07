% Trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% O trabalho é a reprodução de curvas estastíticas características, como FDA, FMP
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro
% Este é um dos documentos de solução das questões.

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
