function  [group]=GroupInit(max , min , R)
    % 生成隨機二維矩陣 R*2 matrix
    group=round(rand(R,1)*(max-min)+(ones(R,1)*min));  %max,min為1*2 matrix