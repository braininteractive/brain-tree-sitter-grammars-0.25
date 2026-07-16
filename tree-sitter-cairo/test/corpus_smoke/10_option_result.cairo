fn safe_div(a: u32, b: u32) -> Option<u32> {
    if b == 0 {
        Option::None
    } else {
        Option::Some(a / b)
    }
}

fn checked(v: Option<u32>) -> u32 {
    match v {
        Option::Some(x) => x,
        Option::None => 0,
    }
}
