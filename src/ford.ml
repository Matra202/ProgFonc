open Graph
open Gfile
open Tools

let initalize_residual gr = 
  e_fold gr (fun g id1 id2 a -> (new_arc g id2 id1 0)) gr

let add_max_residual gr id1 id2=
  let max_op = find_arc gr id1 id2 in 
  match max_op with 
  |None -> gr
  |Some a -> let max = a in 
    add_arc (add_arc gr id1 id2 (-max)) id2 id1 max

let add_residual gr id1 id2 x = 
  let max_op = find_arc gr id1 id2 in 
  match max_op with 
  |None -> gr
  |Some a -> if (x<a) then 
      add_arc (add_arc gr id1 id2 (-x)) id2 id1 x
    else
      add_arc (add_arc gr id1 id2 (-a)) id2 id1 a

let reset_flow gr id1 id2 = 
  let gr = add_max_residual gr id2 id1 in
  let max_op = find_arc gr id2 id1 in 
  match max_op with 
  |None -> gr
  |Some a -> let max = a in 
    add_arc (add_arc gr id2 id1 (-max)) id1 id2 (max)

(*let find_path (g : int graph) id1 id2 (path, augment) = 
  (* places the backpointer path for the graph in previous *)
  let rec dfs (frontier : node Stack.t) (previous : (node,node) Hashtbl.t) : unit = 
    let update_data parent f p candidate : unit = 
      if Hashtbl.mem p candidate then () else
        begin Stack.push candidate f;
          Hashtbl.add p candidate parent end in 
    if Stack.is_empty frontier then () else
      let cur = Stack.pop frontier in
      G.neighbors g cur |> List.split |> fst |> List.iter (update_data cur frontier previous);
      if Hashtbl.mem previous (G.sink g) then () else
        dfs frontier previous in 
  (* transforms a list of nodes into a list of edges between them, but reverses order *)
  let rec edgify (acc : path) : node list -> path = function
    | n1 :: n2 :: tl -> edgify ((n1, n2) :: acc) (n2::tl)
    | _ -> acc in 
  let q = Stack.create () in 
  Stack.push (G.source g) q;
  let parents = G.size g |> Hashtbl.create in
  dfs q parents;
  let rec extract_path : node list -> node list = function
    | h :: t -> let prev = Hashtbl.find parents h in 
      if prev = G.source g then prev :: h :: t else
        extract_path (prev :: h :: t)
    | _ -> failwith "impossible" in
  try begin 
    Some (extract_path [G.sink g] |> edgify [])
  end with Not_found -> None *)