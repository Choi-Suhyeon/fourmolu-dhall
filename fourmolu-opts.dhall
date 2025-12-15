let ColumnLimit = < Non | Limit : Natural >
let FunctionArrows = < Trailing | Leading | LeadingArgs >
let CommaStyle = < Trailing | Leading >
let ImportExportStyle = < Trailing | Leading | DiffFriendly >
let RecordStyle = < Aligned | Knr >
let ImportGrouping = < Legacy | Preserve | Single | ByQualified | ByScope | ByScopeThenQualified >
let IndentWheres = < WithoutIndentedWheres | WithIndentWheres >
let RecordBraceSpace = < WithoutSpacing | WithSpacing >
let HaddockStyle = < SingleLine | MultiLine | MultiLineCompact >
let HaddockStyleModule = < Null | SingleLine | MultiLine | MultiLineCompact >
let HaddockLocationSignature = < Auto | Leading | Trailing >
let LetStyle = < Auto | Inline | Newline | Mixed >
let InStyle = < LeftAlign | RightAlign | NoSpace >
let IfStyle = < Indented | Hanging >
let SingleConstraintParens = < Auto | Always | Never >
let SingleDerivingParens = < Auto | Always | Never >
let SortConstraints = < WithoutSorting | WithSorting >
let SortDerivedClasses = < WithoutSorting | WithSorting >
let SortDerivingClauses = < WithoutSorting | WithSorting >
let TrailingSectionOperators = < WithTrailingSectionOperators | WithoutTrailingSectionOperators >
let Unicode = < Detect | Always | Never >
let Respectful = < WithRespect | WithoutRespect >

let Fourmolu =
    { Type = 
        { indentation : Natural
        , column-limit : ColumnLimit
        , function-arrows : FunctionArrows
        , comma-style : CommaStyle
        , record-style : RecordStyle
        , import-export-style : ImportExportStyle
        , import-grouping : ImportGrouping
        , indent-wheres : IndentWheres
        , record-brace-space : RecordBraceSpace
        , newlines-between-decls : Natural
        , haddock-style : HaddockStyle
        , haddock-style-module : HaddockStyleModule
        , haddock-location-signature : HaddockLocationSignature
        , let-style : LetStyle
        , in-style : InStyle
        , if-style : IfStyle
        , single-constraint-parens : SingleConstraintParens
        , single-deriving-parens : SingleDerivingParens
        , sort-constraints : SortConstraints
        , sort-derived-classes : SortDerivedClasses
        , sort-deriving-clauses : SortDerivingClauses
        , trailing-section-operators : TrailingSectionOperators
        , unicode : Unicode
        , respectful : Respectful
        , fixities : List Text
        , reexports : List Text
        , local-modules : List Text
        }
    , default =
        { indentation = 4
        , column-limit = ColumnLimit.Non
        , function-arrows = FunctionArrows.Trailing
        , comma-style = CommaStyle.Leading
        , record-style = RecordStyle.Aligned
        , import-export-style = ImportExportStyle.DiffFriendly
        , import-grouping = ImportGrouping.Legacy
        , indent-wheres = IndentWheres.WithoutIndentedWheres
        , record-brace-space = RecordBraceSpace.WithoutSpacing
        , newlines-between-decls = 1
        , haddock-style = HaddockStyle.MultiLine
        , haddock-style-module = HaddockStyleModule.Null
        , haddock-location-signature = HaddockLocationSignature.Auto
        , let-style = LetStyle.Auto
        , in-style = InStyle.RightAlign
        , if-style = IfStyle.Indented
        , single-constraint-parens = SingleConstraintParens.Always
        , single-deriving-parens = SingleDerivingParens.Always
        , sort-constraints = SortConstraints.WithoutSorting
        , sort-derived-classes = SortDerivedClasses.WithoutSorting
        , sort-deriving-clauses = SortDerivingClauses.WithoutSorting
        , trailing-section-operators = TrailingSectionOperators.WithTrailingSectionOperators
        , unicode = Unicode.Never
        , respectful = Respectful.WithRespect
        , fixities = [] : List Text
        , reexports = [] : List Text
        , local-modules = [] : List Text
        }
    }

let ColumnLimitRendered = < Non : Text | Limit : Natural >

