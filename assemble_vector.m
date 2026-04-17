function A = assemble_vector(str_integrand_unknown,str_cofvar,mesh_geo,degree_EF,number)
    tr = getfield(mesh_geo,'triangles');
    co = getfield(mesh_geo,'coords');
    [points,poids] = quadrature(number);
    A = zeros(size(co,1),1);
    for i = 1:size(tr,1);
        for j = 1:length(poids);
            [vals,dervals] = shape_fcts(points(j,:),degree_EF);
            F_K = vals*co(tr(i,:),:); %tableau des valeurs de F_K aux points de quadrature. La valeur au point i est la colonne i.
            for l = 1:3*degree_EF;
                I = tr(i,l);
                A(I) = A(I) + poids(j)*feval(str_cofvar,F_K)*diff_op(str_integrand_unknown,vals(l),transpose(dervals(:,l))*inverse(compute_jacobian(co(tr(i,:),:),dervals)))*norm(det(compute_jacobian(co(tr(i,:),:),dervals)));

            end
        end
    end
end
