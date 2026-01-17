let
    O = ./fourmolu/ormolu-opts.dhall
in
    O.render O.Ormolu::
        { respectful = O.Respectful.WithRespect
        , haddock-style = O.HaddockStyle.MultiLineCompact
        , haddock-style-module = O.HaddockStyleModule.MultiLineCompact
        , let-style = O.LetStyle.Mixed
        , newlines-between-decls = 2
        , indentation = 4
        , column-limit = O.ColumnLimit.Non
        }