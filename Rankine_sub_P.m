function [wt,wp,eta]=Rankine_sub_P(T1,P3)
%{
input:T1(K)
      T3(K)
output:wt
       wp
       eta
parameters:
       P1:17e3kPa
       EtaP:0.88
       EtaT:0.92
%}
EtaP=0.88; %efficient of pump
EtaT=0.92; %efficient of turbine


%state 1
%T1=550+KT;
P1=17e3;%after boiler
[h1,s1]=refpropm('HS','T',T1,'P',P1,'water');

%state 3 saturated water
Q3=0;
%[h3,T3,s3]=refpropm('HTS','P',P3,'Q',Q3,'water');
[T3,s3,h3]=refpropm('TSH','P',P3,'Q',Q3,'water');

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

end
