module 0x1::bank {
    struct Vault has key {
        amount: u64,
    }

    public fun open(account: &signer) {
        move_to(account, Vault { amount: 0 });
    }

    public fun balance(addr: address): u64 acquires Vault {
        borrow_global<Vault>(addr).amount
    }

    public fun credit(addr: address, delta: u64) acquires Vault {
        let vault = borrow_global_mut<Vault>(addr);
        vault.amount = vault.amount + delta;
    }

    public fun close(addr: address): u64 acquires Vault {
        let Vault { amount } = move_from<Vault>(addr);
        amount
    }

    public fun is_open(addr: address): bool {
        exists<Vault>(addr)
    }
}
