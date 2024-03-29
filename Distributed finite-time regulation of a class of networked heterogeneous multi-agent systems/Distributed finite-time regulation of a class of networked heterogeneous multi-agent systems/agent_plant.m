function [sys,x0,str,ts]=agent_plant(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1
    sys=mdlDerivatives(t,x,u);
case 3
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 20;%20个状态变量
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 20;%20个输出变量
sizes.NumInputs      = 12;%12个智能体的控制输出 control input
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[-1.5 -0.4 1.9 1.5   -1.8 -1.5 0.1 0.6  -0.2 0.1 -0.8 1.9      1.4 1.9 -0.5 -1.8  0.1 -0.3  0.6 0.8];%一阶智能体1的横坐标，一阶智能体1的纵坐标，一阶智能体2的横坐标，一阶智能体2的纵坐标
                                                      %二阶智能体3的横坐标，二阶智能体3的纵坐标，二阶智能体4的横坐标，为阶智能体4的纵坐标
                                                      %二阶智能体3的横坐标对应的速度，二阶智能体3的纵坐标对应的速度，二阶智能体4的横坐标对应的速度，为阶智能体4的纵坐标对应的速度
                                                      %EL二阶智能体5的横坐标，EL二阶智能体5的纵坐标，EL二阶智能体6的横坐标，EL为阶智能体6的纵坐标
                                                      %EL二阶智能体5的横坐标对应的速度，EL二阶智能体5的纵坐标对应的速度，EL二阶智能体6的横坐标对应的速度，EL为阶智能体6的纵坐标对应的速度
str=[];
ts=[0 0];

function sys=mdlDerivatives(t,x,u)

a1=0.15+1.2*0.5^2+0.25+2.5*0.6^2+2.5*1.2^2;
a2=0.25+2.5*0.6^2;
a3=2.5*1.2*0.6*cos(30*pi/180);
a4=2.5*1.2*0.6*sin(30*pi/180);


%%%智能体的微分关系
sys(1)=u(1);%一阶智能体1的横坐标控制力微分关系
sys(2)=u(2);%一阶智能体1的纵坐标控制力微分关系
sys(3)=u(3);%一阶智能体2的横坐标控制力微分关系
sys(4)=u(4);%一阶智能体2的纵坐标控制力微分关系

sys(5)=x(9);%二阶智能体3的横坐标与对应的速度微分关系
sys(6)=x(10);%二阶智能体3的纵坐标与对应的速度微分关系
sys(7)=x(11);%二阶智能体4的横坐标与对应的速度微分关系
sys(8)=x(12);%二阶智能体4的纵坐标与对应的速度微分关系

sys(9)=u(5);%二阶智能体3的横坐标控制力微分关系
sys(10)=u(6);%二阶智能体3的纵坐标控制力微分关系
sys(11)=u(7);%二阶智能体4的横坐标控制力微分关系
sys(12)=u(8);%二阶智能体4的纵坐标控制力微分关系

sys(13)=x(17);%EL二阶智能体5的横坐标与对应的速度微分关系
sys(14)=x(18);%EL二阶智能体5的纵坐标与对应的速度微分关系
sys(15)=x(19);%EL二阶智能体6的横坐标与对应的速度微分关系
sys(16)=x(20);%EL二阶智能体6的纵坐标与对应的速度微分关系 

% x5_1=x(13);
x5_2=x(14);

% x6_1=x(15);
x6_2=x(16);

xdot5_1=x(17);
xdot5_2=x(18);
xdot6_1=x(19);
xdot6_2=x(20);




c11_5=a4*cos(x5_2)-a3*sin(x5_2);
c12_5=(a4*cos(x5_2)-a3*sin(x5_2))*(xdot5_1+xdot5_2);
c21_5=a3*sin(x5_2)-a4*cos(x5_2);
c22_5=0;
C5=[c11_5 c12_5;c21_5 c22_5];

c11_6=a4*cos(x6_2)-a3*sin(x6_2);
c12_6=(a4*cos(x6_2)-a3*sin(x6_2))*(xdot6_1+xdot6_2);
c21_6=a3*sin(x6_2)-a4*cos(x6_2);
c22_6=0;
C6=[c11_6 c12_6;c21_6 c22_6];

m11_5=a1+2*a3*cos(x5_2)+2*a4*sin(x5_2);
m12_5=a2+a3*cos(x5_2)+a4*sin(x5_2);
m21_5=a2+a3*cos(x5_2)+a4*sin(x5_2);
m22_5=a2;
M5=[m11_5 m12_5;m21_5 m22_5];

m11_6=a1+2*a3*cos(x6_2)+2*a4*sin(x6_2);
m12_6=a2+a3*cos(x6_2)+a4*sin(x6_2);
m21_6=a2+a3*cos(x6_2)+a4*sin(x6_2);
m22_6=a2;
M6=[m11_6 m12_6;m21_6 m22_6];


temp1=inv(M5)*([u(9);u(10)]-C5*[xdot5_1;xdot5_2]);
sys(17)=temp1(1);
sys(18)=temp1(2);

temp2=inv(M6)*([u(11);u(12)]-C6*[xdot6_1;xdot6_2]);
sys(19)=temp2(1);
sys(20)=temp2(2);




function sys=mdlOutputs(t,x,u)
%%%智能体输出
sys(1)=x(1);%一阶智能体1的位置横坐标
sys(2)=x(2);%一阶智能体1的位置纵坐标
sys(3)=x(3);%一阶智能体2的位置横坐标
sys(4)=x(4);%一阶智能体2的位置纵坐标

sys(5)=x(5);%二阶智能体3的位置横坐标
sys(6)=x(6);%二阶智能体3的位置纵坐标
sys(7)=x(7);%二阶智能体4的位置横坐标
sys(8)=x(8);%二阶智能体4的位置纵坐标

sys(9)=x(9);%二阶智能体3的速度横坐标
sys(10)=x(10);%二阶智能体3的速度纵坐标
sys(11)=x(11);%二阶智能体3的速度横坐标
sys(12)=x(12);%二阶智能体4的速度纵坐标

sys(13)=x(13);%EL二阶智能体5的位置横坐标
sys(14)=x(14);%EL二阶智能体5的位置纵坐标
sys(15)=x(15);%EL二阶智能体6的位置横坐标
sys(16)=x(16);%EL二阶智能体6的位置纵坐标

sys(17)=x(17);%EL二阶智能体5的速度横坐标
sys(18)=x(18);%EL二阶智能体5的速度纵坐标
sys(19)=x(19);%EL二阶智能体6的速度横坐标
sys(20)=x(20);%EL二阶智能体6的速度纵坐标





