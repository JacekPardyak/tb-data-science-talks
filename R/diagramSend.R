library(DiagrammeR)
?DiagrammeR
DiagrammeR("
  graph LR
           A-->B
           A-->C
           C-->E
           B-->D
           C-->D
           D-->F
           E-->F
           ")

DiagrammeR("
graph LR
A(Rounded)-->B[Squared]
B-->C{A Decision}
C-->D[Square One]
C-->E[Square Two]

")



## Not run: 
# Create an empty graph
graph <- create_graph()

# Create a graph with nodes but no edges
nodes <- create_nodes(nodes = c("a", "b", "c", "d"))

graph <- create_graph(nodes_df = nodes)

# Create a graph with nodes with values, types, labels
nodes <- create_nodes(nodes = c("a", "b", "c", "d"),
                      label = TRUE,
                      type = c("type_1", "type_1",
                               "type_5", "type_2"),
                      shape = c("circle", "circle",
                                "rectangle", "rectangle"),
                      values = c(3.5, 2.6, 9.4, 2.7))

graph <- create_graph(nodes_df = nodes)

# Create a graph from an edge data frame, the nodes will
edges <- create_edges(from = c("a", "b", "c"),
                      to = c("d", "c", "a", "a"),
                      rel = "leading_to")

graph <- create_graph(edges_df = edges)

# Create a graph with both nodes and nodes defined, and,
# add some default attributes for nodes and edges
graph <- create_graph(nodes_df = nodes,
                      edges_df = edges)

render_graph(graph)
