function [triangle_number, max_edge_size] = find_worst_triangle(mesh)

    triangles = mesh.triangles;
    coords    = mesh.coords;

    max_edge_size_sq = 0;
    triangle_number  = 1;

    for l = 1:size(triangles,1)

        a = coords(triangles(l,1),:);
        b = coords(triangles(l,2),:);
        c = coords(triangles(l,3),:);

        % longueurs au carré
        L1 = sum((a-b).^2);
        L2 = sum((b-c).^2);
        L3 = sum((c-a).^2);

        Lmax = max([L1 L2 L3]);

        if Lmax > max_edge_size_sq
            max_edge_size_sq = Lmax;
            triangle_number  = l;
        end
    end

    max_edge_size = sqrt(max_edge_size_sq);

end
