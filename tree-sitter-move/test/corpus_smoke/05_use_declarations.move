module 0x1::imports {
    use std::vector;
    use std::signer;
    use 0x1::coin_store::{Self, Coin};
    use 0x1::bank::Vault as SavedVault;

    public fun setup(account: &signer): address {
        let addr = signer::address_of(account);
        let items = vector::empty<u64>();
        vector::destroy_empty(items);
        addr
    }
}
