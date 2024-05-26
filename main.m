function main(obj)
    %set-------
    %各電器可能運行時間個數
    Max=[1260   , 15    , 93693600  , 252   , 40920     , 495   , 265720    , 64    , 9         , 16    , 10    , 5];
    Min=[1      , 1     , 1         , 1     , 1         , 1     , 1         , 1     , 1         , 1     , 1     , 1];
    %    烘衣機  熱水壺    冷氣        電熱器   加壓馬達     烤箱    PHEV        洗碗機   煮飯機      洗衣機   微波爐  烤土司機

    groupNum = 75;  %族群數
    dimention = 12;  %變數個數    c:\Users\User\Desktop\BOA_implement\groupInit.m
    totalIter=50;   %遞迴數
    %----------
    group=GroupInit(Max,Min,groupNum);
    Best_sol=inf;
    Convergence=zeros(1,totalIter);

    for C = 1:totalIter
        %取出最佳值與最佳族群
        % For limiting out of bound solutions and setting best solution and
        % objective function value
        for i=1:size(group,1) 
            %檢查是否有超出範圍的族群 
            Indx_max=group(i,:)>Max;    %建立一個陣列其元素為group(i,:)是否大於MAX
            Indx_min=group(i,:)<Min;    %建立一個陣列其元素為group(i,:)是否小於MIN
            group(i,:)=(group(i,:).*(~(Indx_max+Indx_min)))+Max.*Indx_max+Min.*Indx_min;
                                    %若group在範圍外設為0    並將其設為範圍最大or最小值
            %評估各族群的fitvalue
            fitness=fitFunction(group(i,:));
            %儲存最佳解及最佳族群
            if(Best_sol>fitness)
                Best_sol=fitness;
                Best_X=group(i,:);
            end
        end
        theta = C/totalIter;
        %pedal scent marking behavior begin

        %取出最小級最大fitvalue及其所屬的group
        [min_fit, Indx1]=min(fitness);
        Best_fit=group(Indx1,:);
        [max_fit, Indx2]=max(fitness);
        Worst_fit=group(Indx2,:);
        clear Indx1 Indx2
        
        %進行三種不同加深標記的方式
        for ii=1:groupNum
            if theta>0 && theta<=totalIter/3;                   % Characteristic Gait while walking
                newGroup(ii,:)= group(ii,:) + round((-theta*rand(1,dimention).*group(ii,:) ));
            elseif theta>totalIter/3 && theta<=2*totalIter/3    % Careful Stepping Characteristic
                Q = theta*rand(1,dimention);                    %Fk
                Step = round (1 + rand());                      %Lk
                newGroup(ii,:)= group(ii,:) + round( (Q.*(Best_fit-(Step*Worst_fit))) );
            elseif theta> 2*totalIter/3 && theta<= 1            %twisting Feet Characteristic
                W = 2*theta*pi*rand(1,dimention);               %angular velocity
                newGroup(ii,:)= group(ii,:) +round(((W.*Best_fit- abs(group(ii,:)))-(W.*Worst_fit- abs(group(ii,:)))) );
            end        
        end
        
        %選出同一group新舊較佳的
        for ii=1:groupNum
            newfitness=fitFunction(newGroup(ii,:));
            if newfitness<fitness
                group(ii,:)=newGroup(ii,:);
            else 
                group(ii,:)=group(ii,:);
            end
            fitness=fitFunction(group(ii,:));
        end
        %pedal scent marking behavior end

        %sniffing behavior start
        for ii=1:groupNum
            k=round(rand()*(groupNum));
            while k==ii || k<=0 
                k=round(rand()*(groupNum)); %找到與ii不同的隨機數
            end
            %進行演算法中的算式
            if fitFunction(group(ii,:))<fitFunction(group(k,:))
                r=rand()*ones(1,dimention);
                newGroup(ii,:)=group(ii,:)+r.*( group(ii,:) - group(k,:) );
            else
                r=rand()*ones(1,dimention);
                newGroup(ii,:)=group(ii,:)+r.*( - group(ii,:) + group(k,:) );
            end 
        end 
        %選出較佳的group
        for ii=1:groupNum
        newfitness=fitFunction(newGroup(ii,:));
            if newfitness<fitness
                group(ii,:)=newGroup(ii,:);
            else 
                group(ii,:)=group(ii,:);
            end
        end

        %將每輪最佳的fitvalue儲存起來
        Convergence(C)=Best_sol;
        X(C)=C;
    end
    plot(X,Convergence);
end
