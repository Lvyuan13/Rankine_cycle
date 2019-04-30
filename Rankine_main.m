%Rankine_main
x=[5+273.15:1:26+273.15];
y=[720:1:930];
[X,Y]=meshgrid(x,y);
NX=size(X);
NX=NX(1)
NY=size(Y);
NY=NY(2)
Z=zeros(NX,NY)
% contour(X,Y,Z)
for i=(1:1:NX)
    for j=[1:1:NY]
        T1=Y(i,j);
        T3=X(i,j);
        [~,~,Z(i,j)]=Rankine_sub(T1,T3);
    end
end
[C,h] = contour(X,Y,Z);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*1)
colormap cool
xlabel('Heating Temperature(K)')
ylabel('Condense Temperature(K)')