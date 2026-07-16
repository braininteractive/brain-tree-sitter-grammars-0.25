# @version ^0.3.7

balances: public(HashMap[address, uint256])
allowances: HashMap[address, HashMap[address, uint256]]
scores: HashMap[uint256, int128]

@external
def approve(spender: address, amount: uint256):
    self.allowances[msg.sender][spender] = amount

@external
@view
def allowance(owner: address, spender: address) -> uint256:
    return self.allowances[owner][spender]
