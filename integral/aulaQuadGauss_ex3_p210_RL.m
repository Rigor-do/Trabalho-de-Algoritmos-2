
%======================================
% Integração numérica
% Autor: Thomas W. Rauber trauber@gmail.com , 2008 - 2020
%%======================================

clear all;
addpath(['../' 'util'], ['../' 'integral']);

is_octave = (exist('OCTAVE_VERSION','builtin')>1); % Octave ou Matlab
if is_octave
	available_graphics_toolkits();
	graphics_toolkit gnuplot;
	%graphics_toolkit qt;

	pkg load symbolic;
	%
	% Se o pacote 'symbolic' do Octave ainda não estiver instalado, pegue aqui:
	% https://octave.sourceforge.io/download.php?package=symbolic-2.7.0.tar.gz
	% instale com o comando dentro do Octave: pkg install symbolic-2.7.0.tar.gz
	%
end;

fig = gcf;	% handle to current figure
clf(fig);
close(fig);



fprintf('===== Aula Exemplo 1 =========\n');

% Definição da função f(x)
fprintf('Integracao analitica da funcao:');
syms f(x)
f(x) = exp(-x), fstr = 'exp(-x)';
a = sym(0);
b = sym(10);

%f(x) = sin(x), fstr = 'sen(x)';
%a = sym(0)
%b = sym(pi) /sym(2)


I = int(f)
I = int(f, a, b)
II = double(I);
fprintf('Integral analitica='), I
fprintf('= %15.10e', II);
ff = matlabFunction(f(x));
fprintf('\nFuncao numerica convertida:\n'); f
aa = double(a);
bb = double(b);
%xx = [aa bb]';
%yy = ff(xx);
%formstr = '%7.3f';
%printTabX( xx, 'x', formstr, 'Nos de integracao' );
%printTabX( yy, 'y', formstr, 'Valores y_i = f(x_i)' );

verbose = true;

%return
n = 1; % número de subdivisões
nmax = 2;
C = coefGaussLegendre( nmax );
[T, A] = tabelaAbcissasPesosGaussLegendre( C );
showGaussLegendre( C, T, A );
IGL = integralGaussLegendreFunc( ff, aa, bb, n, T, A, verbose );

Erro_QG2 = II - IGL;
fprintf('Erro de Quadratura Gaussiana para %d pontos = %15.10e - %15.10e = %15.10e\n',...
	n+1, II, IGL, II-IGL);


trapeziosPlot( f, fstr, aa, bb, [15], 'tmpTrapezio.eps' )
