%%
%% Integração numérica usando a regra dos trapézios repetida
%%
%% Input: a segunda derivada da função a ser integrada, os limites inferior 'a' e superior 'b' de integração
%%        o número 'n' de subdivisões. 
%% 
%% Output: Limite inferior do erro
%% Restrições:
%%		derivada monôtona, i.e. maior valor em um dos limites
%%
function ETR_upperbound = erroTrapeziosRepetida( dfuncd2, a, b, n )

	fprintf('Erro de integracao pela Regra trapezios ');
	if n >=2 fprintf('repetida '), end;
	fprintf('no intervalo [%.2f,%.2f] com %d nos\n', a, b, n+1 );

	h = (b-a)/n;

	f = @(x) -dfuncd2(x);
	[Xmax, M2, ~, ~] = fminbnd (f, a, b)
	M2 = abs(M2);
	ETR_upperbound = 	n*h^3/12 * M2;

	fprintf('|M2| em %e=', Xmax); printdecandfrac( M2, true );
	fprintf('|E_TR%d| = ', n ); printdecandfrac( ETR_upperbound, true );
end

