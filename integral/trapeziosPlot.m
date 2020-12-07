function trapeziosPlot( f, fstr, a, b, nseq, epsfilename );

% Exemplo: trapeziosPlot( f, 'exp(-x)', aa, bb, [1,2,3], 'lixo.eps' )

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



%is_octave = (exist('OCTAVE_VERSION','builtin')>1); % Octave ou Matlab

numcases = length(nseq);

%  lightblue = [180/255 200/255 220/255];
%  lightgreen = [175/255 208/255 149/255];
%  lightyellow = [255/255 255/255 166/255];

% https://www.mathworks.com/help/matlab/ref/colormap.html
cmap = colormap('jet');
lmap = length(cmap);
%  if numcases == 1
%      cmap = cmap(1,:);
%  else
%      delta = fix(lmap /(numcases-1));
%      cidx = 0:delta:lmap;
%      cidx(1) = 1;
%      %lmap, delta, cidx
%      cmap = cmap(cidx,:); %, return
%  end


ITR = zeros(numcases,1);

close all;
for i=1:numcases
    n = nseq(i);
    nn = double(n);

    ITR(i) = integralTrapeziosRepetidaFunc( ff, aa, bb, nn, false );

    titulo = sprintf('Integracao numerica: Trapezios: f(x) = %s,\nI[%.2f,%.2f]=%.5e  I_{TR}_%d=%.5e\n|Erro|=%.5e',...
            fstr, aa, bb, II, nn, ITR(i), abs(II-ITR(i)) );

    figure('Name', sprintf('Trapezios com %d subdivisoes', nn), 'NumberTitle', 'off');
    clf;	% clear current figure window
    hold on;
    
    fprintf('Integracao pela Regra dos Trapezios ');
    if nn >=2 fprintf('repetida '), end;
    fprintf('no intervalo [%.2f,%.2f] com %d nos\n', aa, bb, nn+1 );

    h = (bb-aa)/nn;
    nos = aa:h:bb

    titulo = sprintf('Integracao numerica: Trapezios: f(x) = %s,\nI[%.2f,%.2f]=%.5e  I_{TR}_%d=%.5e\n|Erro|=%.5e',...
        fstr, aa, bb, II, nn, ITR(i), abs(II-ITR(i)) );

    handles = [];
    legenda = {};

    xx = aa:0.01:bb;
    ha = plot(xx, ff(xx), '--k', 'LineWidth', 1.5);
    legenda{end+1} = 'f(x)';
    handles = [handles ha];
    
    % Pintar área abaixo de curva de função entre limites inferior e superior
%      ha = area(xx, ff(xx), 'FaceColor', [0.5 0.5 0.5]);
%      set (ha, 'FaceAlpha', 0.5);
%      legenda{end+1} = 'Integral';
%      handles = [handles ha];
%  %  %      fmin = min(ff(xx));
%  %  %      fmax = max(ff(xx));
    if nn == 1
        cmap1 = cmap(1,:);
    else
        delta = fix(lmap /(nn-1));
        cidx = 0:delta:lmap;
        cidx(1) = 1;
        %lmap, delta, cidx, cmap
        cmap1 = cmap(cidx,:); %, return
    end

    for k=0:nn-1
        xk = nos(k+1);
        xk1 = nos(k+2);
        fk = ff(xk);
        fk1 = ff(xk1);
        fprintf(1,'Subdivisao %d de %d: x_%d=%.2f, f(x_%d)=%.4e, x_%d=%.2f, f(x_%d)=%.4e\n',...
                k+1, nn, k, xk, k, fk, k+1, xk1, k+1, fk1);
        ha = line([xk xk],[0 fk],'Marker','.','LineStyle','-','Color',[0 1 0], 'LineWidth', 1.5);
        ha = line([xk1 xk1],[0 fk1],'Marker','.','LineStyle','-','Color',[0 1 0], 'LineWidth', 1.5);
        ha = line([xk xk1],[fk fk1],'Marker','.','LineStyle','-','Color',[0 1 0], 'LineWidth', 1.5);

        % Definição da reta = polinômio de grau um do trapézio
        lado = @(x) (x*(fk1-fk) + fk*xk1 - fk1*xk) / h;
        xintval = xk:0.01:xk1;
        %c = 'red';
        c = cmap1(k+1,:);
        ha = area(xintval, lado(xintval), 'FaceColor', c);
        handles = [handles ha];
        legenda{end+1} = sprintf('Trapezio %d de %d', k+1, nn);
        set (ha, 'FaceAlpha', 0.5);
    end

    title(titulo, 'fontsize', 9);
    xlabel ('x'); 
    ylabel ('y');
    [hleg, hleg_obj, hplot, labels] = legend(handles, legenda);
    for j=2:length(hplot)
        ha = hplot(j);
        set (ha, 'FaceAlpha', 0.5);
        %fprintf('hplot(%d)=', j); ha
    end
    %set (hleg_obj(4), 'FaceAlpha', 0.1);
    
    shg; % Mostre a figura
    hold off;
    if strcmp(epsfilename(end-3:end), '.eps')
        fnam = epsfilename(1:end-4);
    else
        fnam = epsfilename;
    end
    fnam = [fnam '_' num2str(i) '.eps'];
    fprintf('Gerando grafico vetorial em arquivo EPS ''%s''...\n', fnam );
    print(fnam, '-depsc2');

end


end
