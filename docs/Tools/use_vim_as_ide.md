# Use vim as an IDE without plugins

## Environment
### Update Vim
The default version of Vim in `ubuntu 18.04 LTS` is 8.0, and the newest version of Vim is 8.2.
```bash
git clone git@github.com:Vim/Vim.git
cd Vim
make
sudo make install
```

### Config
```bash
bash <(curl -s https://raw.githubusercontent.com/yongcongwang/dotfiles/master/deploy.sh) Vim
```
<!-- more -->

## General Usage
### New To Vim
#### Start Vim
To start Vim, type the command `Vim file.txt` at any command prompt. Because this is a new file, you get a blank window:
```
        +---------------------------------------+
        |#                                      |
        |~                                      |
        |~                                      |
        |~                                      |
        |~                                      |
        |"file.txt" [New file]                  |
        +---------------------------------------+
```
- `#` is the cursor position;
- `~` indicates lines not in the file;
- at the bottom of Vim is a message line that indicates the file is named file.txt and shows you are creating a new file.

#### Insert Text
The Vim editor is a modal editor, which means that the editor behaves differently depending on which mode you are in.
The two basic modes are:
- Normal mode, the characters you type are treated as commands;
- Insert mode, the characters you type are treated as text.

To get in insert mode you should type `i`(for Insert), and to get in normal mode you should type `<ESC>`.

#### Moving Around
In `Normal`mode, to move the cursor, press the `h, j, k, l` keys as indicated.
```
             ^
             k              Hint:  The h key is at the left and moves left.
       < h       l >               The l key is at the right and moves right.
             j                     The j key looks like a down arrow.
             v
```

#### Delete Charactors
In `Normal` mode, you can delete characters with following commands:
- `x`: delete a character. Move the cursor over a character and type `x` to delete it. (This is a throwback to the old days of the typewriter, when you deleted things by typing xxxx over them.)
- `dd`: delete a line.
- `J`: delete a line break.

#### Undo And Redo
If you delete too much, you can type `u` to undo the last edit.
And if you **undo** too much, you can press `CTRL-r` to **redo** them.

#### Other Editing Commands
- `a`: since `i` **inserts** a character before the cursor, you can use `a` to **append** a character after the cursor.
- `o`: creates a new and empty line below the cursor and puts Vim in `Insert` mode.
- `O`: creates a new and empty line above the cursor and puts Vim in `Insert` mode.
- `[cnt]-command`: you can add a number `cnt` before command to repeat the command `cnt` times. For example, you want to move up 9 lines, you can either type `kkkkkkkkk` or you can type `9k`.

#### Getting Out
After modifying the file, you can use:
- `:w`: to **write** the file;
- `:q`: to **quite** the Vim;
- `:wq`: to **write** the file and then **quit**  the Vim;
- `:q!`: to ignore the changes and **force** **quit** Vim.

#### Find Help
Everything you always wanted to know can be found in the Vim help files. To get help on **something**, use the command:
- `:help {something}`

### Move Faster

#### Charactor Based Movement
One of the most useful movement commands is the single-character search command `fx`(Find x) which search forward in the line for the character `x`. 
For example, you are at the beginning of the following line. Suppose you want to go to the h of human, just execute the command `fh` and the cursor will be positioned over the h:
```
        To err is human.  To really foul up you need a computer. 
        ---------->--------------->
            fh           fy
```
And you can specify a count:
```
        To err is human.  To really foul up you need a computer. 
                  --------------------->
                           3fl
```
Other similar commands:
- `F`, to find backward:


```
        To err is human.  To really foul up you need a computer. 
                  <---------------------
                            Fh
```
- `t` and `T`, works like the `f`, but it stops one character before the searched character:


```
        To err is human.  To really foul up you need a computer. 
                   <------------  ------------->
                        Th              tn
```

#### Word Based Movement
You can also move the cursor based on words:
- `w`, to move forward a **word**;
```
        This is a line with example text 
          --->-->->----------------->
           w  w  w    3w
```
- `b`, to move **backward** a word;
```
        This is a line with example text 
        <----<--<-<---------<---
           b   b b    2b      b
```
- `e`, to the **end** of a word;
- `ge`, to the end of a previous word.
```
        This is a line with example text 
           <-   <--- ----->   ---->
           ge    ge     e       e
```

#### Line Based Movement
- `0`, to move to the start of a line;
- `^`, to move to the first character of the line;
- `$`, to move to the end of the line;
- `gg`, to move to the first line of the file;
- `G`, to move to the last line of the file;
- `:[num]`, to move to [num] line.

