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
sizes.NumContStates  = 20;%20��״̬����
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 20;%20���������
sizes.NumInputs      = 12;%12��������Ŀ������ control input
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;
sys=simsizes(sizes);
x0=[-1.5 -0.4 1.9 1.5   -1.8 -1.5 0.1 0.6  -0.2 0.1 -0.8 1.9      1.4 1.9 -0.5 -1.8  0.1 -0.3  0.6 0.8];%һ��������1�ĺ����꣬һ��������1�������꣬һ��������2�ĺ����꣬һ��������2��������
                                                      %����������3�ĺ����꣬����������3�������꣬����������4�ĺ����꣬Ϊ��������4��������
                                                      %����������3�ĺ������Ӧ���ٶȣ�����������3���������Ӧ���ٶȣ�����������4�ĺ������Ӧ���ٶȣ�Ϊ��������4���������Ӧ���ٶ�
                                                      %EL����������5�ĺ����꣬EL����������5�������꣬EL����������6�ĺ����꣬ELΪ��������6��������
                                                      %EL����������5�ĺ������Ӧ���ٶȣ�EL����������5���������Ӧ���ٶȣ�EL����������6�ĺ������Ӧ���ٶȣ�ELΪ��������6���������Ӧ���ٶ�
str=[];
ts=[0 0];

function sys=mdlDerivatives(t,x,u)

a1=0.15+1.2*0.5^2+0.25+2.5*0.6^2+2.5*1.2^2;
a2=0.25+2.5*0.6^2;
a3=2.5*1.2*0.6*cos(30*pi/180);
a4=2.5*1.2*0.6*sin(30*pi/180);


%%%�������΢�ֹ�ϵ
sys(1)=u(1);%һ��������1�ĺ����������΢�ֹ�ϵ
sys(2)=u(2);%һ��������1�������������΢�ֹ�ϵ
sys(3)=u(3);%һ��������2�ĺ����������΢�ֹ�ϵ
sys(4)=u(4);%һ��������2�������������΢�ֹ�ϵ

sys(5)=x(9);%����������3�ĺ��������Ӧ���ٶ�΢�ֹ�ϵ
sys(6)=x(10);%����������3�����������Ӧ���ٶ�΢�ֹ�ϵ
sys(7)=x(11);%����������4�ĺ��������Ӧ���ٶ�΢�ֹ�ϵ
sys(8)=x(12);%����������4�����������Ӧ���ٶ�΢�ֹ�ϵ

sys(9)=u(5);%����������3�ĺ����������΢�ֹ�ϵ
sys(10)=u(6);%����������3�������������΢�ֹ�ϵ
sys(11)=u(7);%����������4�ĺ����������΢�ֹ�ϵ
sys(12)=u(8);%����������4�������������΢�ֹ�ϵ

sys(13)=x(17);%EL����������5�ĺ��������Ӧ���ٶ�΢�ֹ�ϵ
sys(14)=x(18);%EL����������5�����������Ӧ���ٶ�΢�ֹ�ϵ
sys(15)=x(19);%EL����������6�ĺ��������Ӧ���ٶ�΢�ֹ�ϵ
sys(16)=x(20);%EL����������6�����������Ӧ���ٶ�΢�ֹ�ϵ 

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
%%%���������
sys(1)=x(1);%һ��������1��λ�ú�����
sys(2)=x(2);%һ��������1��λ��������
sys(3)=x(3);%һ��������2��λ�ú�����
sys(4)=x(4);%һ��������2��λ��������

sys(5)=x(5);%����������3��λ�ú�����
sys(6)=x(6);%����������3��λ��������
sys(7)=x(7);%����������4��λ�ú�����
sys(8)=x(8);%����������4��λ��������

sys(9)=x(9);%����������3���ٶȺ�����
sys(10)=x(10);%����������3���ٶ�������
sys(11)=x(11);%����������3���ٶȺ�����
sys(12)=x(12);%����������4���ٶ�������

sys(13)=x(13);%EL����������5��λ�ú�����
sys(14)=x(14);%EL����������5��λ��������
sys(15)=x(15);%EL����������6��λ�ú�����
sys(16)=x(16);%EL����������6��λ��������

sys(17)=x(17);%EL����������5���ٶȺ�����
sys(18)=x(18);%EL����������5���ٶ�������
sys(19)=x(19);%EL����������6���ٶȺ�����
sys(20)=x(20);%EL����������6���ٶ�������




