function [FN,FP,OE,O,TP,TN]=PingJia_ture(ima,Bima)% 
% Bima=Bima(:,:,1);
[N,L]=size(Bima);
FN=0;TN=0;
FP=0;TP=0;


for i=1:N
    for j=1:L
        if (Bima(i,j)==0)&&(ima(i,j)==255)
            FP= FP+1;%�����
        end
        if (Bima(i,j)==255)&&(ima(i,j)==0)
            FN=FN+1; %©����
        end
    end
end
 OE= FP+FN;
for i=1:N
    for j=1:L
        if (Bima(i,j)==255)&&(ima(i,j)==255)
            TP= TP+1;%����
        end
        if (Bima(i,j)==0)&&(ima(i,j)==0)
           TN=TN+1;%����
        end
    end
end
 O=TP+TN;