#### Parenthesis Based Movement
When writing a program you often use pairs like `()`, `[]` and `{}`, you can use `%` to jump between them.
If the cursor is on a `(` it will movet to the matching `)`. If it's on a `)` it will move to the matching `(`.
```
                            %
                         <----->
                if (a == (b * c) / d) 
                   <---------------->
                            %
```

#### Scrolling Around
- `CTRL-U`, to scroll **up** half a screen of text;
- `CTRL-D`, to scroll **down** half a screen of text;
- `CTRL-F`, to scroll **forward** a screen of text;
- `CTRL-B`, to scroll **backward** a screen of text;
- `zz`, to move the cursor line to the center of the screen.

```
                                       +----------------+
                                       | some text      |
                                       | some text      |
                                       | some text      |
        +---------------+              | some text      |
        | some text     |  CTRL-U  --> |                |
        |               |              | 123456         |
        | 123456        |              +----------------+
        | 7890          |
        |               |              +----------------+
        | example       |  CTRL-D -->  | 7890           |
        +---------------+              |                |
                                       | example        |
                                       | example        |
                                       | example        |
                                       | example        |
                                       +----------------+


        +------------------+             +------------------+
        | earlier text     |             | earlier text     |
        | earlier text     |             | earlier text     |
        | earlier text     |             | earlier text     |
        | earlier text     |   zz  -->   | line with cursor |
        | earlier text     |             | later text       |
        | earlier text     |             | later text       |
        | line with cursor |             | later text       |
        +------------------+             +------------------+                                       
```

#### Search
- `/{string}`, to search forward `string` in the whole file;
- `*`, pressing `*` at the word you want to search works just like `/{string}`;
- `?{string}`, to search word `string` in the whole file;
- `#`, pressing `#` at the word you want to search works just like `/{string}`;

Once you searched something, you can use `n` to jump to **next** item, and `N` to jump to previous item.

#### Marks
Vim enables you to place your own marks in the text:
- `mx`, to mark a the place under the cursor as `x`, x can be `a to z`;
- ``x`, to go to the marked place;
- `marks`, to place all the marks you can go to.

### Change Smarter
#### Operators With Range
You can use the pattern `[operator][count][range]` to change more characters. For example, `d4w` means `[delete][4][word]`:
```
        To err is human. To really foul up you need a computer. 
                         ------------------>
                                 d4w

        To err is human. you need a computer.
```
And similar usages are:
- `d2e`, means delete 2 words' end;

```
        To err is human. you need a computer. 
                        -------->
                           d2e

        To err is human. a computer.
```

- `d$`, means delete to the end of the line;

```
        To err is human. a computer. 
                       ------------>
                            d$

        To err is human 

```

#### Change Text
Another operator is `c`, change. It acts just like the `d` operator, but it leaves you in `Insert` mode:
- `cw`, changes a word;

```
        To err is human 
           ------->
             c2wbe<Esc>

        To be human
```
- `cc`, changes a line and leaves you in `Insert` mode;


The `r` is not an operator, it waits for you to type a character, and will replace the character under the cursor with it.
```
        there is somerhing grong here 
        rT           rt    rw

        There is something wrong here
```
For commands, you can use a count befor them:
```
        There is something wrong here 
                           5rx

        There is something xxxxx here
