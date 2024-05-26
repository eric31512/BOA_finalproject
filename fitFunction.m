function  [fitvalue]=fitFunction(group)
    totalPower=zeros(1,48);
    for i = 1:12
        curPower=Power(group(i),i); %將編號轉換為原始編碼型態
        totalPower = totalPower+curPower;   %將結果存入totalPower
        loadcheck = LoadCheck(totalPower);  %檢查是否超過電力負載
        if loadcheck == true
            fitvalue=inf;   %若發現則將此一族群的fitvalue設為無限大
            break;
        end
    end
end

