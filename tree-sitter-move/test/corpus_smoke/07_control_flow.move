module 0x1::flow {
    public fun classify(n: u64): u64 {
        if (n == 0) {
            0
        } else if (n < 10) {
            1
        } else {
            2
        }
    }

    public fun sum_to(n: u64): u64 {
        let total = 0;
        let i = 0;
        while (i <= n) {
            total = total + i;
            i = i + 1;
        };
        total
    }

    public fun first_power_above(threshold: u64): u64 {
        let value = 1;
        loop {
            if (value > threshold) break;
            value = value * 2;
        };
        value
    }

    public fun checked_div(a: u64, b: u64): u64 {
        assert!(b != 0, 100);
        if (a < b) abort 101;
        a / b
    }
}
