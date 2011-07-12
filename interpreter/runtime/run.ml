
exception End_of_run;;

let add_block graph block =
   let tmp_array = Array.make 1 block in
   let index = Array.length graph in
   (Array.append graph tmp_array, index)
;;

let try_exec graph block =
   (graph, [])
;;

let rec run graph = function
   | [] -> raise End_of_run
   | block::others -> begin
      let (new_graph, added_blocs) = try_exec graph block
      in run new_graph (others @ added)
   end
;;

