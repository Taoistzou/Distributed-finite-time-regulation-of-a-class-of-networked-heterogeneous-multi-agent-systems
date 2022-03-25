clear All
close All
clc
x=[-1.5 1.9 -1.8 0.1 1.4 -0.5 -0.4 1.5 -1.5 0.6 1.9 -1.8];%初始值
v=[-0.2 -0.8 0.1 0.6 0.1 1.9 -0.3 0.8];
A=1;
t=100;
x1=[];U1=[];U2=[];U3=[];U4=[];
v1=[];
h=0.01;
Ts=0:h:t;
a1=0.15+1.2*0.5^2+0.25+2.5*0.6^2+2.5*1.2^2;
a2=0.25+2.5*0.6^2  ;
a3=2.5*1.2*0.6*cos(30*pi/180);
a4=2.5*1.2*0.6*sin(30*pi/180);
for p=0:h:t
    x1=[x1;x];
    v1=[v1;v];
    U1=[];U2=[];
    u_1=0;u_2=0;
    for M=1:6
                if M==1
                    u_1=x1(A,3)-x1(A,1);
                    U1=[U1 u_1];
                    u_2=x1(A,9)-x1(A,7);
                    U2=[U2 u_2];
                end
                if M==2
                    u_1=x1(A,5)-x1(A,2);
                    U1=[U1 u_1];
                    u_2=x1(A,11)-x1(A,8);
                    U2=[U2 u_2];
                end
                if M==3
                    u_1=x1(A,1)-x1(A,3)+x1(A,5)-x1(A,3)+x1(A,6)-x1(A,3)+v1(A,3)-v1(A,1)+v1(A,4)-v1(A,1);
                    U1=[U1 u_1];
                    u_2=x1(A,7)-x1(A,9)+x1(A,11)-x1(A,9)+x1(A,12)-x1(A,9)+v1(A,7)-v1(A,5)+v1(A,8)-v1(A,5);
                    U2=[U2 u_2];
                end    
                if M==4
                    u_1=x1(A,5)-x1(A,4)+x1(A,6)-x1(A,4)-v1(A,2)+v1(A,3)-v1(A,2)+v1(A,4)-v1(A,2);
                    U1=[U1 u_1];
                    u_2=x1(A,11)-x1(A,10)+x1(A,12)-x1(A,10)-v1(A,6)+v1(A,7)-v1(A,6)+v1(A,8)-v1(A,6);
                    U2=[U2 u_2];
                end  
                if M==5
                    m5_11=a1+2*a3*cos(x1(A,11))+2*a4*sin(x1(A,11));
                    m5_12=a2+a3*cos(x1(A,11))+a4*sin(x1(A,11));
                    m5_21=a2+a3*cos(x1(A,11))+a4*sin(x1(A,11));
                    m5_22=a2;
                    M5=[m5_11,m5_12;m5_21,m5_22];
                    c5_11=a4*cos(x1(A,11))-a3*sin(x1(A,11));
                    c5_12=(a4*cos(x1(A,11))-a3*sin(x1(A,11)))*(v1(A,3)+v1(A,7));
                    c5_21=a3*sin(x1(A,11))-a4*cos(x1(A,11));
                    c5_22=0;
                    C5=[c5_11 c5_12;c5_21 c5_22];
                    V5=inv(M5)*([x1(A,2)-x1(A,5)+x1(A,3)-x1(A,5)+x1(A,4)-x1(A,5)+v1(A,1)-v1(A,3)+v1(A,2)-v1(A,3);x1(A,8)-x1(A,11)+x1(A,9)-x1(A,11)+x1(A,10)-x1(A,11)+v1(A,5)-v1(A,7)+v1(A,6)-v1(A,7)]-C5*[v1(A,3);v1(A,7)]);
                    u_1=V5(1);
                    U1=[U1 u_1];
                    u_2=V5(2); 
                    U2=[U2 u_2];
                end  
                if M==6
                    m6_11=a1+2*a3*cos(x1(A,12))+2*a4*sin(x1(A,12));
                    m6_12=a2+a3*cos(x1(A,12))+a4*sin(x1(A,12));
                    m6_21=a2+a3*cos(x1(A,12))+a4*sin(x1(A,12));
                    m6_22=a2;
                    M6=[m6_11,m6_12;m6_21,m6_22];
                    c6_11=a4*cos(x1(A,12))-a3*sin(x1(A,12));
                    c6_12=(a4*cos(x1(A,12))-a3*sin(x1(A,12)))*(v1(A,4)+v1(A,8));
                    c6_21=a3*sin(x1(A,12))-a4*cos(x1(A,12));
                    c6_22=0;
                    C6=[c6_11 c6_12;c6_21 c6_22];
                    V6=inv(M6)*([x1(A,3)-x1(A,6)+x1(A,4)-x1(A,6)-v1(A,4);x1(A,9)-x1(A,12)+x1(A,10)-x1(A,12)-v1(A,8)]-C5*[v1(A,4);v1(A,8)]);
                    u_1=V6(1);
                    U1=[U1 u_1];
                    u_2=V6(2); 
                    U2=[U2 u_2];
                end
           end
                U3=[U3;U1];
                U4=[U4;U2];
                
                x(1,1)=x(1,1)+h*U1(1,1);
                x(1,2)=x(1,2)+h*U1(1,2);
                
                v(1,1)=v(1,1)+h*U1(1,3);
                v(1,2)=v(1,2)+h*U1(1,4);
                v(1,3)=v(1,3)+h*U1(1,5);
                v(1,4)=v(1,4)+h*U1(1,6);
                
                x(1,3)=x(1,3)+h*v(1,1);
                x(1,4)=x(1,4)+h*v(1,2);
                x(1,5)=x(1,5)+h*v(1,3);
                x(1,6)=x(1,6)+h*v(1,4);
                
                x(1,7)=x(1,7)+h*U2(1,1);
                x(1,8)=x(1,8)+h*U2(1,2);
                
                v(1,5)=v(1,5)+h*U2(1,3);
                v(1,6)=v(1,6)+h*U2(1,4);
                v(1,7)=v(1,7)+h*U2(1,5);
                v(1,8)=v(1,8)+h*U2(1,6);
                
                x(1,9)=x(1,9)+h*v(1,5);
                x(1,10)=x(1,10)+h*v(1,6);
                x(1,11)=x(1,11)+h*v(1,7);
                x(1,12)=x(1,12)+h*v(1,8);
                A=A+1;           
