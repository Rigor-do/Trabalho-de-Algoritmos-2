function showGaussLegendre( C, T, A )
	disp('Coeficientes dos polin^omios de Gauss-Legendre')
	C

	plotPolLegendre( C );
	disp('--- T A B E L A  D E  A B C I S S A S  E  P E S O S  D E  G A U S S - L E G E N D R E ---');
	if isempty(T)
		fprintf('T = vazia\nA = vazia\n');
		return;
	end
	T
	A
end

