function [u,coords_maillage] = resolution_probleme(degree_EF,h)
  %Maillage de omega
  %Partie 1 : Boundary vertices
  Nb_c = floor(1/h);

  if (h < 1) && (Nb_c~=1/h)
    boundary_vertices = zeros((Nb_c+1)*4,2);
    for i = 1:Nb_c
      boundary_vertices(1+i,:) = [i*h,0];
    end
    boundary_vertices(Nb_c+2,:) = [1,0];
    for i = 1:Nb_c
      boundary_vertices(2+i+Nb_c,:) = [1,i*h];
    end
    boundary_vertices(2*Nb_c+3,:) =[1,1];
    for i = 1:Nb_c
      boundary_vertices(2*Nb_c+3+i,:) = [1-h*i,1];
    end
    boundary_vertices(3*Nb_c+4,:) = [0,1];
    for i = 1:Nb_c
      boundary_vertices(3*Nb_c+4+i,:) = [0,1-i*h];
    end

  elseif ( h <= 1 ) && ( Nb_c == 1/h )
    Nb_c = floor(1/h)
    boundary_vertices = zeros((Nb_c)*4,2);
    for i = 1:Nb_c
      boundary_vertices(1+i,:) = [i*h,0];
    end
    for i = 1:Nb_c
      boundary_vertices(1+i+Nb_c,:) = [1,i*h];
    end

    for i = 1:Nb_c
      boundary_vertices(2*Nb_c+1+i,:) = [1-h*i,1];
    end

    for i = 1:Nb_c-1
      boundary_vertices(3*Nb_c+1+i,:) = [0,1-i*h];
    end
  end
    %Les points ne sont pas forcément symétriques.

    %Partie 2 du maillage
    mesh = mesh_by_barycenters(boundary_vertices,h);
    if degree_EF==2
      mesh = P1_to_P2(mesh);
      mesh_plot(mesh,true)
    end

    %Résolution du problème
    Mass_matrix = assemble_matrix('Id','Id','f_one',mesh,degree_EF,3);
    Rigid_matrix_x = assemble_matrix('D1','D1','f_one',mesh,degree_EF,3);
    Rigid_matrix_y = assemble_matrix('D2','D2','f_one',mesh,degree_EF,3);
    A = Mass_matrix + Rigid_matrix_x + Rigid_matrix_y;
    b = assemble_vector('Id','f',mesh,degree_EF,3);

    coords_maillage = getfield(mesh,'coords');
    u = A\b;
endfunction



