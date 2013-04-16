# Tests of Incidence List

using Graphs
using Base.Test

#################################################
#
#   Directed incidence list
#
#################################################

gd = directed_incidence_list(5)

# concept test

@test implements_vertex_list(gd)    == true
@test implements_edge_list(gd)      == false
@test implements_vertex_map(gd)     == true
@test implements_edge_map(gd)       == true

@test implements_adjacency_list(gd) == true
@test implements_incidence_list(gd) == true
@test implements_bidirectional_adjacency_list(gd) == false
@test implements_bidirectional_incidence_list(gd) == false
@test implements_adjacency_matrix(gd) == false

# graph without edges

@test vertex_type(gd) == Int
@test edge_type(gd) == Edge{Int}

@test num_vertices(gd) == 5
@test num_edges(gd) == 0
@test vertices(gd) == 1:5
@test is_directed(gd) == true

for i = 1 : 5
    @test out_degree(i, gd) == 0
    @test isempty(out_edges(i, gd))
    @test isempty(out_neighbors(i, gd))
end

# graph with edges

add_edge!(gd, 1, 2)
add_edge!(gd, 2, 4)
add_edge!(gd, 1, 3)
add_edge!(gd, 3, 4)
add_edge!(gd, 2, 3)
add_edge!(gd, 4, 5)

@test num_edges(gd) == 6

@test out_degree(1, gd) == 2
@test out_degree(2, gd) == 2
@test out_degree(3, gd) == 1
@test out_degree(4, gd) == 1
@test out_degree(5, gd) == 0

@test collect(out_edges(1, gd)) == [Edge(1, 1, 2), Edge(3, 1, 3)]
@test collect(out_edges(2, gd)) == [Edge(2, 2, 4), Edge(5, 2, 3)]
@test collect(out_edges(3, gd)) == [Edge(4, 3, 4)]
@test collect(out_edges(4, gd)) == [Edge(6, 4, 5)]
@test collect(out_edges(5, gd)) == Array((Int, Int), 0)

@test collect(out_neighbors(1, gd)) == [2, 3]
@test collect(out_neighbors(2, gd)) == [4, 3]
@test collect(out_neighbors(3, gd)) == [4]
@test collect(out_neighbors(4, gd)) == [5]
@test collect(out_neighbors(5, gd)) == Int[]


#################################################
#
#   Undirected incidence list
#
#################################################

gu = undirected_incidence_list(5)

# graph without edges

@test vertex_type(gu) == Int
@test edge_type(gu) == Edge{Int}

@test num_vertices(gu) == 5
@test num_edges(gu) == 0
@test vertices(gu) == 1:5
@test is_directed(gu) == false

for i = 1 : 5
    @test out_degree(i, gu) == 0
    @test isempty(out_edges(i, gu))
    @test isempty(out_neighbors(i, gu))
end

# graph with edges

add_edge!(gu, 1, 2)
add_edge!(gu, 2, 3)
add_edge!(gu, 3, 1)
add_edge!(gu, 2, 4)
add_edge!(gu, 3, 4)
add_edge!(gu, 4, 5)

@test num_edges(gu) == 6

@test out_degree(1, gu) == 2
@test out_degree(2, gu) == 3
@test out_degree(3, gu) == 3
@test out_degree(4, gu) == 3
@test out_degree(5, gu) == 1

@test collect(out_edges(1, gu)) == [Edge(1, 1, 2), Edge(3, 1, 3)]
@test collect(out_edges(2, gu)) == [Edge(1, 2, 1), Edge(2, 2, 3), Edge(4, 2, 4)]
@test collect(out_edges(3, gu)) == [Edge(2, 3, 2), Edge(3, 3, 1), Edge(5, 3, 4)]
@test collect(out_edges(4, gu)) == [Edge(4, 4, 2), Edge(5, 4, 3), Edge(6, 4, 5)]
@test collect(out_edges(5, gu)) == [Edge(6, 5, 4)]
