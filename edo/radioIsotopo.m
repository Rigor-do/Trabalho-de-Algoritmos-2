
clear all;

addpath(['../' 'util'], ['../' 'edo']);

is_octave = (exist('OCTAVE_VERSION','builtin')>1); % Octave ou Matlab
if is_octave
	pkg load symbolic;
end;


% Não funciona com estes símbolos
% syms N(t) lambda
% ode = diff(N, t) == -lambda * N


syms y(x) lambda
ode = diff(y, x) == -lambda * y
sol = dsolve(ode)

if iscell(sol)
	Eq = sol{1};
else
	Eq = sol;
end

if is_octave
	F = rhs(Eq);
else
	F = Eq;
end
f = matlabFunction(F);
disp('y: EDO='); ode
disp('y(x)='); f

x = 0:0.1:5;
N0 = 100;
lambda = 0.5;
y = f(N0, lambda, x);


hold on
leg = {};
x = 0:0.01:5;

clf
hold on
leg = {};

lambda = [10 5 1 0.5 0.1];
for i=1:length(lambda)
	y = f(N0, lambda(i), x);
	plot(x, y);
	leg{end+1} = sprintf('N(t) = %.2f exp(-%.2f * t)', N0, lambda(i));
end

title('EDO: dN(t)/dt = -lambda * N(t) Valor inicial: N(0)=N0 --- Solucao: N(t) = N0 exp(-lambda t)');

hold off;
legend(leg);

shg;
