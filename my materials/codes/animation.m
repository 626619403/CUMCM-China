%本代码最高到100s，若仅想看较短时间的动画，可在
%程序运行时提前停止后播放
%本代码为1、3题所用动画代码，使用方法：
%1.运行1或3题代码，并将其中的x1_rec、x2_rec(theta1_rec、theta2_rec)保留在工作区
%注意：一次只运行一个代码，否则后面的代码会更新工作区
%在运行第三问的代码之后若想运行第一问的代码，请先注意清空工作区的theta!
%2.打开本程序并运行
%3.在命令行窗口输入以下代码：
% set(gca,'ytick',[])
% set(gca,'xtick',[])
% movie(gca,F,1,50,[-3 -3 0 0])
%若您想更改速度，请将第四个参数改为您想要的每秒帧数
%如果您愿意，可以在循环中分别加入如下语句，以达到一些效果：
%line([-5,5],[0.5921,0.5921],'color','c','linestyle','-.');%加入水面
%line([center_2(1) 0],[center_2(2) center_1(2)],'color','r','linestyle','-');%加入振子与转轴的连线
r2=0.65;
loops = 5001;
F(loops) = struct('cdata',[],'colormap',[]);
center_1=[0,0];
center_2=[0,0];
lines1_x_o=[-1 1;-1 1;-1 -1;1 1;-1 0;1 0]';
lines1_y_o=[4 4;0.8 0.8;4 0.8;4 0.8;0.8 0;0.8 0]';
lines1_y_o=lines1_y_o-2.2079;
lines2_x_o=[-0.5 0.5;-0.5 0.5;-0.5 -0.5;0.5 0.5]';
lines2_y_o=[-0.25 -0.25;0.25 0.25;-0.25 0.25;0.25 -0.25]';
for i=0:0.02:100
    num_0=round(i/0.0001)+1;
    num=round(i/0.02)+1;
    x1_move=x1_rec(num_0);
    x2_move=x2_rec(num_0);
    if(exist('theta1_rec','var'))
        theta1=theta1_rec(num_0);
        theta2=theta2_rec(num_0);
    else
        theta1=0;
        theta2=0;
    end
    center_1=[0,x1_move];
    center_2=[sin(theta2)*(r2+x2_move/cos(theta2)),(r2+x2_move/cos(theta2))*cos(theta2)];
    lines1y=lines1_y_o+center_1(2);
    lines2x=lines2_x_o+center_2(1);
    lines2y=lines2_y_o+center_2(2);
    lines1x=lines1_x_o;
    sp1=[cos(theta1) -sin(-theta1);sin(-theta1) cos(theta1)];
    sp2=[cos(theta2) -sin(-theta2);sin(-theta2) cos(theta2)];
    lines1_st=[lines1x(1,:);lines1y(1,:)];
    lines1_ed=[lines1x(2,:);lines1y(2,:)];
    lines2_st=[lines2x(1,:);lines2y(1,:)];
    lines2_ed=[lines2x(2,:);lines2y(2,:)];
    lines1_st=sp1*lines1_st;
    lines1_ed=sp1*lines1_ed;
    lines2_st=sp2*lines2_st;
    lines2_ed=sp2*lines2_ed;
    clf;
    axis equal;
    xlim([-5 5]);
    ylim([-5 5]);
    line([lines1_st(1,:);lines1_ed(1,:)],[lines1_st(2,:);lines1_ed(2,:)],'color','k','linestyle','-');
    line([lines2_st(1,:);lines2_ed(1,:)],[lines2_st(2,:);lines2_ed(2,:)],'color','b','linestyle','--');
    %若要加入最前面的功能语句，请在此处加入
    st=num2str(i,5);
    text(-5,4.5,['当前时间: ',st]);
    drawnow limitrate;
    F(num) = getframe(gcf);
end
