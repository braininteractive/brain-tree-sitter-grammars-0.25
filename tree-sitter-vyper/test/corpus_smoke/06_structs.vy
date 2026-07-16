# @version ^0.3.7

struct Bid:
    bidder: address
    amount: uint256
    blinded: bytes32

struct Auction:
    beneficiary: address
    highest_bid: uint256
    ended: bool

highest: Bid

@external
def place_bid(blinded: bytes32):
    self.highest = Bid({bidder: msg.sender, amount: msg.value, blinded: blinded})

@external
@view
def current_amount() -> uint256:
    return self.highest.amount
