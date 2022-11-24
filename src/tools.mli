open Graph

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph

val graph_int_to_string : int graph -> string graph
val graph_string_to_int : string graph -> int graph 