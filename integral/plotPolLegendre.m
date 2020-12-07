% C = coefGaussLegendre( nmax ); [T, A] = tabelaAbcissasPesos( C );showGaussLegendre( C, T, A );

function plotPolLegendre( C )
	%pause(1);	% Give gnuplot some time
	clf;
	axis([-1.1 1.5 -1.1 1.1]);
	x = -1.0:0.01:1.0;

	hold on;
	legenda = {};
	nmax = size(C,1);
	if nmax == 1
		axis([-1 1 0 2]);
	end
	plot(x, repmat([0],1,length(x)),'-.');
	legenda{end+1} = '0';

	for n=1:nmax
		plot( x, polLegendre( C, n-1, x ) );
		legenda{end+1} = sprintf('L_{%d}(X)', n-1 );
	end
	hold off;
	grid;
	xlabel( 'x' );
	ylabel( 'y' );
	legend(legenda);
	title('Polinomios de Legendre');
	shg;
end

