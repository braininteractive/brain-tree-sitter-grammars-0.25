# @version ^0.3.7

interface ERC20:
    def balanceOf(owner: address) -> uint256: view
    def transfer(to: address, amount: uint256) -> bool: nonpayable

interface Oracle:
    def latest_price() -> uint256: view

token: ERC20
oracle: Oracle

@external
@view
def treasury_balance() -> uint256:
    return self.token.balanceOf(self)

@external
def sweep(to: address):
    amount: uint256 = self.token.balanceOf(self)
    self.token.transfer(to, amount)
