" Handle Jekyll YAML front matter.
" https://github.com/tpope/vim-markdown/issues/112#issuecomment-612277078
unlet b:current_syntax
syntax include @Yaml syntax/yaml.vim
syntax region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend contains=@Yaml
