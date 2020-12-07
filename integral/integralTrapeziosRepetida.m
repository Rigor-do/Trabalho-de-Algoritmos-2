%%
%% Integra��o num�rica usando a regra dos Trap�zios repetida
%% usando interpola��o polinomial global
%%
%% Input: n�s de interpola��o (x,y) , vari�vel l�gica, se solu��o deve ser explicada
%% 
%% Output: Integral num�rica do polin�mio definido por x e y equidistantes
%%
function ITR = integralTrapeziosRepetida( x, y, verbose )
%
% limites inferior 'a' e superior 'b' de interpola��o
% n�mero 'n' de subdivis�es
	n = length(x)-1; a = x(1); b = x(end);

  if verbose
    fprintf('Integracao pela Regra dos Trapezios ');
    if n >=2 fprintf('repetida '), end;
	  fprintf('no intervalo [%.2f,%.2f] com %d nos (%d subdivisoes)\n', a, b, n+1, n );
  end

	h = (b-a)/n;
	nos = a:h:b;

	limits = y(1) + y(end);	% f(x_0) + f(x_n), os dois valores que aparecem somente uma vez no somat�rio
	x = a + h;
	ITR = 0.0;
	for i=1:n-1
		ITR = ITR + y(i+1);
		x = x + h;
	end
	ITR = h/2 * (limits + 2 * ITR);

  if ~verbose
    return;
  end
	% Explicita��o did�tica
	fprintf('I_TR%d = h/2[ f(x0)+f(x%d)', n, n );
	for i=1:n-1
		if i==1 fprintf(' + 2{ '); end;
		fprintf('f(x%d)', i );
		if i==n-1 fprintf(' } ]\n'); else fprintf('+'); end;
	end
	if n==1 fprintf(']'); end;
	fprintf('       = %.2f/2[ f(%.2f)+f(%.2f)', h, a, b );
	for i=1:n-1
		if i==1 fprintf(' + 2{ '); end;
		fprintf('f(%.2f)', a+h*(2*i-1) ); if i==n-1 fprintf(' } ]\n'); else fprintf('+'); end;
	end
	if n==1 fprintf(']'); end;
	fprintf('       = %.3f[ %.3f+%.3f', h/2, y(1), y(end) );
	for i=1:n-1
		if i==1 fprintf(' + 2{ '); end;
		fprintf('%.3f', y(i+1) ); if i==n-1 fprintf(' } ]\n'); else fprintf('+'); end;
	end
	if n==1 fprintf(']'); end;
	fprintf(' = %.10f\n', ITR);
  printdecandfrac( ITR, true );
end

