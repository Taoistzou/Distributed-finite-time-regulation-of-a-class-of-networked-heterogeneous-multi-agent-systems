clear all; 
close all;
clc
%global 
xk=[-1.5 1.9 -1.8 -0.2 0.1 -0.8 1.4 0.1 -0.5 0.6 -0.4 1.5 -1.5 0.1 0.6 1.9 1.9 -0.3 -1.8 0.8];
ts=0.01;
T=100;
TimeSet=[0:ts:T];
[t,y]=ode45('ode45_topology10_figure4f',TimeSet,xk,[],[]);
x1=y(:,1);
x2=y(:,2);
x3=y(:,3);
x4=y(:,4);                                    %agent3的速度1
x5=y(:,5);                                    
x6=y(:,6);                                    %agent4的速度1
x7=y(:,7);                                   
x8=y(:,8);                                    %agent5的速度1
x9=y(:,9);
x10=y(:,10);                                  %agent6的速度1
x11=y(:,11);
x12=y(:,12);                                  
x13=y(:,13);
x14=y(:,14);                                   %agent3的速度2
x15=y(:,15);
x16=y(:,16);                                   %agent4的速度2                                   
x17=y(:,17);                                    
x18=y(:,18);                                   %agent5的速度2                                    
x19=y(:,19);                                   
x20=y(:,20);                                   %agent6的速度2                                 

figure(1);
plot(t,x1,t,x2,t,x3,t,x5,t,x7,t,x9);
xlabel('time(s)');ylabel('positions of agents');
legend('agent1','agnet2','agent3','agent4','agent5','agent6');

figure(2);
plot(t,x4,t,x6,t,x8,t,x10,'m--');
xlabel('time(s)');ylabel('velocities of agents');
legend('agnet3','agent4','agent5','agent6');

figure(3);
plot(t,x11,t,x12,t,x13,t,x15,t,x17,t,x19);
xlabel('time(s)');ylabel('positions of agents');
legend('agent1','agnet2','agent3','agent4','agent5','agent6');

figure(4);
plot(t,x14,t,x16,t,x18,t,x20,'m--');
xlabel('time(s)');ylabel('velocities of agents');
legend('agnet3','agent4','agent5','agent6');