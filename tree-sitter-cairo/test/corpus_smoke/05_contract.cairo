#[starknet::contract]
mod SimpleStorage {
    #[storage]
    struct Storage {
        stored_value: u128,
    }

    #[external(v0)]
    fn set(ref self: ContractState, value: u128) {
        self.stored_value.write(value);
    }

    #[external(v0)]
    fn get(self: @ContractState) -> u128 {
        self.stored_value.read()
    }
}
