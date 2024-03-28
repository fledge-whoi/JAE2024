hfit = line (PERSONALITY, lambdas_m);
hfit2 = line (PERSONALITY, lambdas_f);
set(hfit2, 'Color', [0.5 0 0.1]);
set(hfit2, 'LineWidth', 2);
set(hfit, 'Color', [0 0 .5]);
set(hfit, 'LineWidth', 2);
xlim([-3 3])
ylim([1.02 1.04])
xtickformat('%.2f')
ytickformat('%.2f')
hTitle = title('Effect of personality on {\lambda} for males and females', 'FontSize', 12);
hXLabel = xlabel('Personality score', 'FontSize', 12);
hYLabel = ylabel('{\lambda}', 'FontSize', 12);
legend("Males", "Females");
legend boxoff 

% Export
f = gcf;
exportgraphics(f,'EffectPerso_Lambda_FM_2008.png','Resolution',300);