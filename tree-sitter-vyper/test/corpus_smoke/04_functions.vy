# @version ^0.3.7

@internal
@pure
def _add(a: uint256, b: uint256) -> uint256:
    return a + b

@internal
@pure
def _weighted(value: uint256, weight: uint256, scale: uint256 = 100) -> uint256:
    return value * weight / scale

@external
@view
def combine(x: uint256, y: uint256) -> (uint256, uint256):
    total: uint256 = self._add(x, y)
    return total, self._weighted(total, 50)
