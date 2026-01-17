# Fourmolu-Dhall

**Fourmolu-Dhall** is a Dhall library for writing **type-safe Fourmolu configurations** and rendering them into a YAML-compatible form.

It provides a typed, high-level model of Fourmolu options and then lowers that model to the concrete values expected by `fourmolu.yaml`.

## Overview

Fourmolu configuration is typically written in YAML. While convenient, YAML can become difficult to maintain as configurations grow: invalid values are only discovered at runtime, and boolean flags or stringly typed options increase cognitive load.

Fourmolu-Dhall addresses these issues by:
- encoding the full set of Fourmolu options as Dhall types
- validating configurations at compile time
- rendering only valid configurations into a YAML-compatible representation

In this setup, `fourmolu.yaml` is treated as a **generated artifact**. After adopting fourmolu-dhall, it is not expected to be edited by hand.

## Why Fourmolu-Dhall

- **Type safety**  
  All options are validated by the Dhall type checker. Invalid values, missing fields, and mismatched types are rejected before YAML is generated.

- **Fourmolu-default compatible**  
  A default configuration matching Fourmolu’s own documented defaults is provided.

- **Ormolu-default compatible**  
  A default configuration matching Ormolu’s documented defaults is also provided, for users who prefer Ormolu’s formatting style while using Fourmolu.

- **Explicit configuration**  
  Boolean and enum-like options are represented as labeled constructors rather than raw `true` / `false` values or strings.

- **Complete option coverage**  
  The library aims to cover the full set of configuration options supported by the latest version of Fourmolu.

## About Dhall

Dhall is a strongly typed, programmable configuration language designed to replace formats such as JSON and YAML when configurations become large or complex.

You only need Dhall as a configuration tool; it does not interact with your Haskell build in any way.

- Installation instructions can be found here:  
  - https://docs.dhall-lang.org/tutorials/Getting-started_Generate-JSON-or-YAML.html#installation

- An introduction to the language is available here:  
  - https://learnxinyminutes.com/dhall/
  - https://docs.dhall-lang.org/tutorials/Language-Tour.html

## Usage

### Files to Import

If you want to start from Fourmolu’s defaults, import `fourmolu-opts.dhall`. If you prefer the defaults documented for Ormolu, import `ormolu-opts.dhall` instead.

These files differ only in their default values. They both describe Fourmolu configurations and produce the same YAML shape expected by Fourmolu; Ormolu itself is not involved at runtime.

The file `internal.dhall` is not intended to be imported directly. It exists as an internal module used to organize shared definitions.

### Example

```dhall
-- examples/example-fourmolu.dhall

let
    F = ./fourmolu/fourmolu-opts.dhall
in
    F.render F.Fourmolu::
        { column-limit = F.ColumnLimit.Limit 80
        , function-arrows = F.FunctionArrows.Leading
        , import-export-style = F.ImportExportStyle.Leading
        , import-grouping = F.ImportGrouping.ByScopeThenQualified
        , let-style = F.LetStyle.Newline
        , sort-constraints = F.SortConstraints.WithSorting
        , sort-derived-classes = F.SortDerivedClasses.WithSorting
        , sort-deriving-clauses = F.SortDerivingClauses.WithSorting
        , trailing-section-operators =
            F.TrailingSectionOperators.WithoutTrailingSectionOperators
        }
```

The `examples/` directory contains self-contained configurations that can be converted to YAML directly using `dhall-to-yaml`, without additional imports. Files such as `default-fourmolu.dhall` and `default-ormolu.dhall`, which explicitly configure all options using their respective defaults, are also included.

`F.Fourmolu` provides a record with default values. The `(::)` operator can be used to override only the options you want to customize.

Options such as `fixities`, `reexports`, and `local-modules` can be configured in the same way.

### Generating `fourmolu.yaml`

After writing your configuration in Dhall, generate `fourmolu.yaml` using `dhall-to-yaml`:

```bash
dhall-to-yaml --preserve-null --file fourmolu.dhall --output fourmolu.yaml
```

**Note**: The `--preserve-null` flag is required. Some fields are intentionally rendered as `null` to match Fourmolu’s expected configuration shape. Without this flag, null fields may be dropped during conversion, which can change the resulting YAML.

### Recommended Workflow

A typical workflow is:

1. Maintain `fourmolu.dhall` under version control.
2. Treat `fourmolu.yaml` as a generated file.
3. Regenerate `fourmolu.yaml` whenever `fourmolu.dhall` changes.

To automate this, it is recommended to use a `Makefile` (or similar tooling) so that `fourmolu.yaml` is automatically regenerated when the Dhall configuration is updated. This ensures the YAML file is always kept in sync without manual edits.

This setup is completely independent of Haskell build tools such as `stack` or `cabal`. As long as `fourmolu.yaml` is up to date before formatting is run, no further integration is required.

## Design

Fourmolu-Dhall separates configuration into three layers:

### Typed model (`Fourmolu.Type`, `Ormolu.Type`)
A high-level representation that encodes intent and valid option domains. `Fourmolu.Type` is identical to `Ormolu.Type`.

### Lowering step (`convert`)
Translates typed constructors into the concrete values expected by Fourmolu. Since the `render` function uses `convert` internally, it should not be called directly.

### Rendering (`render`)
Produces a YAML-compatible record suitable for conversion to `fourmolu.yaml`.

This separation allows the Dhall types to remain expressive and safe while still producing configurations that Fourmolu can consume.

## Compatibility and Updates

This library tracks the latest released version of Fourmolu. When new configuration options are added or existing ones change, the definitions in this will be updated accordingly.