-- Imports: local paths, environment variables, remote URLs with hash,
-- import alternatives (?), and importing as Text.
let localPackage = ./package.dhall

let parentConfig = ../config/defaults.dhall

let fromEnv = env:DHALL_SETTINGS

let remote =
      https://prelude.dhall-lang.org/v20.2.0/package.dhall
        sha256:a6036bc38d883450598d1de7c98ead113196fe2db02e9733855668b18096f07b

let fallback = env:MISSING_VAR ? ./fallback.dhall ? "default"

let rawText = ./notes.txt as Text

in  { localPackage, parentConfig, fromEnv, remote, fallback, rawText }
