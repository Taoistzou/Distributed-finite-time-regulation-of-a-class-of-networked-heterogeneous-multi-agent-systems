close all;

figure(1)
plot(t,y(:,[1 3 5 7 13 15]))
legend('x1','x2','x3','x4','x5','x6');%λ�ú�����

figure(2)
plot(t,y(:,[1 3 5 7 13 15]+1))
legend('x1','x2','x3','x4','x5','x6');%λ��������

figure(3)
plot(t,y(:,[9 11 17 17]))
legend('v3','v4','v5','v6');%�ٶȺ�����

figure(4)
plot(t,y(:,[9 11 17 17]+1))
legend('v3','v4','v5','v6');%�ٶ�������

figure(5)
plot(t,ut1(:,1:12))%������




% figure(1);
% % plot(t,y(:,1),'k',t,y(:,2),'b',t,y(:,3),'r:',t,y(:,4),'g--','linewidth',1.5);
% plot(t,y(:,[1 2 3 4 5 6]),'linewidth',1.5)
% legend('x1','x2','x3','x4','x5','x6');
% xlabel('time(s)');ylabel('Position of agents');
% grid on
% figure(2)
% plot(t,y(:,[7 8 9 10 11 12]),'linewidth',1.5)
% legend('x1','x2','x3','x4','x5','x6');
% xlabel('time(s)');ylabel('Position of agents');
% grid on
% 
% figure(3)
% plot(t,ut(:,[1 2 3 4 5 6]),'linewidth',1.5)
% grid on
% 
% figure(4)
% plot(t,ut(:,[7 8 9 10 11 1 12]),'linewidth',1.5)
% grid on