let convert =
    { ofColumnLimit = \(x : ColumnLimit) -> merge
        { Non = ColumnLimitRendered.Non "none"
        , Limit = \(n : Natural) -> ColumnLimitRendered.Limit n
        }
        x

    , ofFunctionArrows = \(x : FunctionArrows) -> merge
        { Trailing = "trailing"
        , Leading = "leading"    
        , LeadingArgs = "leading-args"
        }
        x
    
    , ofCommaStyle = \(x : CommaStyle) -> merge
        { Trailing = "trailing"
        , Leading = "leading"
        }
        x

    , ofImportExportStyle = \(x : ImportExportStyle) -> merge
        { Trailing = "trailing"
        , Leading = "leading"
        , DiffFriendly = "diff-friendly"
        }
        x

    , ofRecordStyle = \(x : RecordStyle) -> merge
        { Aligned = "aligned"
        , Knr = "knr"
        }
        x

    , ofImportGrouping = \(x : ImportGrouping) -> merge
        { Legacy = "legacy"
        , Preserve = "preserve"
        , Single = "single"
        , ByQualified = "by-qualified"
        , ByScope = "by-scope"
        , ByScopeThenQualified = "by-scope-then-qualified"
        }
        x

    , ofIndentWheres = \(x : IndentWheres) -> merge
        { WithoutIndentedWheres = False
        , WithIndentWheres = True
        }
        x

    , ofRecordBraceSpace = \(x : RecordBraceSpace) -> merge
        { WithoutSpacing = False
        , WithSpacing = True
        }
        x

    , ofHaddockStyle = \(x : HaddockStyle) -> merge
        { SingleLine = "single-line"
        , MultiLine = "multi-line"
        , MultiLineCompact = "multi-line-compact"
        }
        x

    , ofHaddockStyleModule = \(x : HaddockStyleModule) -> merge
        { Null = None Text
        , SingleLine = Some "single-line"
        , MultiLine = Some "multi-line"
        , MultiLineCompact = Some "multi-line-compact"
        }
        x

    , ofHaddockLocationSignature = \(x : HaddockLocationSignature) -> merge
        { Auto = "auto"
        , Leading = "Leading"
        , Trailing = "Trailing"
        }
        x

    , ofLetStyle = \(x : LetStyle) -> merge
        { Auto = "auto"
        , Inline = "inline"
        , Newline = "newline"
        , Mixed = "mixed"
        }
        x

    , ofInStyle = \(x : InStyle) -> merge
        { LeftAlign = "left-align"
        , RightAlign = "right-align"
        , NoSpace = "no-space"
        }
        x

    , ofIfStyle = \(x : IfStyle) -> merge
        { Indented = "indented"
        , Hanging = "hanging"
        }
        x

    , ofSingleConstraintParens = \(x : SingleConstraintParens) -> merge
        { Auto = "auto"
        , Always = "always"
        , Never = "never"
        }
        x

    , ofSingleDerivingParens = \(x : SingleDerivingParens) -> merge
        { Auto = "auto"
        , Always = "always"
        , Never = "never"
        }
        x

    , ofSortConstraints = \(x : SortConstraints) -> merge
        { WithoutSorting = False
        , WithSorting = True
        }
        x

    , ofSortDerivedClasses = \(x : SortDerivedClasses) -> merge
        { WithoutSorting = False
        , WithSorting = True
        }
        x

    , ofSortDerivingClauses = \(x : SortDerivingClauses) -> merge
        { WithoutSorting = False
        , WithSorting = True
        }
        x

    , ofTrailingSectionOperators = \(x : TrailingSectionOperators) -> merge
        { WithTrailingSectionOperators = True
        , WithoutTrailingSectionOperators = False
        }
        x

    , ofUnicode = \(x : Unicode) -> merge
        { Detect = "detect"
        , Always = "always"
        , Never = "never"
        }
        x

    , ofRespectful = \(x : Respectful) -> merge
        { WithRespect = True
        , WithoutRespect = False
        }
        x
    }

let render = \(f : Fourmolu.Type) ->
    { indentation = f.indentation
    , column-limit = convert.ofColumnLimit f.column-limit
    , function-arrows = convert.ofFunctionArrows f.function-arrows
    , comma-style = convert.ofCommaStyle f.comma-style
    , record-style = convert.ofRecordStyle f.record-style
    , import-export-style = convert.ofImportExportStyle f.import-export-style
    , import-grouping = convert.ofImportGrouping f.import-grouping
    , indent-wheres = convert.ofIndentWheres f.indent-wheres
    , record-brace-space = convert.ofRecordBraceSpace f.record-brace-space
    , newlines-between-decls = f.newlines-between-decls
    , haddock-style = convert.ofHaddockStyle f.haddock-style
    , haddock-style-module = convert.ofHaddockStyleModule f.haddock-style-module
    , haddock-location-signature = convert.ofHaddockLocationSignature f.haddock-location-signature
    , let-style = convert.ofLetStyle f.let-style
    , in-style = convert.ofInStyle f.in-style
    , if-style = convert.ofIfStyle f.if-style
    , single-constraint-parens = convert.ofSingleConstraintParens f.single-constraint-parens
    , single-deriving-parens = convert.ofSingleDerivingParens f.single-deriving-parens
    , sort-constraints = convert.ofSortConstraints f.sort-constraints
    , sort-derived-classes = convert.ofSortDerivedClasses f.sort-derived-classes
    , sort-deriving-clauses = convert.ofSortDerivingClauses f.sort-deriving-clauses
    , trailing-section-operators = convert.ofTrailingSectionOperators f.trailing-section-operators
    , unicode = convert.ofUnicode f.unicode
    , respectful = convert.ofRespectful f.respectful
    , fixities = f.fixities
    , reexports = f.reexports
    , local-modules = f.local-modules
    } 

in
    { ColumnLimit
    , FunctionArrows
    , CommaStyle
    , ImportExportStyle
    , RecordStyle
    , ImportGrouping
    , IndentWheres
    , RecordBraceSpace
    , HaddockStyle
    , HaddockStyleModule
    , HaddockLocationSignature
    , LetStyle
    , InStyle
    , IfStyle
    , SingleConstraintParens
    , SingleDerivingParens
    , SortConstraints
    , SortDerivedClasses
    , SortDerivingClauses
    , TrailingSectionOperators
    , Unicode
    , Respectful
    , Fourmolu
    , render
    }