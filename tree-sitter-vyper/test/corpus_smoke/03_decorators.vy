# @version ^0.3.7

counter: public(uint256)

@external
@payable
def deposit():
    self.counter += 1

@internal
def _bump(amount: uint256):
    self.counter += amount

@external
@view
def peek() -> uint256:
    return self.counter

@internal
@pure
def _double(x: uint256) -> uint256:
    return x * 2
