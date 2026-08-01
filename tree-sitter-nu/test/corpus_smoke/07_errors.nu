try {
  open missing.json
} catch { |err|
  print $"failed: ($err.msg)"
}
