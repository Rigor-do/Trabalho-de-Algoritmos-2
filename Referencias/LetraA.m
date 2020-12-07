clear all;
close all hidden;

x_0 = 0;
y_0 = 1;

addpath(['../' 'util'], ['../' 'edo']);

% Questão 1
[f, sol, PVIstr, yx, yxstr] = solveEDO('-y', x_0, y_0);
fprintf ('1) '); sol

%Questão 2
fprintf ('2) ');yxstr

%Questão 3
n = 10;
h = 0.1;
x = 0:0.1:1;
hold on
figure(1)
plot (x, yx(x));
leg = {'y(x)'};
title ('EDO');

%Questão 4, 5
func = @(x,y) -y;
fx = zeros(1, n+1);
k = 0;
for i = 1:n+1
  fx(i) = yx(k);
  k = k + h;
end

%Euler
fprintf ('4) '); 
[X, Y] = Euler(func, x_0, y_0, h, n);
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Euler' );
figure (1)
plot(X,Y)
leg{end+1} = 'Euler';
legend(leg);
shg;


%Euler Melhorado

[X, Y] = EulerMelhorado(func, x_0, y_0, h, n);
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Euler Melhorado' );
plot(X,Y)
leg{end+1} = 'Euler Melhorado';
legend(leg);
shg;

%Euler Modificado

[X, Y] = EulerModificado(func, x_0, y_0, h, n);
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Euler Modificado' );
plot(X,Y)
leg{end+1} = 'Euler Modificado';
legend(leg);
shg;

%Genérico de 2 ordem com alfa = 1/3
[X, Y] = RungeKutta_GenericoSegundaOrdem(func, x_0, y_0, h, n, 1/3 );
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Generico de 2 ordem com a=1/3' );
plot(X,Y)
leg{end+1} = 'Generico de 2 ordem com a=1/3';
legend(leg);
shg;

%Genérico de 2 ordem com alfa = 1/4
[X, Y] = RungeKutta_GenericoSegundaOrdem(func, x_0, y_0, h, n, 1/4 );
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Generico de 2 ordem com a=1/4' );
plot(X,Y)
leg{end+1} = 'Generico de 2 ordem com a=1/4';
legend(leg);
shg;

%Dormand-Prince com passo fixo
[X, Y] = RungeKutta_Dormand_Prince_ode45(func, x_0, y_0, h, n, 1);
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Dormand-Prince com passo fixo' );
plot(X,Y)
leg{end+1} = 'Dormand-Prince com passo fixo';
legend(leg);
shg;

%Dormand-Prince com passo adaptativo
[X, Y] = RungeKutta_Dormand_Prince_ode45(func, x_0, y_0, h, n, 0);
printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Dormand-Prince com passo adaptativo' );
plot(X,Y)
leg{end+1} = 'Dormand-Prince com passo adaptativo';
legend(leg);
shg;


%Questão 6 - Erros
%Euler
fprintf ('6) \n'); 
[X, Y1] = Euler(func, x_0, y_0, h, n);
e = fx-Y1;
printTabXY (X, 'X', e, 'Erro', '%.5e', 'Erro: Euler' );
figure (2)
semilogy(X(2:11),e(2:11));
leg2 = 'Erro - Euler';
legend(leg2);
shg;

##
##%Euler Melhorado
##
##[X, Y] = EulerMelhorado(func, x_0, y_0, h, n);
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Euler Melhorado' );
##plot(X,Y)
##leg{end+1} = 'Euler Melhorado';
##legend(leg);
##shg;
##
##%Euler Modificado
## 
##[X, Y] = EulerModificado(func, x_0, y_0, h, n);
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Euler Modificado' );
##plot(X,Y)
##leg{end+1} = 'Euler Modificado';
##legend(leg);
##shg;
##
##%Genérico de 2 ordem com alfa = 1/3
##[X, Y] = RungeKutta_GenericoSegundaOrdem(func, x_0, y_0, h, n, 1/3 );
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Generico de 2 ordem com a=1/3' );
##plot(X,Y)
##leg{end+1} = 'Generico de 2 ordem com a=1/3';
##legend(leg);
##shg;
##
##%Genérico de 2 ordem com alfa = 1/4
##[X, Y] = RungeKutta_GenericoSegundaOrdem(func, x_0, y_0, h, n, 1/4 );
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Generico de 2 ordem com a=1/4' );
##plot(X,Y)
##leg{end+1} = 'Generico de 2 ordem com a=1/4';
##legend(leg);
##shg;
##
##%Dormand-Prince com passo fixo
##[X, Y] = RungeKutta_Dormand_Prince_ode45(func, x_0, y_0, h, n, 1);
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Dormand-Prince com passo fixo' );
##plot(X,Y)
##leg{end+1} = 'Dormand-Prince com passo fixo';
##legend(leg);
##shg;
##
##%Dormand-Prince com passo adaptativo
##[X, Y] = RungeKutta_Dormand_Prince_ode45(func, x_0, y_0, h, n, 0);
##printTabXY (X, 'X', Y, 'Y', '%5.2f', 'Dormand-Prince com passo adaptativo' );
##plot(X,Y)
##leg{end+1} = 'Dormand-Prince com passo adaptativo';
##legend(leg);
##shg;







