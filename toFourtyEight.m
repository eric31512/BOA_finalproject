function [ans] = toFourtyEight(power,type)
    %appliance time
    combin=[19,38,13,37,1 ,33,25,19,29,1 ,19,41,13,37,17,37,23,27,13;
            24,46,17,46,16,48,34,44,40,18,36,46,16,40,30,44,28,32,18];%可不連續電器的組合種類
           %LD LD EK EK AC AC ED WP EO PH DW DW RC RC WM WM MW    TT
    num =  [2    ,4    ,6    ,7 ,8 ,9 ,10,12   ,14   ,16   ,17   ,19];%type 1~12的電器對應的combin位置 
 
 
 end