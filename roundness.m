function sigma = roundness(triangle_coor)
    % triangle_coor : 3x2 matrice avec les coordonnées des sommets

    a = norm(triangle_coor(2,:) - triangle_coor(1,:));
    b = norm(triangle_coor(3,:) - triangle_coor(2,:));
    c = norm(triangle_coor(1,:) - triangle_coor(3,:));

    % Aire du triangle (formule de Héron)
    s = (a + b + c)/2;
    A = sqrt(s*(s-a)*(s-b)*(s-c));

    % Rayon du cercle circonscrit
    R = (a*b*c)/(4*A);

    % Rayon du cercle inscrit
    r = 2*A/(a + b + c);

    sigma = R / r;
end
