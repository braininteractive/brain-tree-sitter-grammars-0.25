open System.Threading.Tasks

let fetchData id = async {
    do! Async.Sleep 10
    return sprintf "data%d" id
}

let combined = async {
    let! a = fetchData 1
    let! b = fetchData 2
    return a + b
}

let taskBased () = task {
    let! result = Task.FromResult 42
    return result + 1
}
