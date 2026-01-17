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