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
Solve2_1;

fprintf("\nAperte enter para continuar");
pause();
% ------------------------------- 2.1.1 -------------------------------
fprintf("\n--------------- Solucao - 2.1.1 -------------\n");
Solve2_1_1

fprintf("\nAperte enter para continuar");
pause();
% ------------------------------- 3.1 -------------------------------
fprintf("\n--------------- Solucao - 3.1 ---------------\n");
Solve3_1

fprintf("\nAperte enter para continuar");
pause();
% ------------------------------- 3.1.1 e 3.1.2 -------------------------------
fprintf("\n--------------- Solucao - 3.1.1 e 3.1.2 ---------------\n");
Solve3_1_1e3_1_2

fprintf("\nAperte enter para continuar");
pause();
% ------------------------------- 3.2.1 e 3.2.2 -------------------------------
fprintf("\n--------------- Solucao - 3.2.1 e 3.2.2 ---------------\n");
Solve3_2_1e3_2_2

fprintf("\n\n Finalizando... \n");