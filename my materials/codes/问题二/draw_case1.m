y=zeros(1,101);
for i=0:1000:100000
    y(i/1000+1)=-func_sec_1(i);
end
plot([0:1000:100000],y);
xlabel('阻尼系数');
ylabel('功率/w');
title('阻尼系数为常数时功率/系数关系图');