```

#### Repeating A Command
The `.` may be the most simple yet powerful commands in Vim. It repeats the last change. For instance, suppose you are editing an HTML file and want to delete all the `()` :
```
                              To "generate" a table of <B>contents 
       auto test = temp.function1(val1).function2(val2, val3).function3(val4);
        f(   find first (     --->
        df)  delete to )         ----->
        f(   find next (              ----------->
        .    repeat df)                          ----------->
        f(   find next (                                    ----------->
        .    repeat df)                                                ----->
```

#### Visual Mode

`Visual` mode is a flexible and esay way to select a piece of text for an operator. It is the only way to select a block of text.

##### Select Characters
To delete simple items the operator-range works quite well. But often it's not so easy to decide which command will move over the text you want to change. Then you can use press `v` to enter the `Visual` mode.
You move the cursor over the text you want to work on. While you do this, the text is highlighted. Finally, you type the operator command.
```
                This is an examination sample of visual mode 
                               ---------->
                                 velllld

                This is an example of visual mode
```

##### Select Lines
If you want to work on whole lines, use `V` to start `Visual` mode.
```
                          +------------------------+
                          | text more text         |
                       >> | more text more text    | |
        selected lines >> | text text text         | | Vjj
                       >> | text more              | V
                          | more text more         |
                          +------------------------+
```

##### Select Blocks
If you want to work on a rectangular block of characters, use `CTRL-v` to start `Visual` mode. This will be really useful when you comment several code lines.

##### Go To Other Side
If you have selected some text in `Visual` mode, and discover that you need to change other end of seleqction, use `o` to go to **other** side.

##### Copy And Paste
Yanking is a Vim name for copying, and you can use the operator `yw` to copy a word, a count is possible as usual.
```
        let sqr = LongVariable * 
                 -------------->
                       y2w

        let sqr = LongVariable * 
                               p

        let sqr = LongVariable * LongVariable
```
The `yy` command yanks a whole line, just like `dd` deletes a whole line.
And stil, you can first use visual mode to select some characters and then yank them.

##### Other Useful Commands
- `~`: Change case of the character under the cursor;
- `u`(visual mode): Make selected characters lower case;
- `U`(visual mode): Make selected characters upper case;
- `I`: Start `Insert` mode after moving the cursor to the first no-blank in the line;
- `A`: Start `Insert` mode after moving the cursor to the end of the line;
- `di(` or `di)`: Delete all characters between `()`;
- `di[` or `di]`: Delete all characters between `[]`;
- `di{` or `di}`: Delete all characters between `{}`;
- `da(` or `da)`: Delete all characters between `()` and `()`;
- `da[` or `da]`: Delete all characters between `[]` and `[]`;
- `da{` or `da}`: Delete all characters between `{}` and `{}`;

#### Record
You can record your multiple operators to a register `{0-9a-zA-Z}`.
1. `q{0-9a-zA-Z}` to start recording operators and commands to register `{0-9a-zA-Z}a;` 
2. `q` to stop recording;
3. `@{0-9a-zA-Z}` to replay the operators and commands saved in register `{0-9a-zA-Z}`.
4. `@@` to repeat previous record.

#### Replace
Use the pattern `:[range]s/origin_str/replace_str/[flag]` to replace `origin_str` with `replace_str` in `[range]`.
For example, you can use `:%s/one/two/g` to replace all `one` in the file with `two`.
The `[range]` can be:
- `%`, means in all lines;
- `1, 15`, means in `1-15` lines;
- `., +5`, means from `current` line to `current + 5` line;
- `5, $`, means from line `5` to the end of file.

And the `[flag]` can be:
- ` `(empty), means only replacing once;
- `g`, means replacing all;
- `c`, means you need to comfirm each replacement;
- `gc`, means replacing and you need to comfirm each replacement.

## Advanced Features
### Edit Multiple Files
No matter how many files you have, you can edit them without leaving Vim.

#### Edit Another File
So far you had to start Vim for every file you wanted to edit. To edit another file, use `:edit path/to/foo.txt` to open the file `foo.txt`.

#### Jump Between Files
After editing another file, the file you edited just now is not closed. Instead, it's stored in a `buff`, you can use:
- `:buffers` or `:ls` to show all the buffers;
- `:bnext` to jump to next buff;
- `:bprevious` to jump to previous buff;
- `:blast` to jump to the last buff;
- `:bfirst` to jump to the first buff;
- `:buff[num]` to jump to buff [num];

#### Rename
After modifying the file, if you need to save the file under a new name, 
```
:saveas newname.txt
```
will resave current file.
When you want to change the name of the file you are editing, but don't want to resave the file, you can use 
```
:file newname.txt
```
to rename current file.

### Split Windows
Display two different files above files above each other, or view two locations in the file at the same time. See the difference between two files by putting them side by side. All this is possible with split windows.

#### Split Window On One File
The easiest way to open a new window is to use the command 
```
:split
```
This command splits the screen into two windows and leaves the cursor in the top one:
```
        +----------------------------------+
        |/* file one.c */                  |
        |~                                 |
        |~                                 |
        one.c=============================
        |/* file one.c */                  |
        |~                                 |
        one.c=============================
        |                                  |
        +----------------------------------+
```

You can use the command
```
:close
```
to close a window.
If you split multiple windows, you can use `:only` to close all other windows.

#### Split Window On Different Files
You can use the command
```
:split two.c
```
to open a second window and start editing the given file.
```
        +----------------------------------+
        |/* file two.c */                  |
        |~                                 |
        |~                                 |
        two.c=============================
        |/* file one.c */                  |
        |~                                 |
        one.c=============================
        |                                  |
        +----------------------------------+
```

You can use 
```
:vsplit two.c
```
or 
```
:vertical split
```
to split the window vertically.

#### Move Between Windows
- `CTRL-w h` to move to the window on the left;
- `CTRL-w l` to move to the window on the right;
- `CTRL-w j` to move to the window below;
- `CTRL-w k` to move to the window above;
- `CTRL-w t` to move to the **top** window;
- `CTRL-w b` to move to the **bottom** window;

#### Resize Window
- `CTRL-w =` to make all windows equally high and wide;
- `CTRL-w [num]+` to increase the window's height [num] lines;
- `CTRL-w [num]-` to decrease the window's height [num] lines;
- `CTRL-w [num]<` to decrease the window's width [num] lines;
- `CTRL-w [num]>` to increase the window's width [num] lines;

#### Moving Window
Now you have split a few windows, but they may be in the wrong place. Then you need a command to move the window somewhere else.
- `CTRL-w K` to move window to the top;
- `CTRL-w J` to move window to the bottom;
- `CTRL-w H` to move window to the far left;
- `CTRL-w L` to move window to the far right;

#### Tab Pages
You will have noticed that windows never overlap. That means you quickly run out of screen space. The solution for this is called `Tab pages`.
Assume you are editing `thisfile`, to create a new tab page use the command:
```
:tabedit thatfile
```
This will edit the file "thatfile" in a new tab.
```
        +----------------------------------+
        | thisfile | /thatfile/ __________X|    (thatfile is bold)
        |/* thatfile */                    |
        |that                              |
        |that                              |
        |~                                 |
        |~                                 |
        |~                                 |
        |                                  |
        +----------------------------------+
```
Other commands:
- `:tabclose` to close a tab page;
- `:tabonly` to close all other tab pages;
- `gt` to jump to next tab;
- `gT` to jump to previous tab;
- `[num]gt` to jump to [num]th tab.

### Fold
Structured text can be separated in sections. Folding allows you to display a section as one line, providing an overview.
```
        +------------------------+
        | line 1                 |
        | line 2                 |
        | line 3                 |
        |_______________________ |
        \                        \
         \________________________\
         / folded lines           /
        /________________________/
        | line 12                |
        | line 13                |
        | line 14                |
        +------------------------+
```
The advantage of folding is that you can get a better overview of the structure of text, by folding lines of a section and replacing it with a line that indicates that there is a section.

Try:
- `zc` to **close** a fold;
- `zo` to **open** a fold;
- `zr` to **release** a fold and its sub-fold;
- `zm` to **make** a fold and its sub-fold;
- `zR` to release all folds and sub-folds;
- `zm` to make all folds and sub-folds;

### Code Complete
Vim can auto complete words according to text.
- `CTRL-n` to complete anything;
- `CTRL-x CTRL-n` to complete in this file;
- `CTRL-x CTRL-f` to complete filenames;
- `CTRL-x CTRL-]` to complete in tags;
- Once the matching items appear, you can use `CTRL-n` to jump to next one and `CTRL-p` to previous one.

### Tag Jump
This feature is based on the software `ctags` and makes you jump to the defination of the function.
```
sudo apt install exuberant-ctags
```

You can use `ctags -R .` to generate tags of a repo.

Try:
- `CTRL-]` to jump to tag under the cursor;
- `CTRL-o` or `CTRL-t` to jump back;
- `:ts` to show all matching items.

### Communicate With Terminal
#### Execute Bash Commands
You can excute a bash command with the pattern `:! [command]`:
- `:! bash build.sh` to build the project;
- `:! git status` to check the file change.

#### Builtin Commands
Some builtin commands are available and useful.

##### grep
`:grep [pattern] -r .` will grep all `pattern` lines and put them in `quickfix` window.
You can use
- `:cw` to open `quickfix` window;
- `:cn` to jump to next matching item;
- `:cp` to jump to previous matching item;

##### read
`:read ! [command]` will read the command executing result to cursor position.
Try:
- `:r ! ls` to copy all filenames to current file;
- `:r ! date` to copy date to the file.

#### Jump Between Terminal And Vim
1. Use `:shell` to start a shell; when the shell exits(after `exit` command or `CTRL-d`) you return to Vim.
2. Use `CTRL-z` to suspend current process; after your work, use `fg` to bring it to the foreground.

#### Terminal Mode
The `terminal` feature is supported after `Vim 8.2`. This feature is for running a terminal emulator in a Vim window.
You can use:
- `:terminal` to create a new terminal window;
- `:vertical terminal` to create a new vertical terminal window;
- `CTRL-w h/j/k/l` to jump between terminal windows;
- `CTRL-w H/J/K/L` to move terminal window;
- `CTRL-w N` to back to normal mode;

## Compile(C++)
Generally, if you want to compile a single cpp file, you can use g++. For a large project with lots of source file, you can use the builtin command `make`.

### g++
```
:! g++ % -g -o out
```
- `%` represents for current file, you can replace it with its real name;
- `-g` to generate symbols for `gdb`;
- `-o out` to place output to the file `out`;
- you can add other flags.

### make
The following command runs the program `make`(supplying it with any argument you give) and captures the results:
```
:make {arguments}
```
If errors were generated, they are captured and the editor positions you where the first error occured.

For example, `:make -directory=build` will make the project in the folder `build` and put the warnings and errors to `quickfix` window.
You can use
- `:cw` to open `quickfix` window;
- `:cn` to jump to next error;
- `:cp` to jump to previous error;
- `:cfirst` to jump to the first error;
- `:clast` to jump to the last error;

## Debug
Vim has a useful builtin debugger plugin, `termdebug`, which provides a visual interface for interacting with `gdb`.

### Load The **termdebug** Plugin
After loading source code in current window, you can load the plugin with:
```
:packadd termdebug
:Termdebug
```

This will open two other windows:
- gdb window: A terminal window in which `gdb` is executed.
- program window: A terminal window for the executed program. The output of program will appear here.

```
+------------------------+
|                        |
|       gdb window       |
|                        |
+------------------------+
|                        |
|     program window     |
|                        |
+------------------------+
|                        |
|     current window     |
|                        |
+------------------------+
```

### General Debug(gdb)
Firstly, make sure the program you generated contains symbols. 
If you compile the program with:
- g++, you should add the `-g` option;
- make, you should add the `-ggdb` option.

Then, you can load the program in `gdb` window with the command:
```
file program
```

This works the same as any command a gdb running in a terminal.

Some gdb commands:
- `b`: set a break point;
- `d`: delete a break point;
- `set args`: set running args;
- `show args`: show args;
- `r`: run the program;
- `start`: run the program and stop at the `main` function;
- `c`: continue current process;
- `n`: next step;
- `s`: step in;
- `finish`: stop current program;
- `until`: jump out of current loop;
- `until+linenumber`: run util the `linenumber`;
- `info locals`: show current local variables;
- `p+variable`: print the value of a variable;
- `set var key=value`: set the variable key to a new value;
- `p key=value`: same as `set var key=value`;
- `bt`: show trace of where you are currently, which functions you are in. Prints stack backtrace.
- `CTRL-c`: stop current gdb command;
- `q`: quit gdb.

### Core Dump
A `core dump` is the printing or the copying to a more permanent medium(such as hard disk) the contents of `RAM` at one moment in a time.You can think it as a full length "snapshot" of `RAM`.

If your program got a `core dump` bu no file generated, you should set the `core dump` file size limit:
```
ulimit -c unlimited
```

You can use the command:
```
gdb excutable core
```
to check where the core dump is generated.

Or you can use the command:
```
core-file core
```
in `gdb` window to load the `core dump` file.

### Crash
You can use the command `bt` to **backtrace** the stack status when crash appears in `gdb` window.

### Debug Cyberrt Module
You can use `gdb` to either launch a module or attach to a running module.

#### Use Termdebug To Load Module
In `gdb` window, use
```
file /home/caros/opt/bin/mainboard
```
to load `mainboard`, and use
```
set args -d prediction.dag -p prediction -s CYBER_DEFAULT
```
to set flags, then use
```
run
```
to start the module.

#### Attach To A Running Module
1. Get PID of prediction module:
```
ps aux | grep prediction
```
2. Load `mainboard` symbols:
```
file /home/caros/opt/bin/mainboard
```
3. Attach to prediction process:
```
attach PID
```

## Use Vim Mode In Other apps

### bash
- `set -o vi` will use the `vi` commands;
- `set -o emacs` will use the `emacs` commands.

### Chrome
[Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb)

### Visual Studio Code
[VSCodeVim](https://github.com/VSCodeVim/Vim)

