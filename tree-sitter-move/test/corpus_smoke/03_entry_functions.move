module 0x1::transfer {
    entry fun deposit(account: &signer, amount: u64) {
        let _ = account;
        let _ = amount;
    }

    public entry fun withdraw(account: &signer, amount: u64) {
        let _ = account;
        let _ = amount;
    }

    public(friend) fun internal_move(amount: u64): u64 {
        amount
    }
}
