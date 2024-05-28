function ans = continueCom(n,k,idx)
    ans = zeros(1,n);
    curNum = idx;
    for i = 1:k
        ans(idx) = 1;
        idx = idx + 1;
    end
end