# How to Do 90% of What Plugins Do with Just Vim

Vim plugins can buy us a lot of functionality, but they also add a lot of burden in the form of dependency complexity. Origin vim has the ability to implement many features that plugins do, for example:

- file jumping(FuzzyFinder, Ctrl+P)
- tag jumping
- auto complete
- file browser
- snippets

## Finding Files

### Vim Settings
```vim
" Search down into subfolders and provide tab-complete
set path+=**

" Display all matching files when tab-complete
set wildmenu
```

### Usage
- If the file is in current path or its subfolder, use `:find file.name` to open it
- You can use `*` to make it fuzzy: `:find file.*`
- If there are more than one matching iterms, they will appear above the command line

## Tag Jumping
This feature base on the software `universal-ctags`.

### Settings
```vim
command! MakeTags !ctags -R .
```
You can use `:MakeTags` command in vim to generate ctags, or run the following command manually:
```
ctags -R .
```

### Usage
- Use `C-]` to jump to tag under cursor
- Use `g-C-]` to show ambiguous tags
- Use `C-t` or `C-o` to jump back

## Auto Complete

### Settings
None

### Usage
- Use `C-x-C-n` to complete in this file
- Use `C-x-C-f` to complete filenames
- Use `C-x-C-]` to complete in tags
- Use `C-n` to complete anything specified by the `complete` option
- Once the matching iterms appear, you can use `C-n` to jump to next one and `C-p` to previous

## File Browser
### Settings
```vim
let g:netrw_banner=0 " disable banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open split to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_winsize=25 " 25% of current window
let g:netrw_list_hide=netrw_gitignore#Hide() " ignore files in gitignore
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+' " hide some folder
```
### Usage
- Use `:Ve` or `:edit` to open a file brower from current window
- Use `<CR>` to open in right window
- Use `v` to vsplit
- Use `t` to open in a new tab

## Snippets
### Settings
```vim
" Read an empty HTML template and move cursor to tile
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a
```

### Usage
- In normal mode, type `,html` to insert a html template and jump to special position
