function simpsonPlot( f, fstr, a, b, nseq, epsfilename );


% Exemplo: simpsonPlot( f, 'exp(-x)', aa, bb, [2,4,6], 'lixo.eps' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% SUBPLOTS NOT WORKING %%%%%%%%%%%
% Have to generate figure for each case %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms x n

% Integral indefinida:
fprintf(1,'Funcao=%s Integral indefinida= ', fstr);
F = int(f, x)

I = int(f, x, a, b);    % Integração simbólica
II = double(I);
aa = double(a);
bb = double(b);
fprintf(1,'Integral definida em [a,b]=[%.2f,%.2f] = %.5e = \n', aa, bb, II);
I

DiffPrimitiva = F(b) - F(a)
confirm = isequaln(I, DiffPrimitiva);
fprintf(1,'Confirmacao: Diferenca das primitivas nos limites I = F(b)-F(a)= %s\n', boolStr(confirm))

ff = matlabFunction(f);

numcases = length(nseq);

% https://www.mathworks.com/help/matlab/ref/colormap.html
cmap = colormap('jet');
lmap = length(cmap);

close all;
ISR = zeros(numcases,1);
cnt = 1;
for i=1:numcases
    n = nseq(i);
    nn = double(n);
    ISR(i) = integralSimpsonRepetidaFunc( ff, aa, bb, nn, false );
    if ~isnan(ISR(i))
        figure('Name', sprintf('Simpson 1/3 com %d subdivisões', nn), 'NumberTitle', 'off');
        clf;	% clear current figure window
        hold on;
        
        fprintf('Integracao pela Regra 1/3 de Simpson ');
        if nn >=4 fprintf('repetida '), end;
        fprintf('no intervalo [%.2f,%.2f] com %d nos\n', aa, bb, nn+1 );

        h = (bb-aa)/nn;
        n2 = nn/2;
        nos = aa:h:bb

        titulo = sprintf('Integracao numerica: Simpson: f(x) = %s,\nI[%.2f,%.2f]=%.5e  I_{SR}_%d=%.5e\n|Erro|=%.5e',...
            fstr, aa, bb, II, nn, ISR(i), abs(II-ISR(i)) );

        handles = [];
        legenda = {};

        xx = aa:0.01:bb;
        ha = plot(xx, ff(xx), '--k', 'LineWidth', 1.5);
        legenda{end+1} = 'f(x)';
        handles = [handles ha];
        
        if nn == 1
            cmap1 = cmap(1,:);
        else
            delta = fix(lmap /(nn-1));
            cidx = 0:2*delta:lmap;
            cidx(1) = 1;
            %lmap, delta, cidx
            cmap1 = cmap(cidx,:); %, return
        end
    
        for k=0:n2-1
            k2 = k * 2;
            xk = nos(k2+1);
            xk1 = nos(k2+2);
            xk2 = nos(k2+3);
            X = nos(k2+1:k2+3);
            Y = ff(X);
            p = polyfit(X, Y, 2);
            xintval = xk:0.01:xk2;
            yy = polyval(p, xintval);
            ha = plot(xintval,yy);
            %fprintf(1,'c index=%d of %d\n', k2+1, lmap)
            c = cmap1(k+1,:);
            ha = area(xintval, yy, 'FaceColor', c); handles = [handles ha];
            legenda{end+1} = sprintf('Parabola %d de %d', k+1, n2);
            set (ha, 'FaceAlpha', 0.2);
            fprintf(1,'Subdivisao %d de %d: x_%d=%.2f, f(x_%d)=%.4e, x_%d=%.2f, f(x_%d)=%.4e, x_%d=%.2f, f(x_%d)=%.4e\n',...
                    k+1, n2, k, xk, k, Y(1), k+1, xk1, k+1, Y(2), k+2, xk2, k+2, Y(3));
            fprintf(1,'\tParabola: p_2(x)= %.2f %c %.2fx %c %.2fx^2\n', p(3), signChar(p(2)), abs(p(2)), signChar(p(1)), abs(p(1)));
            ha = line([xk xk],[0 Y(1)],'Marker','.','LineStyle','-','Color',[0 1 0], 'LineWidth', 1.5);
            ha = line([xk1 xk1],[0 Y(2)],'Marker','.','LineStyle','--','Color',[0 1 0], 'LineWidth', 1);
            ha = line([xk2 xk2],[0 Y(3)],'Marker','.','LineStyle','-','Color',[0 1 0], 'LineWidth', 1.5);
        end

        title(titulo, 'fontsize', 9);
        xlabel ('x'); 
        ylabel ('y');
        legend(handles, legenda);
        
        % ax = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off',...
        %     'Units','normalized', 'clipping' , 'off');
        % text(0.3, 0.98,'algum texto')
        shg; % Mostre a figura
        hold off;
        if strcmp(epsfilename(end-3:end), '.eps')
            fnam = epsfilename(1:end-4);
        else
            fnam = epsfilename;
        end
        fnam = [fnam '_' num2str(cnt) '.eps'];
        fprintf('Gerando grafico vetorial em arquivo EPS ''%s''...\n', fnam );
        print(fnam, '-depsc2');
    else
        fprintf('Integracao numerica: Simpson: %d nao eh número par ==> Sem grafico\n', i);
    end
    cnt = cnt + 1;
end


end
