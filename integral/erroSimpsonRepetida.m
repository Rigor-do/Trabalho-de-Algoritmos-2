%%
%% Integração numérica usando a regra 1/3 de Simpson repetida
%%
%% Input: a quarta derivada da função a ser integrada, os limites inferior 'a' e superior 'b' de integração
%%        o número 'n' de subdivisões. 
%% 
%% Output: Limite inferior do erro
%% Restrições:
%%		número 'n' de subdivisões tem que ser par
%%		derivada monôtona, i.e. maior valor em um dos limites
%%
%% https://pt.wikipedia.org/wiki/F%C3%B3rmula_de_Simpson
%%
function ESR_upperbound = erroSimpsonRepetida( dfuncd4, a, b, n )

	%% Decide se número é impar: Uso de uma função anônima
	% http://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html
	isodd = @(x) x-2*floor(x/2);

	if isodd( n )
		fprintf('Numero de subdivisoes n=%d. Tem que ser numero par !\n', n); %wait();
		ESR_upperbound = NaN;
		return;
	end
	fprintf('Erro de integracao pela Regra 1/3 de Simpson ');
	if n >=4 fprintf('repetida '), end;
	fprintf('no intervalo [%.2f,%.2f] com %d nos\n', a, b, n+1 );

	h = (b-a)/n;

	f = @(x) -dfuncd4(x);
	[Xmax, M4, ~, ~] = fminbnd (f, a, b);
	M4 = abs(M4);

	aux = (b-a)*h^4/180;
	ESR_upperbound = aux * M4;

	fprintf(';\n  (b-a)*h^4/180=(%.2f-%.2f)*%.2f^4/180=%f', b, a, h, aux);
	fprintf(';  M4 em %e=', Xmax); printdecandfrac( M4, false );
	fprintf(';  |E_SR%d| = ', n ); printdecandfrac( ESR_upperbound, true );
end

