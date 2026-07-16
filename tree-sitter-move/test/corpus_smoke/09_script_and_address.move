script {
    use std::signer;

    fun main(account: &signer) {
        let _addr = signer::address_of(account);
    }
}

address 0x42 {
    module alpha {
        public fun one(): u64 { 1 }
    }

    module beta {
        public fun two(): u64 { 2 }
    }
}
