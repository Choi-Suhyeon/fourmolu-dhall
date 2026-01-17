-- NOTE:
-- This file is a vendored copy of ../../fourmolu-opts.dhall
-- It exists to allow running dhall-to-yaml directly in examples/.
 
let I = ./Internal.dhall
let T = I.BaseTypes

let Fourmolu =
    { Type = I.CommonType
    , default =
        { indentation = 4
        , column-limit = T.ColumnLimit.Non
        , function-arrows = T.FunctionArrows.Trailing
        , comma-style = T.CommaStyle.Leading
        , record-style = T.RecordStyle.Aligned
        , import-export-style = T.ImportExportStyle.DiffFriendly
        , import-grouping = T.ImportGrouping.Legacy
        , indent-wheres = T.IndentWheres.WithoutIndentedWheres
        , record-brace-space = T.RecordBraceSpace.WithoutSpacing
        , newlines-between-decls = 1
        , haddock-style = T.HaddockStyle.MultiLine
        , haddock-style-module = T.HaddockStyleModule.Null
        , haddock-location-signature = T.HaddockLocationSignature.Auto
        , let-style = T.LetStyle.Auto
        , in-style = T.InStyle.RightAlign
        , if-style = T.IfStyle.Indented
        , single-constraint-parens = T.SingleConstraintParens.Always
        , single-deriving-parens = T.SingleDerivingParens.Always
        , sort-constraints = T.SortConstraints.WithoutSorting
        , sort-derived-classes = T.SortDerivedClasses.WithoutSorting
        , sort-deriving-clauses = T.SortDerivingClauses.WithoutSorting
        , trailing-section-operators = T.TrailingSectionOperators.WithTrailingSectionOperators
        , unicode = T.Unicode.Never
        , respectful = T.Respectful.WithRespect
        , fixities = [] : List Text
        , reexports = [] : List Text
        , local-modules = [] : List Text
        }
    }

in
    T // { Fourmolu, render = I.render }