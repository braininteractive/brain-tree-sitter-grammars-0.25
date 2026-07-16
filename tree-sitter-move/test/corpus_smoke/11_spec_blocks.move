module 0x1::verified_math {
    spec module {
        pragma verify = true;
        pragma aborts_if_is_strict;
    }

    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    spec add {
        aborts_if a + b > MAX_U64;
        ensures result == a + b;
    }

    public fun double(x: u64): u64 {
        x * 2
    }

    spec double {
        ensures result == x * 2;
    }

    spec fun spec_square(x: num): num {
        x * x
    }
}
