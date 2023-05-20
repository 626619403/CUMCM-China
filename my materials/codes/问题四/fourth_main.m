%本题为第四题主代码
a = 0.98;	% 温度衰减函数的参数
t0 = 100; tf = 3; t = t0;
Markov_length = 50;	% Markov链长度
sol_new=[rand*100000,rand*100000];
% 产生初始解
% sol_new是每次产生的新解；sol_current是当前解；sol_best是冷却中的最好解；
E_current =1000;E_best = 1000; 		
% E_current是当前解对应的功；
% E_new是新解的功；
% E_best是最优解的
sol_current = sol_new; sol_best = sol_new;          
num=0;
wlist=zeros(1,500);
while t>=tf
    num=num+1;
    for r=1:Markov_length		% Markov链长度
        % 产生随机扰动
        if (rand < 0.5)	% 随机决定是进行直线阻尼还是旋转阻尼扰动
            if(rand<0.5)
                sol_new(1)=sol_new(1)+200*t*rand;%直线阻尼
                if(sol_new(1)>100000) 
                    sol_new(1)=100000;
                end
            else
                sol_new(1)=sol_new(1)-200*t*rand;%减去
                if(sol_new(1)<0) 
                    sol_new(1)=0;
                end
            end
        else
            if(rand<0.5)
                sol_new(2)=sol_new(2)+200*t*rand;%旋转阻尼
                if(sol_new(2)>100000) 
                    sol_new(2)=100000;
                end
            else
                sol_new(2)=sol_new(2)-200*t*rand;%减去
                if(sol_new(2)<0) 
                    sol_new(2)=0;
                end
            end
        end
        % 计算功
        E_new = func_four(sol_new);
        if E_new < E_current
            E_current = E_new;
            sol_current = sol_new;
            if E_new < E_best
                E_best = E_new;
                sol_best = sol_new;
            end
        else
            if rand < exp(-(E_new-E_current)./t)
                E_current = E_new;
                sol_current = sol_new;
            else	
                sol_new = sol_current;
            end
        end
    end
    t=t.*a;
    wlist(num)=-E_best;
    if(num>30)
        if(-E_best-wlist(num-30)<1e-6) %达到精度要求
            break;
        end
    end
end
plot([1:num],wlist(1:num));
hold on;
title('模拟退火步数/最优值关系图');
xlabel('降温次数');
ylabel({'最大功率','j/s'});
