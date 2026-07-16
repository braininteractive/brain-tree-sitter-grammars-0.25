#[test_only]
module 0x1::math_tests {
    use 0x1::config;

    #[test]
    fun test_max_supply() {
        assert!(config::max_supply() == 1000000, 0);
    }

    #[test, expected_failure(abort_code = 101)]
    fun test_expected_abort() {
        abort 101
    }

    #[test(owner = @0x1)]
    fun test_with_signer(owner: &signer) {
        let _ = owner;
    }

    #[view]
    public fun helper(): u64 {
        7
    }
}
