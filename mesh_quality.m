function quality = mesh_quality(mesh)
    coords = mesh.coords;
    triangles = mesh.triangles;

    max_sigma = 0;

    for k = 1:size(triangles,1)
        tri_coor = coords(triangles(k,:), :);
        sigma_k = roundness(tri_coor);

        if sigma_k > max_sigma
            max_sigma = sigma_k;
        end
    end

    quality = max_sigma;
end
