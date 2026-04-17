function [ edges , edges_triangles ] = build_edge_connectivity (my_mesh)
  edges_triangles = {};
  edges =[];

  triangles = my_mesh.triangles;
  for i = 1 : size(triangles, 1);
    local_edges = [triangles(i,1), triangles(i,2); triangles(i,2), triangles(i,3); triangles(i,1), triangles(i,3)];
    for j = 1 : 3;
     B = false;
     e = sort(local_edges(j,:));
     for l = 1:size(edges,1);
       if isequal(e,edges(l,:));
         edges_triangles{l} = [edges_triangles{l},i];
         B = true;
         break
       end
     end
     if ~B;
       edges(end+1,:) = e;
       edges_triangles{end+1} = i;
     end
    end
  end
end
