%%
%% Integração numérica usando a regra 1/3 de Simpson repetida
%%
%% Input: nós de interpolação (x,y)
%% 
%% Output: Integral numérica do polinómio definido por x e y equidistantes
%%
%% Restrições: número 'n' de subdivisões tem que ser par
%
%%
function ISR = integralSimpsonRepetida( x, y, verbose )
	n = length(x)-1; %  o número 'n' de subdivisões
	a = x(1); b = x(end);

  if verbose
	fprintf('Integracao pela 1/3 de Simpson ');
	if n >=2 fprintf('repetida '), end;
	fprintf('no intervalo [%.2f,%.2f] com %d nos\n', a, b, n+1 );
  end

	%% Decide se número é impar: Uso de uma função anônima
	% http://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html
	isodd = @(x) x-2*floor(x/2);

	ISR = 0.0;
	if isodd( n )
		fprintf('Numero de subdivisoes n=%d. Tem que ser numero par ! Retornando NaN\n', n); % wait();
		ISR = NaN;
		return;
	end
% limites inferior 'a' e superior 'b' de interpolação
	a = x(1); b = x(end);
	fprintf('Integracao pela Regra 1/3 de Simpson ');
	if n >=4 fprintf('repetida '), end;
	fprintf('no intervalo [%.2f,%.2f] com %d nos\n', a, b, n+1 );

	h = (b-a)/n;
	nos = a:h:b;
	x = a + h;
	limits = y(1) + y(end);
	sumodd = 0.0; sumeven = 0.0;
	n2 = n/2; h2 = h*2;
	for i=1:n2
		sumodd = sumodd + y(2*i);
		x = x + h2;
	end
	x = a + h2;
	for i=1:n2-1
		sumeven = sumeven + y(2*i+1);
		x = x + h2;
	end
	ISR = h/3 * (limits + 4*sumodd + 2*sumeven);

    if ~verbose
      return;
    end
	% Explicitação didática
	fprintf('I_SR%d = h/3[ f(x0)+f(x%d) + 4{ ', n, n );
	for i=1:n2
		fprintf('f(x%d)', 2*i-1 ); if i==n2 fprintf(' }'); else fprintf('+'); end;
	end
	if n2 > 1 fprintf(' + 2{ '), end;
	for i=1:n2-1
		fprintf('f(x%d)', 2*i ); if i==n2-1 fprintf(' }'); else fprintf('+'); end;
	end
	fprintf(' ]\n');
	
	fprintf('       = %.2f/3[ f(%.2f)+f(%.2f) + 4{ ', h, a, b );
	for i=1:n2
		fprintf('f(%.2f)', a+h*(2*i-1) ); if i==n2 fprintf(' }'); else fprintf('+'); end;
	end
	if n2 > 1 fprintf(' + 2{ '), end;
	for i=1:n2-1
		fprintf('f(%.2f)', a+h*(2*i) ); if i==n2-1 fprintf(' }'); else fprintf('+'); end;
	end
	fprintf(' ]\n');
	
	fprintf('       = %.3f[ %.3f+%.3f + 4{ ', h/3, y(1), y(end) );
	for i=1:n2
		fprintf('%.3f', y(2*i) ); if i==n2 fprintf(' }'); else fprintf('+'); end;
	end
	if n2 > 1 fprintf(' + 2{ '), end;
	for i=1:n2-1
		fprintf('%.3f', y(2*i+1) ); if i==n2-1 fprintf(' }'); else fprintf('+'); end;
	end
	fprintf(' ] = %.10f\n', ISR);
	
	numcasas = 6;
	
	fprintf('       = %s [ %s + %s + 4{ ', dec2fracstr(h/3, numcasas),...
			dec2fracstr(y(1), numcasas),...
			dec2fracstr(y(n), numcasas) );
	for i=1:n2
		fprintf('%s', dec2fracstr( y(2*i), numcasas) ); if i==n2 fprintf(' }'); else fprintf('+'); end;
	end
	if n2 > 1 fprintf(' + 2{ '), end;
	for i=1:n2-1
		fprintf('%s', dec2fracstr(y(2*i+1), numcasas) ); if i==n2-1 fprintf(' }'); else fprintf('+'); end;
	end
	fprintf(' ] = '); printdecandfrac( ISR, true );
end
