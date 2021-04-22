# Shortcuts to move faster in terminal

Nowdays we spend a lot of time in bash shell, typing long and complex commands. You can use the arrow keys `up/down/left/right` to move the cursor and select commands, but that's not so efficient.

By default, bash command line uses the shortcuts of `emacs`, so the following commands are mostly from `emacs`, you can also use the shortcuts of `vim` by setting `set -o vi`.

## Move

### Move in Charactor
- `C-b`: Move `back` one charactor(`C` is for `Ctrl`)
- `C-f`: Move `forward` one charactor

### Move in Word
- `A-f`: Move `forward` a word(`A` is for `Alt`)
- `A-b`: Move `backward` a word

### Move in Line
- `C-a`: Move to the `ahead` of the line
- `C-e`: Move to the `end` of the line

## Edit

### Cut in Charactor
- `C-d`: `Delete` current charactor
- `Backspace`: Delete previous charactor
- `C--`: Undo

### Cut in Word
- `A-d`: Cut from cursor to the end of word
- `A-Backspace`: Cut from cursor to the start of word
- `C-w`: Cut from cursor to previous whitespace


### Cut in Line
- `C-k`: Cut(`kill`) from cursor to the end of line
- `C-x-Backspace`: Cut from cursor to the start of line

### Paste
- `C-y`: Paste(`yank`) the last cut text
- `A-y`(after `C-y`): Redo pasting the last cut text

### Transpose
- `C-t`: `Transpose` the charactor under the cursor and the one before it
- `Esc-t`: Transpose the word under the cursor and the one before it

## Search
- `C-p`: Retrieve the `previous` command
- `C-n`: Retrieve the `next` command
- `C-s`: Forward `search`
- `C-r`: `Reverse` search
- `C-g`: Quit the search mode

## Replace(The bang `!` commands)
- `!!`: Excute last command
- `!top`: Excute the most recent command that starts with `top`
- `!$`: Excute the last word of the previous command
- `!*`: Excute the all words of the previous command except the first
- `![pattern]:p`: Display the `!` command result
