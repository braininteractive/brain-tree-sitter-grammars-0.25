# @version ^0.3.7

owner: address
locked: bool

@external
def withdraw(amount: uint256):
    assert msg.sender == self.owner, "not owner"
    assert not self.locked
    if amount == 0:
        raise "zero amount"
    send(self.owner, amount)

@internal
def _guard():
    if self.locked:
        raise
