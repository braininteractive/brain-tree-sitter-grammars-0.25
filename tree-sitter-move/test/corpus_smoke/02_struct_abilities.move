module 0x1::coin_store {
    struct Coin has key, store {
        value: u64,
    }

    struct Wallet has key {
        balance: Coin,
        owner: address,
    }

    struct Receipt has copy, drop {
        amount: u64,
        timestamp: u64,
    }
}
