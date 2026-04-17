function [ circumcenter , circumradius ] = circumcircle ( triangle_coor )
  A = triangle_coor(1,:)
  B = triangle_coor(2,:)
  C = triangle_coor(3,:)

 Matrice_Delta =  [A(1), A(2) , 1 ; B(1),B(2),1; C(1),C(2),1]
 Delta = det(Matrice_Delta)

 Matrice_x = [A(1)^2 + A(2)^2, A(2), 1; B(1)^2 + B(2)^2, B(2), 1 ; C(1)^2 + C(2)^2, C(2), 1]
 Matrice_y = -[A(1)^2 + A(2)^2, A(1), 1; B(1)^2 + B(2)^2, B(1), 1 ; C(1)^2 + C(2)^2, C(1), 1]

 x_O = 1/2*Delta * det(Matrice_x)
 y_O = 1/2*Delta * det(Matrice_y)
 circumcenter = [xO, yO]
 circumradius = sqrt((x_O - A(1))^2 + (y_O - A(2))^2)

 end
