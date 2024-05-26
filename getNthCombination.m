function comb = getNthCombination(n, k, idx)
    combinations = nchoosek(1:n, k);
    comb = zeros(1,n);
    target = combinations(idx,:)
    for i = 1 : length(target);
        cur = target(i);
        comb(cur) = 1;
    end
    disp(comb);
end