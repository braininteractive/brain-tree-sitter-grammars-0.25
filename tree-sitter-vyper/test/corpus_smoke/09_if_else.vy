# @version ^0.3.7

tier: public(uint256)

@external
def classify(balance: uint256):
    if balance >= 1000:
        self.tier = 3
    elif balance >= 100:
        self.tier = 2
    elif balance > 0:
        self.tier = 1
    else:
        self.tier = 0

@internal
@pure
def _pick(flag: bool, a: uint256, b: uint256) -> uint256:
    if flag and a > b:
        return a
    if not flag or b == 0:
        return b
    return a + b
