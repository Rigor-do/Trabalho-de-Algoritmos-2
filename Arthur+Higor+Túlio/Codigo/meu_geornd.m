% Função meugeornd do trabalho 2 da matéria de Algoritmos Númericos para Engenharia feito em Octave.
% Usando Symbolic v2.9.0 e SymPy v1.5.1.
% Por Arthur Sorrentino, Higor Oliveira, Tulío Brunoro

% Sobre a função:
% Retorna n amostras de tentativas de Bernoulli com quantidade de insucessos
% antes do primeiro sucesso, dada a probabiliade P de sucesso da tentativa de Bernoulli.

function k = meu_geornd(P, n)

if(P <= 0 || n <= 0)
    printf('\nValores de P e n tem de ser positivos, inteiros e não nulos.\n')
    k = NaN;
    return;
end

semente = 1234567890; % Seed escolhida pelo professor
rand('seed', semente);

m = 1000+n; % Número de amostras para a distribuição uniforme
amostras = rand(ceil(sqrt(m))); % geração da matriz de valors aleatorios. O round é só para caso a pessoa escolha um valor com valor da raiz não inteira
% boll_vec = zeros(1,m); % Desnecessário a prealocação do vetor

bool_vec = amostras < P; % Filtro lógico do octave
k = zeros(1,n); % Pré alocagem de k

i = 1; j = 1; % i é o index que percorre o vetor de amostras e j é a posição no vetor de saída.
while (i < m && j < n) % Não extrapolar o vector e para quando atingir o número de sucessos n
    if (bool_vec(i))
        k(j) = k(j) + 1; % Falhei em implementar de forma mais compacta. Parecia não funcionar??
    else
        j = j + 1;
    end
    i = i + 1;
end

% print da comparação entre a probabilidade do resultado em comparação com a probabilidade real do evento.
if(1)
    P_estimado = n./(n+sum(k));
    printf(" Diferenca entre o valor estimado e real da probabilidade:\n");
    printf(" Valor estimado: %.5f", P_estimado);
    printf(" Valor real: %.5f", P);
    printf(" Erro: %.3e\n", abs(P_estimado - P));
end

return;