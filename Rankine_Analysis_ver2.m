%Rankine Cycle VER2
% {
% different seasons 
% point1:input of expander
% point2: input of condenser
% point3:input of pump
% point4:input of boiler
% change the calculation logic
% }
N=2;
Tcond=[];%centigrate degree
Eff=[];
Wt=[];
Wnet=[];
Pstart=1.3;%condense pressure
Pstep=0.9;
Pend=Pstart+N*Pstep;
i=0;
EtaP=0.88; %efficient of pump
EtaT=0.92; %efficient of turbine
for P3=[0.9,1.6,3.4] %different condense temperature
i=i+1;
KT=273.15;

%state 1
T1=550+KT;
P1=17e3;%after boiler
[h1,s1]=refpropm('HS','T',T1,'P',P1,'water');

%state 3 saturated water
Q3=0;
[h3,T3,s3]=refpropm('HTS','P',P3,'Q',Q3,'water');

% state 2 
% for real system
P2=P3;
T2=T3;%excess properties
% subscript s mean ideal cycle!!!
s2s=s1; %ideal system
h2s=refpropm('H','T',T2,'S',s2s,'water');
h2=h1-EtaT*(h1-h2s);%mixture of vpor and water
[Q2,s2]=refpropm('QS','T',T2,'H',h2,'water');

% state 4
P4=P1;
s4s=s3;%for ideal process
[Ts4,h4s]=refpropm('TH','P',P4,'S',s4s,'water');
h4=h3+(h4s-h3)/EtaP;
T4=refpropm('T','P',P4,'H',h4,'water');


wt=h1-h2;
wp=h4-h3;
q_boiler=h1-h4;
eta=(wt-wp)/q_boiler;
Eff(i)=eta;
Tcond(i)=T2-KT;
Wt(i)=wt;
Wnet(i)=wt-wp;
disp(['for condensed temperature is ',num2str(T3-KT),'   efficiency of rankine cycle is  ',num2str(eta)])
% T1
% h1
% T2
% h2
% T3
% h3
% T4
% h4
% eta
end
figure(1)
subplot(1,2,1)
bar(Eff)
%set(gca,'XTickLabel',{'winter','spring','fall','summer'})
%set(gca,'XTickLabel',{'winter','spring/fall','summer'})
%xlabel('Season')
ylabel('Efficiency')
% axis([Tcond(1),Tcond(i),0,1])
xlabel('Temperature(°„C)')
set(gca,'XTickLabel',Tcond)
subplot(1,2,2)
bar(Eff)
%set(gca,'XTickLabel',{'winter','spring','fall','summer'})
set(gca,'XTickLabel',{'winter','spring/fall','summer'})
%xlabel('Season')
ylabel('Efficiency')
% axis([Tcond(1),Tcond(i),0,1])
xlabel('Temperature(°„C)')
figure(2)
subplot(1,2,1)
bar(Wnet)
set(gca,'XTickLabel',{'winter','spring/fall','summer'})
ylabel('J/kg')
subplot(1,2,2)
bar(Wnet)
set(gca,'XTickLabel',Tcond)

clear
%Rankine Cycle2
%{
Different heating temperature
point1:input of expander
point2: input of condenser
point3:input of pump
point4:input of boiler
%2019-4-28
changed the coefficient of pumps and turbine, for it shouldn't be 1, reset
it as 0.88 and 0.92 respecively
%}
N=7;
Tcond=[];%centigrate degree
Eff=[];
Wt=[];
Wnet=[];
KT=273.15;
% Pstart=1.5;
% Pstep=0.5;
% Pend=Pstart+N*Pstep;
% Theat=[340 435 535 550]+KT;
EtaP=0.88; %efficient of pump
EtaT=0.92; %efficient of turbine
Theat=[440:10:650]+KT;
i=0;
for T1=Theat
i=i+1;
%state 1
P1=17e3;%after boiler
[h1,s1]=refpropm('HS','T',T1,'P',P1,'water');

%state 3 saturated water
P3=3.5;
Q3=0;
[h3,T3,s3]=refpropm('HTS','P',P3,'Q',Q3,'water');

% state 2 
% for real system
P2=P3;
T2=T3;%excess properties
% subscript s mean ideal cycle!!!
s2s=s1; %ideal system
h2s=refpropm('H','T',T2,'S',s2s,'water');
h2=h1-EtaT*(h1-h2s);%mixture of vpor and water
[Q2,s2]=refpropm('QS','T',T2,'H',h2,'water');

% state 4
P4=P1;
s4s=s3;%for ideal process
[Ts4,h4s]=refpropm('TH','P',P4,'S',s4s,'water');
h4=h3+(h4s-h3)/EtaP;
T4=refpropm('T','P',P4,'H',h4,'water');

wt=h1-h2;
wp=h4-h3;
q_boiler=h1-h4;
eta=(wt-wp)/q_boiler;
Eff(i)=eta;
Tcond(i)=T2-KT;
Wt(i)=wt;
Wnet(i)=wt-wp;    

disp(['for heating temperature is ',num2str(T1-KT),'   efficiency of rankine cycle is  ',num2str(eta)])

% T1
% h1
% T2
% h2
% T3
% h3
% T4
% h4
% eta
end
figure(3)
bar(Theat-KT,Eff)
xlabel('Temperature(°„C)')
ylabel('Efficiency')
% axis([Tcond(1),Tcond(i),0,1])
figure(4)
bar(Theat-KT,Wnet)
xlabel('Temperature(°„C)')
ylabel('work(J/kg)')


