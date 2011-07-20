" Vim syntax file

syntax case match

" Error
syntax match grmblError "{"
syntax match grmblError "}"
syntax match grmblError "("
syntax match grmblError ")"
syntax match grmblError ":"
syntax match grmblError ";"

" Objects
syntax match grmblObjectName "\w*" nextgroup=grmblObjectDesc skipwhite skipnl skipempty
syntax region grmblObjectDesc start="{" end="}" transparent contains=grmblInput,grmblOutput,grmblBlock,grmblConnexion

" Inputs
syntax match grmblInput "inputs:.*;" transparent contains=grmblInputsKeyword,grmblInputsList
syntax keyword grmblInputsKeyword inputs contained
syntax region grmblInputsList start=":" end=";" contains=grmblInput contained
syntax match grmblInput "\w*(\w*)" contains=grmblInputName,grmblInputTypeDef contained
syntax match grmblInputName "\w*" nextgroup=grmblInputTypeDef contained skipwhite skipnl skipempty
syntax match grmblInputTypeDef "(\w*)" contains=grmblInputType contained
syntax match grmblInputType "\w*" contained

" Outputs
syntax match grmblOutput "outputs:.*;" transparent contains=grmblOutputsKeyword,grmblOutputsList
syntax keyword grmblOutputsKeyword outputs contained
syntax region grmblOutputsList start=":" end=";" contains=grmblOutput contained
syntax match grmblOutput "\w*(\w*)" contains=grmblOutputName,grmblOutputTypeDef contained
syntax match grmblOutputName "\w*" nextgroup=grmblOutputTypeDef contained skipwhite skipnl skipempty
syntax match grmblOutputTypeDef "(\w*)" contains=grmblOutputType contained
syntax match grmblOutputType "\w*" contained

" Blocks
syntax match grmblBlock "blocks:.*;" transparent contains=grmblBlocksKeyword,grmblBlocksList
syntax keyword grmblBlocksKeyword blocks contained
syntax region grmblBlocksList start=":" end=";" contains=grmblBlock contained
syntax match grmblBlock "\w*(\w*)" contains=grmblBlockName,grmblBlockTypeDef contained
syntax match grmblBlockName "\w*" nextgroup=grmblBlockTypeDef contained skipwhite skipnl skipempty
syntax match grmblBlockTypeDef "(\w*)" contains=grmblBlockType contained
syntax match grmblBlockType "\w*" contained

" Connexions
syntax match grmblConnexion "connexion:.*;" transparent contains=grmblConnexionKeyword,grmblConnexionList
syntax keyword grmblConnexionKeyword connexion contained
syntax region grmblConnexionList start=":" end=";" contains=grmblConnexion,grmblConnexionParent contained
syntax match grmblConnexionParent "\w*" contains=grmblConnexionPort contained
syntax match grmblConnexion "\w*\.\w*" contains=grmblConnexionName,grmblConnexionPortDef contained
syntax match grmblConnexionName "\w*" nextgroup=grmblConnexionPortDef contained
syntax match grmblConnexionPortDef "\.\w*" contains=grmblConnexionPort contained
syntax match grmblConnexionPort "\w*" contained

" Imports
syntax match grmblImport "import:.*from.*;" transparent contains=grmblImportKeyword,grmblImportNames,grmblFromKeyword,grmblImportFile
syntax keyword grmblImportKeyword import contained
syntax match grmblImportNames "\w*" contained
syntax keyword grmblFromKeyword from contained
syntax region grmblImportFile start=+"+ end=+"+ contained

" Comments
syntax match grmblComment "#.*$" contains=grmblTodo
syntax keyword grmblTodo TODO FIXME XXX NOTE contained


highlight link grmblComment Comment

highlight link grmblTodo Todo

highlight link grmblImportKeyword Keyword
highlight link grmblFromKeyword Keyword
highlight link grmblInputsKeyword Keyword
highlight link grmblOutputsKeyword Keyword
highlight link grmblBlocksKeyword Keyword
highlight link grmblConnexionKeyword Keyword

highlight link grmblImportFile String

highlight link grmblImportNames Special
highlight link grmblObjectName Special

highlight link grmblInputName Identifier
highlight link grmblOutputName Identifier
highlight link grmblBlockName Special
highlight link grmblConnexionName Special
highlight link grmblConnexionPort Identifier

highlight link grmblInputType Type
highlight link grmblOutputType Type
highlight link grmblBlockType Type

highlight link grmblError Error
