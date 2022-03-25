function [sys,x0,str,ts] = agent_ctrl1(t,x,u,flag)
switch flag
case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[]; 
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 12;%������Ŀ������ control input
sizes.NumInputs      = 20;%�������λ����Ϣ
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];
function sys=mdlOutputs(t,x,u)
aij=[0 0 1 0 0 0;
     0 0 0 0 1 0;
     1 0 0 0 1 1;
     0 0 0 0 1 1;
     0 1 1 0 1 0;
     0 0 1 1 0 0];

x1_1=u(1);
x1_2=u(2);
x2_1=u(3);
x2_2=u(4);

x3_1=u(5);
x3_2=u(6);
x4_1=u(7);
x4_2=u(8);

x5_1=u(13);
x5_2=u(14);
x6_1=u(15);
x6_2=u(16);

v3_1=u(9);
v3_2=u(10);
v4_1=u(11);
v4_2=u(12);

v5_1=u(17);
v5_2=u(18);
v6_1=u(19);
v6_2=u(20);



%%%���뽫����Ľ��ת��Ϊʵ������Ȼ����ͨ������Ҳ����˵�������ǣ�real vector
agent1_1=aij(1,1)*(x1_1-x1_1)+aij(1,2)*(x2_1-x1_1)+aij(1,3)*(x3_1-x1_1)+aij(1,4)*(x4_1-x1_1)+aij(1,5)*(x5_1-x1_1)+aij(1,6)*(x6_1-x1_1);%һ��������1�ĺ����������
agent1_2=aij(1,1)*(x1_2-x1_2)+aij(1,2)*(x2_2-x1_2)+aij(1,3)*(x3_2-x1_2)+aij(1,4)*(x4_2-x1_2)+aij(1,5)*(x5_2-x1_2)+aij(1,6)*(x6_2-x1_2);%һ��������1�������������

agent2_1=aij(2,1)*(x1_1-x2_1)+aij(2,2)*(x2_1-x2_1)+aij(2,3)*(x3_1-x2_1)+aij(2,4)*(x4_1-x2_1)+aij(2,5)*(x5_1-x2_1)+aij(2,6)*(x6_1-x2_1);%һ��������2�ĺ����������
agent2_2=aij(2,1)*(x1_2-x2_2)+aij(2,2)*(x2_2-x2_2)+aij(2,3)*(x3_2-x2_2)+aij(2,4)*(x4_2-x2_2)+aij(2,5)*(x5_2-x2_2)+aij(2,6)*(x6_2-x2_2);%һ��������2�������������

agent3_1=aij(3,1)*(x1_1-x3_1)+aij(3,2)*(x2_1-x3_1)+aij(3,3)*(x3_1-x3_1)+aij(3,4)*(x4_1-x3_1)+aij(3,5)*(x5_1-x3_1)+aij(3,6)*(x6_1-x3_1)-v3_1;%����������3�ĺ����������
agent3_2=aij(3,1)*(x1_2-x3_2)+aij(3,2)*(x2_2-x3_2)+aij(3,3)*(x3_2-x3_2)+aij(3,4)*(x4_2-x3_2)+aij(3,5)*(x5_2-x3_2)+aij(3,6)*(x6_2-x3_2)-v3_2;%%����������3�������������

agent4_1=aij(4,1)*(x1_1-x4_1)+aij(4,2)*(x2_1-x4_1)+aij(4,3)*(x3_1-x4_1)+aij(4,4)*(x4_1-x4_1)+aij(4,5)*(x5_1-x4_1)+aij(4,6)*(x6_1-x4_1)-v4_1;%����������4�ĺ����������
agent4_2=aij(4,1)*(x1_2-x4_2)+aij(4,2)*(x2_2-x4_2)+aij(4,3)*(x3_2-x4_2)+aij(4,4)*(x4_2-x4_2)+aij(4,5)*(x5_2-x4_2)+aij(4,6)*(x6_2-x4_2)-v4_2;%%����������4�������������

agent5_1=aij(5,1)*(x1_1-x5_1)+aij(5,2)*(x2_1-x5_1)+aij(5,3)*(x3_1-x5_1)+aij(5,4)*(x4_1-x5_1)+aij(5,5)*(x5_1-x5_1)+aij(5,6)*(x6_1-x5_1)-v5_1;%EL����������5�ĺ����������
agent5_2=aij(5,1)*(x1_2-x5_2)+aij(5,2)*(x2_2-x5_2)+aij(5,3)*(x3_2-x5_2)+aij(5,4)*(x4_2-x5_2)+aij(5,5)*(x5_2-x5_2)+aij(5,6)*(x6_2-x5_2)-v5_2;%EL����������5�������������

agent6_1=aij(6,1)*(x1_1-x6_1)+aij(6,2)*(x2_1-x6_1)+aij(6,3)*(x3_1-x6_1)+aij(6,4)*(x4_1-x6_1)+aij(6,5)*(x5_1-x6_1)+aij(6,6)*(x6_1-x6_1)-v6_1;%EL����������6�ĺ����������
agent6_2=aij(6,1)*(x1_2-x6_2)+aij(6,2)*(x2_2-x6_2)+aij(6,3)*(x3_2-x6_2)+aij(6,4)*(x4_2-x6_2)+aij(6,5)*(x5_2-x6_2)+aij(6,6)*(x6_2-x6_2)-v6_2;%EL����������6�������������



sys(1)=agent1_1;
sys(2)=agent1_2;
sys(3)=agent2_1;
sys(4)=agent2_2;

sys(5)=agent3_1;
sys(6)=agent3_2;
sys(7)=agent4_1;
sys(8)=agent4_2;

sys(9)=agent5_1;
sys(10)=agent5_2;
sys(11)=agent6_1;
sys(12)=agent6_2;






















