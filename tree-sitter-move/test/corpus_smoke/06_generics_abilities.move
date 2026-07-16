module 0x1::container {
    struct Box<T: store> has key, store {
        contents: T,
    }

    struct Pair<T1: copy + drop, T2: copy + drop> has copy, drop {
        first: T1,
        second: T2,
    }

    public fun wrap<T: store>(value: T): Box<T> {
        Box { contents: value }
    }

    public fun unwrap<T: store>(box: Box<T>): T {
        let Box { contents } = box;
        contents
    }

    public fun swap<A: copy + drop, B: copy + drop>(p: Pair<A, B>): Pair<B, A> {
        Pair { first: p.second, second: p.first }
    }

    struct Phantom<phantom Tag> has key {
        value: u64,
    }
}
