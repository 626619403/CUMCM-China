%����Ϊ������������
a = 0.98;	% �¶�˥�������Ĳ���
t0 = 100; tf = 3; t = t0;
Markov_length = 50;	% Markov������
sol_new=[rand*100000,rand*100000];
% ������ʼ��
% sol_new��ÿ�β������½⣻sol_current�ǵ�ǰ�⣻sol_best����ȴ�е���ý⣻
E_current =1000;E_best = 1000; 		
% E_current�ǵ�ǰ���Ӧ�Ĺ���
% E_new���½�Ĺ���
% E_best�����Ž��
sol_current = sol_new; sol_best = sol_new;          
num=0;
wlist=zeros(1,500);
while t>=tf
    num=num+1;
    for r=1:Markov_length		% Markov������
        % ��������Ŷ�
        if (rand < 0.5)	% ��������ǽ���ֱ�����ỹ����ת�����Ŷ�
            if(rand<0.5)
                sol_new(1)=sol_new(1)+200*t*rand;%ֱ������
                if(sol_new(1)>100000) 
                    sol_new(1)=100000;
                end
            else
                sol_new(1)=sol_new(1)-200*t*rand;%��ȥ
                if(sol_new(1)<0) 
                    sol_new(1)=0;
                end
            end
        else
            if(rand<0.5)
                sol_new(2)=sol_new(2)+200*t*rand;%��ת����
                if(sol_new(2)>100000) 
                    sol_new(2)=100000;
                end
            else
                sol_new(2)=sol_new(2)-200*t*rand;%��ȥ
                if(sol_new(2)<0) 
                    sol_new(2)=0;
                end
            end
        end
        % ���㹦
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
        if(-E_best-wlist(num-30)<1e-6) %�ﵽ����Ҫ��
            break;
        end
    end
end
plot([1:num],wlist(1:num));
hold on;
title('ģ���˻���/����ֵ��ϵͼ');
xlabel('���´���');
ylabel({'�����','j/s'});
