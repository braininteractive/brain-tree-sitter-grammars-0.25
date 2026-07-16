# @version ^0.3.7

event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    amount: uint256

event Paused:
    by: address

balances: HashMap[address, uint256]

@external
def transfer(to: address, amount: uint256):
    self.balances[msg.sender] -= amount
    self.balances[to] += amount
    log Transfer(msg.sender, to, amount)

@external
def pause():
    log Paused(msg.sender)
