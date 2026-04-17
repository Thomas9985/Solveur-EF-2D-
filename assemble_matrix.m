"""Fonction d'assemblage des matrices (masse ou rigidité).
Paramètres : str_integrand_unknown : "u" ou "Du"
              str_integrand_test : "u" ou "Du"
              str_cofvar : 
              mesh_geo : mesh utilisée pour la méthode
              degree_EF : 1 ou 2  (degré de la méthode éléments finis)
              number : 1 ou 3 (degré de la méthode de quadrature)
              """

function A = assemble_matrix(str_integrand_unknown,str_integrand_test,str_cofvar,mesh_geo,degree_EF,number)
    tr = getfield(mesh_geo,'triangles');
    co = getfield(mesh_geo,'coords');
    [points,poids] = quadrature(number);
    A = zeros(size(co,1),size(co,1));
    for i = 1:size(tr,1);
        for j = 1:length(poids);
            [vals,dervals] = shape_fcts(points(j,:),degree_EF);
            F_K = vals*co(tr(i,:),:); %tableau des valeurs de F_K aux points de quadrature. La valeur au point i est la colonne i.
            for l = 1:3*degree_EF;
                I = tr(i,l);
                for p = 1:3*degree_EF;
                    J = tr(i,p);
                    jacobian = compute_jacobian(co(tr(i,:),:),dervals);
                    A(I,J) = A(I,J) + poids(j)*feval(str_cofvar,F_K)*diff_op(str_integrand_unknown,vals(l),transpose(dervals(:,l))*inv(jacobian))*diff_op(str_integrand_test,vals(p),transpose(dervals(:,p))*inv(jacobian))*abs(det(jacobian));
                end
            end
        end
    end
end
