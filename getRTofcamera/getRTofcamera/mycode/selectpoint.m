function [loc1_m ,loc2_m] = selectpoint(loc1,loc2,num,match)
%SELECTPOINT �˴���ʾ�йش˺�����ժҪ
 % �ڶ���ƥ��,�޳����
loc1_m=zeros(num,2);
loc2_m=zeros(num,2);
k=1;
    for i=1:size(match,2)
       
        if match(1,i)~=0
            loc1_m(k,1:2)=loc1(i,1:2);
            loc2_m(k,1:2)=loc2(match(1,i),1:2);
            k=k+1;
        end
    end
end

