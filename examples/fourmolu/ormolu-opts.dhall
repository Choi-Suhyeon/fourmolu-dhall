-- NOTE:
-- This file is a vendored copy of ../../ormolu-opts.dhall
-- It exists to allow running dhall-to-yaml directly in examples/.
 
let I = ./Internal.dhall
let T = I.BaseTypes

let Ormolu =
    { Type = I.CommonType
    , default =
        { indentation = 2
        , column-limit = T.ColumnLimit.Non
        , function-arrows = T.FunctionArrows.Trailing
        , comma-style = T.CommaStyle.Trailing
        , record-style = T.RecordStyle.Aligned
        , import-export-style = T.ImportExportStyle.Trailing
        , import-grouping = T.ImportGrouping.Legacy
        , indent-wheres = T.IndentWheres.WithIndentedWheres
        , record-brace-space = T.RecordBraceSpace.WithSpacing
        , newlines-between-decls = 1
        , haddock-style = T.HaddockStyle.SingleLine
        , haddock-style-module = T.HaddockStyleModule.Null
        , haddock-location-signature = T.HaddockLocationSignature.Auto
        , let-style = T.LetStyle.Inline
        , in-style = T.InStyle.RightAlign
        , if-style = T.IfStyle.Indented
        , single-constraint-parens = T.SingleConstraintParens.Always
        , single-deriving-parens = T.SingleDerivingParens.Always
        , sort-constraints = T.SortConstraints.WithoutSorting
        , sort-derived-classes = T.SortDerivedClasses.WithoutSorting
        , sort-deriving-clauses = T.SortDerivingClauses.WithoutSorting
        , trailing-section-operators = T.TrailingSectionOperators.WithTrailingSectionOperators
        , unicode = T.Unicode.Never
        , respectful = T.Respectful.WithoutRespect
        , fixities = [] : List Text
        , reexports = [] : List Text
        , local-modules = [] : List Text
        }
    }

in
    T // { Ormolu, render = I.render }