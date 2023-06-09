%此代码为三题的代码
m1=4866;%浮子质量
m2=2433;%振子质量
%由资料得自由浮体在水中的转轴为过自身的重心所在直线
h=2.2079;%浮子重心距离圆锥顶部的距离,计算方法见论文
dens=187.0506;%密度,求解原理见论文
j1=11575.083;%浮子转动惯量
j2=0;%振子转动惯量(在代码中求得)
rho=1025;%海水密度
g=9.8;%小g
k1=80000;%弹簧系数
k2=250000;%扭转弹簧系数
m3=1028.876;%垂荡附加质量
j3=7001.914;%纵摇附加转动惯量
freq=1.7152;%频率
T=1/freq;%周期
s=pi;%圆柱底面积
zeta1=683.4558;%垂荡兴波阻尼系数
zeta2=654.3383;%纵摇兴波阻尼系数
sigma1=10000;%直线阻尼器系数
sigma2=1000;%旋转阻尼器系数
f=3640;%垂荡激励力振幅
l=1690;%纵摇激励力矩振幅
deltat=0.0001;%最小模拟时间间隔
v1=0;v2=0;%浮子/振子垂荡速度（x1以铅直向上方向为正）
%x2以沿杆方向向上为正
a1=0;a2=0;%浮子/振子垂荡加速度（方向同上）
x1=0;x2=0;%浮子/振子离各自初始点相对位移
%其中，x1为垂荡运动，只考虑竖直方向；
%x2为沿杆运动的位移，其等于弹簧在运动过程中的伸长量（负值即为压缩量）
v1_rec=zeros(1,1000001);v2_rec=zeros(1,1000001);
x1_rec=zeros(1,1000001);x2_rec=zeros(1,1000001);%记录值
beta1=0;beta2=0;%浮子/振子角加速度（以波浪推力正值方向为正）
w1=0;w2=0;%浮子/振子角速度（以波浪推力方向为正）
theta1=0;theta2=0;%浮子/振子离各自初始点相对角度（以波浪推力方向为正）
w1_rec=zeros(1,1000001);w2_rec=zeros(1,1000001);
theta1_rec=zeros(1,1000001);theta2_rec=zeros(1,1000001);%记录值
t=0;%当前时间
x_spr_ori=0.20196;%弹簧初始状态长度
x_h=0.2;%转轴架顶部与转轴距离
eta=8890.7;%静水恢复力矩参数
for i=1:1000000
    t=t+deltat;
    r2=x_spr_ori+x_h+x2+0.25;
    j2=1/12*m2+m2*r2^2;
    f_spr=m2*g*(1-cos(theta2))+k1*(x1*cos(theta2)-x2);
    a1=(f*cos(freq*t)-f_spr*cos(theta2)-zeta1*v1-sigma1*(v1*cos(theta2)-v2)*cos(theta2)-rho*g*x1*s)/(m1+m3);%计算原理见论文
    a2=(sigma1*(v1*cos(theta2)-v2)+f_spr)/m2;
    beta1=(l*cos(t*freq)-sigma2*(w1-w2)-eta*theta1-k2*(theta1-theta2)-zeta2*w1)/(j1+j3);%计算原理见论文
    beta2=(k2*(theta1-theta2)+sigma2*(w1-w2))/j2;
    x1=x1+v1*deltat;
    x2=x2+v2*deltat;
    v1=v1+a1*deltat;
    v2=v2+a2*deltat;
    theta1=theta1+w1*deltat;
    theta2=theta2+w2*deltat;
    w1=w1+beta1*deltat;
    w2=w2+beta2*deltat;
    v1_rec(1,i+1)=v1;v2_rec(1,i+1)=v2*cos(theta2);
    x1_rec(1,i+1)=x1;x2_rec(1,i+1)=x2*cos(theta2);%注意：计算所用的x1为垂直方向
    %但x2为沿杆方向，需乘以cos(theta2)才为垂直方向的位移
    w1_rec(1,i+1)=w1;w2_rec(1,i+1)=w2;
    theta1_rec(1,i+1)=theta1;theta2_rec(1,i+1)=theta2;
end
subplot(3,2,1);
plot([0:0.0001:100],x1_rec);
title('浮子相对初始位置位移');
xlabel('时间/s');
ylabel('位移/m');
subplot(3,2,2);
plot([0:0.0001:100],x2_rec);
title('振子相对初始位置位移');
xlabel('时间/s');
ylabel('位移/m');
subplot(3,2,3);
plot([0:0.0001:100],v1_rec);
title('浮子速度');
xlabel('时间/s');
ylabel({'速度','(m/s)'});
subplot(3,2,4);
plot([0:0.0001:100],v2_rec);
title('振子速度');
xlabel('时间/s');
ylabel({'速度','(m/s)'});
subplot(3,2,5);
plot([0:0.0001:100],x1_rec-x2_rec);
title('相对位移');
xlabel('时间/s');
ylabel('位移/m');
subplot(3,2,6);
plot([0:0.0001:100],v1_rec-v2_rec);
title('相对速度');
xlabel('时间/s');
ylabel({'速度','(m/s)'});
figure;
subplot(3,2,1);
plot([0:0.0001:100],theta1_rec);
title('浮子相对初始位置旋转度数');
xlabel('时间/s');
ylabel('角度/rad');
subplot(3,2,2);
plot([0:0.0001:100],theta2_rec);
title('振子相对初始位置旋转度数');
xlabel('时间/s');
ylabel('角度/rad');
subplot(3,2,3);
plot([0:0.0001:100],w1_rec);
title('浮子角速度');
xlabel('时间/s');
ylabel({'角速度','(rad/s)'});
subplot(3,2,4);
plot([0:0.0001:100],w2_rec);
title('振子角速度');
xlabel('时间/s');
ylabel({'角速度','(rad/s)'});
subplot(3,2,5);
plot([0:0.0001:100],theta1_rec-theta2_rec);
title('角度差');
xlabel('时间/s');
ylabel('角度/rad');
subplot(3,2,6);
plot([0:0.0001:100],w1_rec-w2_rec);
title('相对角速度');
xlabel('时间/s');
ylabel({'角速度','(rad/s)'});
v1_r=v1_rec(1:2000:234001);%每隔0.2s提取一次，其中23.32s时第40个周期结束，补为23.4s
v2_r=v2_rec(1:2000:234001);
x1_r=x1_rec(1:2000:234001);
x2_r=x2_rec(1:2000:234001);
w1_r=w1_rec(1:2000:234001);
w2_r=w2_rec(1:2000:234001);
theta1_r=theta1_rec(1:2000:234001);
theta2_r=theta2_rec(1:2000:234001);
ans_v1=v1_rec([100001,200001,400001,600001,1000001]);%10,20,40,60,100s的结果
ans_v2=v2_rec([100001,200001,400001,600001,1000001]);
ans_x1=x1_rec([100001,200001,400001,600001,1000001]);
ans_x2=x2_rec([100001,200001,400001,600001,1000001]);
ans_w1=w1_rec([100001,200001,400001,600001,1000001]);
ans_w2=w2_rec([100001,200001,400001,600001,1000001]);
ans_theta1=theta1_rec([100001,200001,400001,600001,1000001]);
ans_theta2=theta2_rec([100001,200001,400001,600001,1000001]);