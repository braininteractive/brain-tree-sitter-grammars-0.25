module 0x1::config {
    const MAX_SUPPLY: u64 = 1000000;
    const MODULE_OWNER: address = @0x1;
    const ENABLED: bool = true;
    const ERROR_NOT_OWNER: u64 = 0x10;
    const NAME: vector<u8> = b"config";
    const BIG: u128 = 340282366920938463463374607431768211455;
    const TINY: u8 = 255;

    public fun max_supply(): u64 {
        MAX_SUPPLY
    }

    public fun owner(): address {
        MODULE_OWNER
    }
}
