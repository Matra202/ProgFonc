open Graph

val idoption_to_id : id option -> id

val listoption_to_list : id list option -> id list

val initalize_residual: int graph -> int graph

val get_max_flow : int graph -> id -> id -> int 

val add_max_residual: int graph -> id -> id -> int graph

val add_residual: int graph -> id -> id -> int -> int graph

val reset_flow : int graph -> id -> id -> int graph

val node_successors : int graph -> id -> id list

(*val find_path : int graph -> id -> id -> id list
*)
val get_max_flow_of_path : int graph -> id -> id list -> int 

val add_flow_to_path : int graph -> id -> id list -> int -> int graph

(* pour get le flow actuel on get la capacity du strat une fois le graph
   résiduel initalisé et on fait la différence entre la capacity initiale
   et actuelle*)
val get_total_capacity : int graph -> id -> int 

val get_flow : int graph -> id -> int 

val has_path : int graph -> id -> id -> id list option

val ford : int graph -> id -> id -> int graph 

val resi_to_flow : int graph -> int graph -> int graph

val last_affichage : int graph -> int graph -> string graph