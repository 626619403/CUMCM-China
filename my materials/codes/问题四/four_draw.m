%本代码为第四问的画图代码
y=zeros(51);
for i=0:2000:100000
    for j=0:2000:100000
        y(i/2000+1,j/2000+1)=-func_four([i,j]);
    end
end
surf([0:2000:100000],[0:2000:100000],y);
hold on;
title('直线阻尼系数/旋转阻尼系数与平均功率关系');%由于时间均相同，故总做功大小与功率大小成正比
ylabel('直线阻尼系数');
xlabel('旋转阻尼系数');
zlabel('平均功率');