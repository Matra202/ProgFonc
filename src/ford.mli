open Graph

(*self explanatory*)
val idoption_to_id : id option -> id

(*self explanatory*)
val listoption_to_list : id list option -> id list

(*Prend un graphe sans cycle classique et le transforme 
  en graphe résiduel*)
val initalize_residual: int graph -> int graph

(*Gets int flow from id1 to id2 option int value of flow*)
val get_max_flow_aux : int graph -> id -> id -> int 

(*Ajoute le maximum possible de flot de id1 à id2
  sur un graphe résiduel*)
val add_max_residual: int graph -> id -> id -> int graph

(*Pareil qu'avant mais valeur choisie à ajouter mais 
  ne peut dépasser le max ajoutable tel que les arcs
  entre id1 et id2 soient dans les deux sens positifs*)
val add_residual: int graph -> id -> id -> int -> int graph

(*Never used in the end*)
val reset_flow : int graph -> id -> id -> int graph

(*Liste les successeurs dont la valeur de arc est 
  Strictement supérieure à 0*)
val node_successors : int graph -> id -> id list

(*Récupère le flot maximal que l'on peut ajouter 
  à un chemin*)
val get_max_flow_of_path : int graph -> id -> id list -> int 

(*Ajoute le flot choisi à un chemin*)
val add_flow_to_path : int graph -> id -> id list -> int -> int graph

(* pour get le flow actuel on get la capacity du strat une fois le graph
   résiduel initalisé et on fait la différence entre la capacity initiale
   et actuelle*)
val get_total_capacity : int graph -> id -> int 

(*Récupère le flot total du graphe*)
val get_flow : int graph -> id -> int 

(*Renvoie un path en list option dans un graphe 
  entre id1 et id2*)
val has_path : int graph -> id -> id -> id list option

(*Applique l'algo de Ford Fulkerson et renvoie un 
  grah résiduel int graph qu'il faut afficher correctement*)
val ford : int graph -> id -> id -> int graph 

(*Graphe résiduel en graphe de flot en comparant au 
  graphe initial*)
val resi_to_flow : int graph -> int graph -> int graph

(*Affiche proprement un graphe de flot en comparant au 
  graphe initial*)
val last_affichage : int graph -> int graph -> string graph