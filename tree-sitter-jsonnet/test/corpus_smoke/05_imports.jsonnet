// import and importstr expressions.
local lib = import "library.libsonnet";
local settings = import "config/settings.libsonnet";
local readme = importstr "README.md";

{
  fromLib: lib,
  config: settings,
  rawText: readme,
  inline: (import "other.libsonnet") + { extra: true },
}
