% Trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% O trabalho é a reprodução de curvas estastíticas características, como FDA, FMP
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro
% Este é um dos documentos de solução das questões.

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
