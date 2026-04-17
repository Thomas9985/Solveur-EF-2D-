function mesh_out = mesh_optimize(mesh_in)
    co = mesh_in.coords;
    triangles = mesh_in.triangles;


    [edges, ~] = build_edge_connectivity(mesh_in);

    % identifier les points intérieurs
    L = [];
    for i = 1:size(co,1)
        if interior_point(mesh_in,i)
            L = [L,i];
        end
    end


    for k = 1:length(L)
        point = L(k);


        voisins = [];
        for e = 1:size(edges,1)
            if edges(e,1) == point
                voisins = [voisins, edges(e,2)];
            elseif edges(e,2) == point
                voisins = [voisins, edges(e,1)];
            end
        end

        % calcul du barycentre
        G = mean(co(voisins,:),1);


        co(point,:) = G;
    end


    mesh_out = mesh_new('', co, triangles);
end
