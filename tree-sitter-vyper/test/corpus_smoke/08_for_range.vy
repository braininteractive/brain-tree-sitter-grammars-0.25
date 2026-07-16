# @version ^0.3.7

values: uint256[16]

@external
def fill(step: uint256):
    for i in range(16):
        self.values[i] = i * step

@external
@view
def total() -> uint256:
    acc: uint256 = 0
    for i in range(0, 16):
        acc += self.values[i]
    return acc

@internal
def _scan(limit: uint256):
    for i in range(16):
        if i >= limit:
            break
        continue
