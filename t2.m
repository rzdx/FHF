rng('default');

D=15;
NP=50;
lb=-5;
ub=5;
for kkk=1:30

% Initialize population

    LHS = rand(D, NP);
    
    X = zeros(D, NP);
    for i = 1 : NP
        X(:, i) = lb + (ub - lb) .* LHS(:, i);
    end


% Evaluation

f = zeros(1, NP);
for i = 1 : NP
    f(i) = feval(['bbob2012.bbob12_f',num2str(17)], X(:, i));
end


% Initialize variables
V = X;
U = X;
countiter=0;
F=0.7;
CR=0.8;
while countiter<=3000
    % Mutation
    for i = 1 : NP
        r1 = floor(1 + NP * rand);
        r2 = floor(1 + NP * rand);
        r3 = r2;
        
        while r2 == r3
            r3 = floor(1 + NP * rand);
        end

        V(:, i) = X(:, r1) + (F + 0.01 * randn) * (X(:, r2) - X(:, r3));
    end
    
    for i = 1 : NP
        % Binominal Crossover
        jrand = floor(1 + D * rand);
        for j = 1 : D
            if rand < CR || j == jrand
                U(j, i) = V(j, i);
            else
                U(j, i) = X(j, i);
            end
        end
    end
       
    % Selection

    for i = 1 : NP
        fui = feval(['bbob2012.bbob12_f',num2str(17)], U(:, i));
        
        if fui < f(i)
            f(i) = fui;
            X(:, i) = U(:, i);
        end
    end
    % Iteration counter
    min(f)
    countiter = countiter + 1
end

[fmin, fminidx] = min(f);
xmin = X(:, fminidx);

fmin-feval(['bbob2012.bbob12_f',num2str(17)],'xopt')
end