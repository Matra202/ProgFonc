open Gfile
open Tools
open Ford 
open Printf

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile (graph) in
  (*export "outgraphexport" (graph_int_to_string(reset_flow(add_residual(initalize_residual (graph_string_to_int graph))0 3 15)0 3));*)
  (*let a = node_successors (initalize_residual(graph_string_to_int graph)) 3 in 
    let b = find_path (graph_string_to_int graph) 0 5 in
    List.iter (printf "\nLes successeurs de 3 sont : %d \n") a ;
    printf("Le chemin pour aller de 0 à 5 n'est pas: ") ;
    List.iter (printf "%d, ") b;*)
  let a = initalize_residual(graph_string_to_int graph) in
  let d = has_path (initalize_residual(graph_string_to_int graph)) 0 5 in 
  let e = listoption_to_list d
  in
  printf("\n\nLe chemin pour aller de 0 à 5 est : ") ;
  List.iter (printf "%d, ") e;
  let f = add_flow_to_path a 0 e (get_max_flow_of_path a 0 e) in
  let d2 = has_path f 0 5 in 
  let e2 = listoption_to_list d2
  in
  printf("\n\nLe chemin pour aller de 0 à 5 est : ") ;
  List.iter (printf "%d, ") e2;
  let f2 = add_flow_to_path f 0 e2 (get_max_flow_of_path f 0 e2) in
  let d3 = has_path f2 0 5 in 
  let e3 = listoption_to_list d3
  in
  printf("\n\nLe chemin pour aller de 0 à 5 est : ") ;
  List.iter (printf "%d, ") e3;
  let f3 = add_flow_to_path f2 0 e3 (get_max_flow_of_path f2 0 e3) in
  let g = ford (graph_string_to_int graph) 0 5 in
  (*
    let c = get_max_flow_of_path (initalize_residual(graph_string_to_int graph))0 [0;1;4;5] in
    printf("\n\nLe max de flow pour le chemin 0-1-4-5 est : %d") c ;
    printf("\n\nLe result est pour 0 : %d") (get_flow(add_flow_to_path(initalize_residual (graph_string_to_int graph)) 0 [0;1;4;5] c) 0);*)
  export "outgraphexport" (graph_int_to_string(f3));
  ()