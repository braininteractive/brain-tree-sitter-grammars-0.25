local M = {}

local PRIVATE_LIMIT = 10

function M.clamp(n)
  if n > PRIVATE_LIMIT then
    return PRIVATE_LIMIT
  end
  return n
end

M.VERSION = "1.0"

goto continue
::continue::

return M
