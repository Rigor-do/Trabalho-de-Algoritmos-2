
% clear all;
% allPlots = findall(0, 'Type', 'figure');
% delete(allPlots);	% Apagar todos os gr�ficos existentes


% Vari�vel l�gica que cont�m a informa��o, se est� no ambiente Octave ou n�o
is_octave = (exist('OCTAVE_VERSION','builtin')>1); % Octave ou Matlab
if is_octave
	% pkg load odepkg			% Carregar pacote que cont�m solucionador ode45
	% Alternativa: colocar c�digo fonte 'ode45.m' no caminho
	pkg load symbolic;			% Carregar pacote que matematica simb�lica
	graphics_toolkit gnuplot;		% Para salvar figura de sa�da em formato EPS
end

% Defini��o da fun��o y(x) a ser obtida pela solu��o do ODE
% pode ter somente um par�metro

syms i(t) V R L I0 t0

ode = diff(i, t) == (V-i*R)/L;	% EDO

t0 = 0;
I0 = 0;
sol = dsolve(ode, i(t0)==I0);
if iscell(sol)
	Eq = sol{1};
else
	Eq = sol;
end

if is_octave
	funcI = rhs(Eq);
else
	funcI = Eq;
end
i = matlabFunction(funcI)

L = 1;
R = 1;
V = 1;

clf
hold on
leg = {};

tt = double(t0):0.01:10;
plot(tt, i(L, R, V, tt));
leg{end+1} = 'I(t)';
xlabel ('t');
ylabel ('I');

f = @(t,I) (V-I*R)/L; % RHS da EDO
fmt = '%.3e';
deltat = 1.0;
n = 10;
[X, Y] = EulerMelhorado(f, double(t0), double(I0), deltat, n );
printTabXY( X, 'X', Y, 'Y', fmt, 'Euler' );
plot(X, Y, 'r+');
leg{end+1} = 'Euler Melhorado';

hold off;

legend(leg);
shg;




