function mesh_out = mesh_by_barycenters(boundary_vertices, mesh_size)

    h = mesh_size;

    %% --------------------------------------------------
    % 1) Raffinement de la frontière
    %% --------------------------------------------------

    points = boundary_vertices;
    i = 1;

    while i <= size(points,1)

        next = mod(i, size(points,1)) + 1;

        edge_length = norm(points(i,:) - points(next,:));

        if edge_length > h
            new_point = (points(i,:) + points(next,:)) / 2;

            % insertion dans le tableau
            points = [points(1:i,:);
                      new_point;
                      points(i+1:end,:)];

        else
            i = i + 1;
        end
    end


    %% --------------------------------------------------
    % 2) Triangulation initiale
    %% --------------------------------------------------

    triangles = delaunayn(points);
    mesh_out  = mesh_new('', points, triangles);

    [triangle_number, max_edge_size] = ...
        find_worst_triangle(mesh_out);


    %% --------------------------------------------------
    % 3) Raffinement barycentrique
    %% --------------------------------------------------

    iter = 0;
    max_iter = 10000;   % sécurité numérique

    while max_edge_size > h && iter < max_iter

        iter = iter + 1;

        a = points(triangles(triangle_number,1),:);
        b = points(triangles(triangle_number,2),:);
        c = points(triangles(triangle_number,3),:);

        barycenter = (a + b + c) / 3;

        points(end+1,:) = barycenter;

        triangles = delaunayn(points);
        mesh_out  = mesh_new('', points, triangles);

        [triangle_number, max_edge_size] = ...
            find_worst_triangle(mesh_out);
    end

end
