[X,Y] = meshgrid(-2:.2:2,-2:.2:3);

Z = X.*exp(-X.^2-Y.^2);

[C,h] = contour(X,Y,Z);

set(h,'ShowText','on','TextStep',get(h,'LevelStep')*1)

colormap cool

y=[1 2;3 4; 5 6];
b=bar(y);
ch = get(b,'children');
set(ch{1},'facecolor',[0 0 0])
set(ch{2},'facecolor',[1 1 1])
legend([ch{1} ch{2}],'AA','BB');
xlabel('XXXXX');
ylabel('YYYYY');
set(gca,'XTickLabel',{'30%','45%','60%'})
