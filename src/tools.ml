(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes gr = 
  n_fold gr (fun g -> new_node empty_graph) empty_graph

let gmap (gr: 'a graph) (f: 'a -> 'b)  = 
  let gr2 = clone_nodes gr in 
  e_fold gr (fun g id1 id2 a -> (new_arc gr2 id1 id2 (f a))) empty_graph

let add_arc gr id1 id2 n = 
  let found = find_arc gr id1 id2 in 
  match found with 
  |None -> new_arc gr id1 id2 n
  |Some v -> new_arc gr id1 id2 (v + n)


let graph_int_to_string gr = 
  gmap gr string_of_int;
