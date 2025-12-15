# Fourmolu-Dhall

**Fourmolu-Dhall** is a Dhall library for writing **type-safe Fourmolu configuration** and rendering it into a YAML-compatible form.

It provides a typed, high-level model of Fourmolu options and then **lowers** that model into the concrete values expected by `fourmolu.yaml`.

## Overview

Fourmolu configuration is typically written in YAML. While convenient, YAML can become difficult to maintain as configurations grow: invalid values are only discovered at runtime, and boolean flags or stringly-typed options increase cognitive load.

Fourmolu-Dhall addresses these issues by:
- encoding the full set of Fourmolu options as Dhall types
- validating configurations at compile time
- rendering only valid configurations into a YAML-compatible representation

## Why Fourmolu-Dhall

- **Type safety**  
  All options are validated by the Dhall type checker. Invalid values, missing fields, and mismatched types are rejected before YAML is generated.

- **Fourmolu-default compatible**  
  The provided defaults correspond exactly to Fourmolu’s defaults.

- **Explicit configuration**  
  Boolean and enum-like options are represented as labeled constructors instead of raw `true` / `false` or strings.

- **Complete option coverage**  
  The library aims to cover the full set of Fourmolu configuration options.

## Usage

```dhall
-- examples/example.dhall

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

The `examples/` directory contains self-contained examples that can be converted to YAML directly using `dhall-to-yaml`, without additional imports.

`F.Fourmolu` provides defaults that match Fourmolu’s own defaults.
The `(::)` operator can be used to override only the options you want to customize.

Options such as `fixities`, `reexports`, and `local-modules` can be configured in the same way.

### Generating `fourmolu.yaml`

After writing your configuration in Dhall, generate `fourmolu.yaml` with `dhall-to-yaml`:

```bash
dhall-to-yaml --preserve-null --file fourmolu.dhall --output fourmolu.yaml
```

**Note**: The `--preserve-null` flag is required. Some fields are intentionally rendered as null to match Fourmolu’s configuration shape. Without this flag, null fields may be dropped during conversion, which can change the resulting YAML.

## Design

Fourmolu-Dhall separates configuration into three layers:

Typed model (`Fourmolu.Type`)
A high-level representation that encodes intent and valid option domains.

Lowering step (`convert`)
Translates typed constructors into the concrete values expected by Fourmolu.

Rendering (`render`)
Produces a YAML-compatible record suitable for conversion to `fourmolu.yaml`.

This separation allows the Dhall types to remain expressive and safe, while still producing configurations that Fourmolu can consume directly.