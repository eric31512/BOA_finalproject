function [ans] = toFourtyEight(power,type)
    ans = zeros(1,48);
    %appliance time
    combin=[19,38,13,37,1 ,33,25,19,29,1 ,19,41,13,37,17,37,23,27,13;
            24,46,17,46,16,48,34,44,40,18,36,46,16,40,30,44,28,32,18];%可不連續電器的組合種類
           %LD LD EK EK AC AC ED WP EO PH DW DW RC RC WM WM MW    TT
    num =  [2    ,4    ,6    ,7 ,8 ,9 ,10,12   ,14   ,16   ,17   ,19];%type 1~12的電器對應的combin位置 
    curNum = 1;
    if type == 1 || type == 2 || type == 3 || type == 8 || type == 9 || type == 10 || type == 11
        cur1 = num(type)-1;
        cur2 = num(type);
        str1 = combin(1,cur1)    
        str2 = combin(1,cur2)   
        end1 = combin(2,cur1)    
        end2 = combin(2,cur2)
        for i = str1 : end1
            ans(i) = power(curNum);
            curNum = curNum+1;
        end
        for i= str2 : end2
            ans(i) = power(curNum);
            curNum = curNum+1;
        end
    else 
        cur1 = num(type);
        len = 1;
        str1 = combin(1,cur1);
        end1 = combin(2,cur1);
        for i = str1 : end1
            ans(i) = power(curNum);
            curNum = curNum+1;
        end
    end
    
 end