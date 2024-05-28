function  [fitvalue]=fitFunction(group)
    Max=[1260   , 15    , 103062960  , 252   , 1562275   , 495   , 31824     , 64    , 9         , 16    , 10    , 5];
    Min=[1      , 1     , 1          , 1     , 1         , 1     , 1         , 1     , 1         , 1     , 1     , 1];
    %    烘衣機  熱水壺    冷氣         電熱器   加壓馬達     烤箱    PHEV        洗碗機   煮飯機      洗衣機   微波爐  烤土司機

    Indx_max=group>Max;    %建立一個陣列其元素為group(i,:)是否大於MAX
    Indx_min=group<Min;    %建立一個陣列其元素為group(i,:)是否小於MIN
    group=(group.*(~(Indx_max+Indx_min)))+Max.*Indx_max+Min.*Indx_min;
    totalPower=zeros(1,48);
    for i = 1:12
        curPower=Power(group(i),i); %將編號轉換為原始編碼型態
        totalPower = totalPower+curPower;   %將結果存入totalPower
    end
    loadcheck = LoadCheck(totalPower);  %檢查是否超過電力負載
    if loadcheck == true
        fitvalue=inf;   %若發現則將此一族群的fitvalue設為無限大
    else
        avg = sum(totalPower)/48;
        totalPower = abs(totalPower - avg);
        fitvalue = sum(totalPower/avg);
    end
end

