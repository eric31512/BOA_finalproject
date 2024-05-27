function test(obj)% 測試用
    group = 1562275;
    type = 6;
    %appliance data
    combin=[6 ,9 ,15,16,16,10,26,12,18,18,6 ,4 ,4 ,14,8 ,6 ,6 ,6 ;
            4 ,3 ,1 ,6 ,8 ,5 ,8 ,4 ,7 ,3 ,3 ,2 ,2 ,4 ,4 ,2 ,2 ,2 ];%可不連續電器的組合種類
            %LD LD EK AC AC ED WP EO PH DW DW RC RC WM WM MW MW TT
    num = [2,3,5,6,7,8,9,11,13,15,17,18];%type 1~12的電器對應的combin位置
    power = [1.26,1.5,1,1.2,2,1.8,1.1,1.8,0.73,0.8,0.38,0.9,0.8];
    %連續非連續分開計算
    %準備計算組合的data
    if type == 1 || type == 3 || type == 8 || type == 9 || type == 10 || type == 11
        cur1 = num(type)-1
        cur2 = num(type)
        len = 2;
        n1 = combin(1,cur1)    
        n2 = combin(1,cur2)   
        k1 = combin(2,cur1)    
        k2 = combin(2,cur2)
        idx1 = factorial(n2)/(factorial(k2)*factorial(n2-k2))
    else 
        cur1 = num(type);
        len = 1;
        n1 = combin(1,cur1);
        k1 = combin(2,cur1);
    end
    %確認每個電器的消耗電量
    if type<3
        curP = [power(type),power(type)];
    elseif type == 3
        curP = [power(type),power(type+1)];
    else
        curP = [power(type+1),power(type+1)];
    end
    %計算結果
    if type <= 7
        if len == 2
            firstPart = floor((group + idx1 - 1) / idx1)
            secondPart =  mod(group,idx1)
            if secondPart==0 
                secondPart = idx1
            end
            first = curP(1)*getNthCombination(n1,k1,firstPart);
            second = curP(2)*getNthCombination(n2,k2,secondPart);
            ans = [first,second]
            curPower = toFourtyEight(ans,type)
        elseif len == 1
            ans = curP(1) * getNthCombination(n1,k1,group)
            curPower = toFourtyEight(ans,type)
        end
    else
    if type==12
    ans = continueCom(n1,k1,group);
    ans = toFourtyEight(ans,type);
    curPower = curP(1) * ans;
    else 
        if group > n2-k2+1
            first = curP(1) * continueCom(n1,k1,group);
            second = zeros(1,n2);
        else
            second = curP(1) * continueCom(n2,k2,group);
            first = zeros(1,n1);
        end
        ans = [first,second];
        curPower = toFourtyEight(ans,type);
    end
end