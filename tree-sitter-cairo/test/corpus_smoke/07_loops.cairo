fn sum_to(n: u32) -> u32 {
    let mut total = 0;
    let mut i = 0;
    while i <= n {
        total += i;
        i += 1;
    };
    total
}

fn count_down(mut n: u32) {
    loop {
        if n == 0 {
            break;
        }
        n -= 1;
    }
}
