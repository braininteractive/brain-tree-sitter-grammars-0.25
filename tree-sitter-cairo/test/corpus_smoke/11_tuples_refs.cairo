fn swap(pair: (felt252, felt252)) -> (felt252, felt252) {
    let (a, b) = pair;
    (b, a)
}

fn modify(ref counter: u32) {
    counter += 1;
}
