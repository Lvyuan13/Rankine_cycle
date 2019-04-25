%Rankine Cycle
%{
point1:input of expander
point2: input of condenser
point3:input of pump
point4:input of boiler

%}
N=7;
Tcond=[];%centigrate degree
Eff=[];
Pstart=1.5;
Pstep=0.5;
Pend=Pstart+N*Pstep;
for P3=(Pstart:Pstep:Pend)
KT=273.15;
T1=550+KT;
P1=17e3;%after boiler
[h1,s1]=refpropm('HS','T',T1,'P',P1,'water');
%P3=3.5;
Q3=0;
[h3,T3,s3]=refpropm('HTS','P',P3,'Q',Q3,'water');
T2=T3;
s2=s1;
[Q2,h2]=refpropm('QH','T',T2,'S',s2,'water');
P4=P1;
s4=s3;
[T4,h4]=refpropm('TH','P',P4,'S',s4,'water');
wt=h1-h2;
wp=h4-h3;
q_boiler=h1-h4;
eta=(wt-wp)/q_boiler;
i=(P3-Pstart)/Pstep+1
Eff(i)=eta;
Tcond(i)=T2-KT;
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
plot(Tcond,Eff,'o')
xlabel('Temperature(K)')
ylabel('Efficiency')
% axis([Tcond(1),Tcond(i),0,1])





