conditional:
    if [ -f Cargo.toml ]; then \
      echo rust; \
    else \
      echo other; \
    fi
