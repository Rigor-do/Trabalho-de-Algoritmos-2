%%
%% Dado o grau do polinômio de Legendre e um argumento x calcula L_n(x)
%% Input: Matriz com o coeficientes de todos os pol de Legendre, Grau n, argumento x
%% Output: L_n(x)
%%
function L = polLegendre( C, n, x )
	L = zeros(1,size(x,2));	% inicializar polinômio com 0 (x pode ser um vetor de valores)
	pot = ones(1,size(x,2));
	for k = 0:n
		L = L + C(n+1,k+1) .* pot;
		pot = pot .* x;
	end
end

