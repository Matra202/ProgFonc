open Graph
open Gfile
open Tools

let initalize_residual gr = 
  e_fold gr (fun g id1 id2 a -> (new_arc g id2 id1 0)) gr

let get_max_flow_aux gr id1 id2 = 
  let max_op = find_arc gr id1 id2 in 
  match max_op with 
  |None -> 0
  |Some a -> a

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

let node_successors gr n = 
  List.map (fun (id,_) -> id) (List.filter (fun (id,a) -> a>0) (out_arcs gr n))


let has_path g nodes nodefin= 
  (*recpath (node::visited) (succ) in*)
  let rec recpath visited node = 
    if not (List.mem node visited) then
      begin
        if (node = nodefin) then 
          Some( List.rev (node::visited))
        else
          let node_s = node_successors g node in 
          List.find_map (recpath (node::visited)) node_s 
      end
    else
      None
  in 
  recpath [] nodes



(* il faut que g soit résiduel *)
(*let find_path (g : int graph) id1 id2 = assert false*)
(*List.find_map has_path node_s*)


let get_max_flow_of_path gr start path = 
  let rec rmax acu lastnode path2 = 
    match path2 with 
    |[] -> acu
    |x::tail -> if (x=start) then 
        rmax acu x tail
      else
        rmax (min(get_max_flow_aux gr lastnode x) acu)  x tail
  in
  rmax 9999 start path

let idoption_to_id id =
  match id with 
  |None -> 0 
  | Some x -> x

let listoption_to_list l =
  match l with 
  |None -> []
  | Some x -> x

let add_flow_to_path gr start path flow = 
  let rec radd acu lastnode path2 =  
    match path2 with 
    |[] -> acu
    |x::tail -> if (x=start) then 
        radd acu x tail
      else
        radd (add_residual acu lastnode x flow) x tail
  in
  radd gr start path


let get_total_capacity gr start = 
  List.fold_left (fun x y-> x + y) 0 (List.map (fun (id,a) -> a) (out_arcs gr start))


(*fonction bien trop compliquée qui généralise au cas où il peut y avoir 
  plusieurs arcs d'une node vers une autre pour absolument aucune raison*)
let get_flow gr start = 
  let nodes = List.map (fun (id,_) -> id) (out_arcs gr start) in 
  let rec rflow acu snode = 
    match snode with 
    |[] -> acu 
    | node::tail -> rflow (acu + List.fold_left (fun x y-> x + y) 0 (List.map (fun (id,a) -> a) (List.filter (fun (id,a) -> id=start) (out_arcs gr node)))) tail
  in
  rflow 0 nodes

let ford gr start fin = 
  let g=initalize_residual gr in
  let rec recford gra = 
    let hp = (listoption_to_list (has_path gra start fin))in 
    if (hp=[]) then
      gra
    else
      recford (add_flow_to_path gra start hp (get_max_flow_of_path gra start hp))
  in
  recford g


let resi_to_flow gr fg  =
  let gr2 = clone_nodes gr in
  e_fold gr ( fun g id1 id2 label -> 
      let label = find_arc fg id2 id1 in
      (match label with
       | Some x -> new_arc g id1 id2 x
       | None -> new_arc g id1 id2 0)
    ) gr2

let last_affichage graph_initial graph_final = 
  let gr2 = clone_nodes graph_initial in
  e_fold graph_initial (fun g id1 id2 label -> 
      let label = find_arc graph_final id1 id2 in
      (match label with
       | Some x -> let label2 = find_arc graph_initial id1 id2 in 
         (match label2 with
          | Some y -> new_arc g id1 id2 ((string_of_int x)^"/"^(string_of_int y))
          |None -> new_arc g id1 id2 "0")

       | None -> new_arc g id1 id2 "0")
    ) gr2