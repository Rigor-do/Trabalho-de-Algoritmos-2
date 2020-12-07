 
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

% Definição da função f(x)=1/x
fprintf('Integracao analitica da funcao:');
syms f(x) df2dx2(x) h ET(x) ksi
f(x) = 1/x , fstr = '1/x';
%f(x) = -2*x^3 -x + 1 , fstr = '-2*x^3-x+1';
%f(x) = .25*x^5 -x^3 + 1 , fstr = '.25*x^5 -x^3 + 1';
a = sym(2);
b = sym(4);
I = int(f)
I = int(f, a, b)
II = double(I);
fprintf('Integral analitica='), I
fprintf('= %e', II);
ff = matlabFunction(f(x));
fprintf('\nFuncao numerica convertida:\n'); f
aa = double(a);
bb = double(b);

verbose = true;
%verbose = false;

if 1
%%%% T R A P É Z I O S %%%%
xx = [aa bb]';
yy = ff(xx);
formstr = '%7.3f';
printTabX( xx, 'x', formstr, 'Nos de integracao' );
printTabX( yy, 'y', formstr, 'Valores y_i = f(x_i)' );

ITR = integralTrapeziosRepetida( xx, yy, verbose )
subdivisoes = 1;
IT = integralTrapeziosRepetidaFunc( ff, xx(1), xx(end), subdivisoes, verbose )
ErrT = double(I)-IT;


fprintf('Segunda derivada da funcao:\n');
df2dx2(x) = diff(f(x), x, 2)
h = b - a
ET(x) = -h^3/12 * df2dx2(x)
ET(ksi)
fprintf('Problema, em geral é determinar o maior valor dentro do intervalo.');
s = solve(ET(x)==ErrT)
double(s)
abs(double(s))
%return

dfuncd2 = matlabFunction(df2dx2);
ETR_upperbound = erroTrapeziosRepetida( dfuncd2, aa, bb, subdivisoes );
printdecandfrac( ETR_upperbound, true );
fprintf('E_T = I - I_R = %e - %e = %e\n', II, IT, ErrT);
%return

for j=1:3
	ITR = integralTrapeziosRepetidaFunc( ff, xx(1), xx(end), j, false );
	fprintf('Trapezios com %d subdivisoes=%e  Erro=%e\n', j, ITR, double(I)-ITR);
end
trapeziosPlot( f, fstr, aa, bb, [1, 2, 3], 'testTrapezio.eps' )
end
%return

if 1
%%%% S I M P S O N %%%%
fprintf('\n\n === S I M P S O N ====\n');

ISR = integralSimpsonRepetida( xx, yy, verbose )
xx = [xx(1) (xx(1)+xx(end))/2 xx(end)];
yy = ff(xx);
printTabX( xx, 'x', formstr, 'Nos de integracao' );
printTabX( yy, 'y', formstr, 'Valores y_i = f(x_i)' );
ISR = integralSimpsonRepetida( xx, yy, verbose )
fprintf('Simpson 1/3 com %d subdivisoes=%e  Erro=%e\n', 2, ISR, II-ISR);

for j=1:6
	subdivisoes = j;
	ISR = integralSimpsonRepetidaFunc( ff, aa, bb, subdivisoes, verbose  );
	fprintf('Simpson 1/3 com %d subdivisoes=%e  Erro=%e\n', j, ISR, double(I)-ISR);
end
simpsonPlot( f, fstr, aa, bb, [2, 4, 6], 'testSimpson.eps' )

df4dx4(x) = diff(f(x), x, 4)
ESR_upperbound = erroSimpsonRepetida( matlabFunction(df4dx4), aa, bb, subdivisoes )
end
%return


if 1
%%%% Q U A D R A T U R A  G A U S S I A N A %%%%
fprintf('\n\n === Q U A D R A T U R A  G A U S S I A N A ====\n');

nmax = 5;
C = coefGaussLegendre( nmax );
[T, A] = tabelaAbcissasPesosGaussLegendre( C );
showGaussLegendre( C, T, A );

for n=1:nmax-1
	subdivisoes = n; % número de subdivisões
	IGL = integralGaussLegendreFunc( ff, aa, bb, n, T, A, verbose );
	Erro_QG2 = II - IGL;
	fprintf('Erro de Quadratura Gaussiana para %d pontos = %15.10e - %15.10e = %15.10e\n',...
		n+1, II, IGL, II-IGL);
end
end
