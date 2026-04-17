coords = [0 ,0;1 ,0;1 ,1;0 ,1;.5 ,.5];
triangles = [1 2 5;2 3 5;5 4 3;1 5 4];
my_mesh = mesh_new ( '' , coords , triangles );
co = getfield( my_mesh , 'coords' );
tr = getfield( my_mesh , 'triangles' );
my_mesh.name = 'Exemple_de_maillage';
mesh_P2 = P1_to_P2(my_mesh);
size(mesh_P2.triangles,2)

