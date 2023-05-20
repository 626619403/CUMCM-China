y=zeros(51);
for i=0:2000:100000
    for j=0:0.02:1
        y(i/2000+1,round(j*50+1))=-func_sec_2([i,j]);
    end
end
surf([0:0.02:1],[0:2000:100000],y);
ylabel('阻尼系数常数部分');
zlabel('功率/w');
xlabel('指数');
title('阻尼系数为幂指数时功率/系数关系图');