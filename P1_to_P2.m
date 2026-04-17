"""Fonction pour passer d'un maillage P_1 à un maillage P_2
Parmaètre : mesh_P1 : maillage triangulaire pour méthode P1"""

function mesh_P2 = P1_to_P2(mesh_P1)
  coords = mesh_P1.coords;
  triangles = mesh_P1.triangles;
  triangles2 = [triangles , zeros(size(triangles,1), 3)];
  coords2 = coords;
  [ edges , edges_triangles ] = build_edge_connectivity (mesh_P1);

  for l = 1 : size(edges,1);
    n1 = edges(l,1);
    n2 = edges(l,2);
    add_coord = (coords(n1,:) + coords(n2, : ))/2;
    coords2(end+1, :) = add_coord;
    new_size = size(coords2, 1);
    for i = edges_triangles{l};
      if isequal(sort([n1 n2]), sort(triangles(i,[1 2])));
        triangles2(i,4) = new_size;
      elseif isequal(sort([n1 n2]), sort(triangles(i,[2 3])));
        triangles2(i,5) = new_size;
      else ;
       triangles2(i,6) = new_size;
      end
    end
  end
  mesh_P2 = mesh_new('',coords2, triangles2);
 end
