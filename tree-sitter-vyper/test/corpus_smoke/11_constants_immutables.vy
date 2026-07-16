# @version ^0.3.7

MAX_SUPPLY: constant(uint256) = 10_000_000
FEE_BPS: constant(uint256) = 25
DEPLOYER: immutable(address)
START_TIME: immutable(uint256)

minted: uint256

@external
def __init__():
    DEPLOYER = msg.sender
    START_TIME = block.timestamp

@external
def mint(amount: uint256):
    assert self.minted + amount <= MAX_SUPPLY
    self.minted += amount