end
figure(1)
plot(Ts,x1(:,[1,2,3,4,5,6]),'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i,(1)}'});
legend('x_{1(1)}','x_{2(1)}','x_{3(1)}','x_{4(1)}','x_{5(1)}','x_{6(1)}')
grid on

figure(2)
plot(Ts,x1(:,[7,8,9,10,11,12]),'LineWidth',1);
xlabel('time(s)');ylabel({'positions of agents';'x_{i,(2)}'});
legend('x_{1(2)}','x_{2(2)}','x_{3(2)}','x_{4(2)}','x_{5(2)}','x_{6(2)}')
grid on

figure(3)
plot(Ts,v1(:,[1 2 3 4]),'LineWidth',1);
xlabel('time(s)');ylabel({'velocity of agents';'v_{i,(1)}'});
legend('v_{1(1)}','v_{2(1)}','v_{3(1)}','v_{4(1)}')
grid on

figure(4)
plot(Ts,v1(:,[5 6 7 8]),'LineWidth',1);
xlabel('time(s)');ylabel({'velocity of agents';'v_{i,(2)}'});
legend('v_{1(2)}','v_{2(2)}','v_{3(2)}','v_{4(2)}')
grid on

figure(5)
plot(Ts,U3,'LineWidth',1);
xlabel('time(s)');ylabel({'control input of agents';'u_{i,(1)}'});
legend('v_{1(1)}','v_{2(1)}','v_{3(1)}','v_{4(1)}')
grid on

figure(6)
plot(Ts,U4(:,[3,4,5,6]),'LineWidth',1);
xlabel('time(s)');ylabel({'control input of agents';'u_{i,(2)}'});
legend('v_{1(2)}','v_{2(2)}','v_{3(2)}','v_{4(2)}')

grid on

% %上标用 ^，下标用 _
% % 调用方式为: ^{任意字符}, _{任意字符}, 注意{}的使用!
% title({'position changes of agents';'the initial states z_{2}(0)=(20,40,-30,10,-30,-20)^{T}'},'FontSize',10);% title换行，两行的内容用分号隔开，再用大括号括起来。
% set(gca,'FontSize',10);
% legend('agent1','agent2','agent3','agent4','agent5','agent6')
% % set(gca,'XLim',[0 20],'YLim',[-40 40])  %控制坐标轴尺度长度
% % set(gca,'YLim',[-40 40])
% grid on







