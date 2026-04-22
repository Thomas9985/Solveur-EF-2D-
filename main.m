%Script calcul de la solution
%Approximation P1
%Attendre 5 mn pour l'affichage

liste_h = [1/2 1/4 1/8 1/16];  % petit h à gauche
err_relative_1 = zeros(length(liste_h),1);
err_maximale_1 = zeros(length(liste_h),1);

for i = 1:length(liste_h)
   [u_app,coords_maillage] = resolution_probleme(1,liste_h(i));
   u_ex = zeros(length(u_app),1);

   for j =  1:length(u_app)
      u_ex(j) = u(coords_maillage(j,:));
   endfor
   err_relative_1(i) = norm(u_ex - u_app);
   err_maximale_1(i) = max(abs(u_ex - u_app));

endfor

#%Approximation P2

liste_h = [1/2 1/4 1/8 1/16];

err_relative_2 = zeros(length(liste_h),1);
err_maximale_2 = zeros(length(liste_h),1);

for i = 1:length(liste_h)
   [u_app,coords_maillage] = resolution_probleme(2,liste_h(i));
   u_ex = zeros(length(u_app),1);

   for j =  1:length(u_app)
      u_ex(j) = u(coords_maillage(j,:));
   endfor
   err_relative_2(i) = norm(u_ex - u_app);
   err_maximale_2(i) = max(abs(u_ex - u_app));

endfor

subplot(2,2,1)
p11 = polyfit(log(liste_h),log(err_relative_1),1);
f = polyval(p11, log(liste_h));
loglog(liste_h,err_relative_1,'o',liste_h,exp(f));
xlabel('Taille du maillage');
ylabel('Erreur relative');
title("Erreur relative de la solution en fonction de la taille du maillage pour la méthode P1");

subplot(2,2,2)
p22 = polyfit(log(liste_h),log(err_maximale_1),1);
f = polyval(p22, log(liste_h));
loglog(liste_h,err_maximale_1,'o',liste_h,exp(f));
xlabel('Taille du maillage');
ylabel('Erreur maximale');
title("Erreur maximale de la solution en fonction de la taille du maillage pour la méthode P1");

subplot(2,2,3)
p1 = polyfit(log(liste_h),log(err_relative_2),1);
f = polyval(p1, log(liste_h));
loglog(liste_h,err_relative_2,'o',liste_h,exp(f))
xlabel('Taille du maillage');
ylabel('Erreur relative');
title("Erreur relative de la solution en fonction de la taille du maillage pour la méthode P2");

subplot(2,2,4)
p2 = polyfit(log(liste_h),log(err_maximale_2),1);
f = polyval(p2, log(liste_h));
loglog(liste_h,err_maximale_2,'o',liste_h,exp(f));
xlabel('Taille du maillage');
ylabel('Erreur maximale');
title("Erreur maximale de la solution en fonction de la taille du maillage pour la méthode P2");

disp([p11(1),p22(1),p1(1),p2(1)]) %affiche les coefficients directeurs des droites.

% (a) Approximation P1
% J'obtiens des résultats qui me semblent cohérents. Les coefficients des droites de régression sont légèrement trop faibles pour l'erreur relative.
% Ils devraient être autour de 2. J'ai 1.6 pour l'erreur relative et 1.9 pour l'erreur maximale.
% Peut-être des erreurs dans les valeurs des fonctions dans les programmes. Je ne sais pas. J'ai pas mal revu mes programmes. Toutes les fonctions marchent bien.
% L'affichage des droites de régression est bizarre.

%(b) Approximation P2
% J'obtiens des résultats cohérents. Les coefficients sont toujours légèrement trop faibles. J'ai 2.4 pour l'erreur relative et 2.8 pour l'erreur maximale.
% Je ne sais pas où est l'erreur peut-être dans l'affichage. L'affiche des droites est étrange.

