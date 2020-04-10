"#¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤¤º°`°º¤ø,¸¸,ø¤º°`°º¤ø
"
"     Name: $HOME/.vimrc
"  Summary: Platform-independent, overly ambitious, Vim config file
"                                                                         
"           The mechanic that would perfect his work must first sharpen
"           his tools -- Confucius
"
"  Created: Wed 06-Jun-1998 (Bob Heckel)
" Modified: Sun 23-Feb-2020 (Bob Heckel)
"
"#¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤¤º°`°º¤ø,¸¸,ø¤º°`°º¤ø

"   Settings 	{{{1
"    Who set it last e.g.:  :verbose se shiftwidth?
"    Ordered by ':option option-window' convention
"--------------------------------------------------------------------------
"                                1 initialization {{{2
" C:\Users\boheck\vim\vim81\gvim.exe -c "set noswapfile" -u c:\cygwin64\home\boheck\dotfiles\_vimrc

" Unleash the beast VIVIVI:
set nocompatible

" Show '$' on C and s actions, i.e. emulate vi:
set cpoptions=s$

" DEBUG toggle:
"""scriptnames
"""echo 'reach'
" Watch initialization, etc.  Or use $ vim -V
"""set verbose=1
" Watch changes to text happen slowly (default is 0)
"""set writedelay=5

if has ('win32unix')
  let g:netrw_cygwin=1  " scp to be provided by Cygwin
  let g:netrw_browsex_viewer='cygstart'
endif
" Tree view
let g:netrw_liststyle= 3
" Refresh dir listings only if dir not seen before
let g:netrw_fastbrowse=2
" <CR> opens in new tab
let g:netrw_browse_split=3
" Ignore case
let g:netrw_sort_options="i"
let g:netrw_timefmt='%d-%b-%y %H:%M:%S'
"""let g:netrw_list_cmd = '\ls -l'
"""let g:netrw_list_cmd = '/cygdrive/c/windows/System32/WindowsPowerShell/v1.0/powershell -Command dir'

let THISBOX = hostname()
let WORKBOXARRAY = [ 'L-ANA-BHEC', 'TWAVWS-05-BHEC' ]

" Setup tempspace that vim and gVim can share, make sure both Linux & Windows hostnames are added to WORKBOXARRAY
if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
  if has('gui') && has('win32')
    " Windows gVim
    " let VTMP = 't:/Personnel/bob/tmp'
    let VTMP = ''
    let VTMPU = 'u:/temp'
  elseif has('win32unix')
    " Cygwin terminal
    " let VTMP = '/cygdrive/t/Personnel/bob/tmp'
    let VTMP = ''
    let VTMPU = '/cygdrive/u/temp'
  else
    " Linux terminal
    " let VTMP = '~/bob/tmp'
    let VTMP = ''
    let VTMPU = '~/tmp'
  endif
else
  if has('gui') && has('win32')
    " Windows gVim
    let VTMP = 'c:/temp'
  elseif has('win32unix')
    " Cygwin terminal
    let VTMP = '/cygdrive/c/temp'
  else
    " Linux terminal
    let VTMP = '~/tmp'
  endif
endif

" Fix leftward movement problem on z/OS:
if has('ebcdic')
  set t_le=
endif

" Make sure this comes before the syntax area of this file:
set t_Co=256
"""set t_ut=
" set background=dark

" Force vim to clear itself when exiting:
"""set t_ti=7[r[?47h
"""set t_te=[?47l8
" Improve cursor in insert mode for mintty:
if has('win32unix')
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
endif

" $ mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"""execute pathogen#infect()
" cd ~/.vim/bundle && git clone git://github.com/tpope/vim-commentary.git

"                                2 moving around, searching and pattern {{{2
" H, M, L, gg, etc commands move cursor to first blank in line.
set startofline

" Search pwd and subdirs when using gf, :find, etc.
"""set path=.,**/*
if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
  set path=/sasdata/Macros,**
else
  set path=**
endif

set wrapscan

set incsearch

set magic

" Override noignorecase with /\c... but smartcase should be smart enough to
" not require that.
set ignorecase 

" Sadly can't use smartcase because using [I while sitting on an upper or mixed
" case word - we will not find all matches.  Use /\Cfoo for now.
set nosmartcase


"                                3 tags {{{2


"                                4 displaying text {{{2

set nowrap

set lazyredraw

set nolinebreak

set showbreak=^

set sidescroll=5

" Minimal number of screen lines to keep above top and below bottom the cursor
set scrolloff=3

set scrollopt=hor,ver

if version > 702
  set relativenumber
  " :se rnu gutter at 7pt font should rarely go > 100
  set numberwidth=3
endif

" :se guifont=* to open OS-specific menu
if has("gui_running")
  " Gvim window coordinates dimensions height/width. Overriden later depending on file type.
  winpos 295 295
  set columns=100
  " Most of the time we're just doing fast edits so make it small
  set lines=30

  if has("gui_gtk3")
    set guifont=Cousine\ 9
  elseif has("x11")
    " set guifont=*-Consolas-medium-r-normal-*-*-180-*-*-m-*-*
    set guifont=Consolas\ 8
  elseif has("gui_win32")
    set guifont=Consolas:h8
  endif
endif

if has('gui')
  set guioptions+=a
  set guioptions+=b
  set guioptions+=r
  set guioptions-=T
  set guioptions-=m
endif

" Use  :set guifont=*  to browse
"""if matchstr(HOMEBOXARRAY, THISBOX) == THISBOX
"""  set guifont=Consolas\ 8
"""elseif has ('win32')
"""  set guifont=Consolas:h8,Andale_Mono:h8,Lucida_Console:h8,Terminal:h8,Courier_new:h8,Courier:h7
"""endif

" For Win32 cmd only.  Unix uses t_ti and t_te.
set restorescreen


"                                5 syntax, highlighting and spelling {{{2

" Adjusted by filetype below:
set hlsearch

"--------------------------------------------------------------------------
"  View current highlighting:  :hi or  :so $VIMRUNTIME/syntax/hitest.vim
"  To test term:  :runtime syntax/colortest.vim
"
" To determine cterm color number:
" for i in {0..255} ; do printf "\x1b[38;5;${i}mcolour${i}\n"; done
" ~/code/misccode/vim_colors.txt
"--------------------------------------------------------------------------
syntax enable

" Avoid reading text presented like it was written on a light bulb.  We're
" relying on .mintty or .Xdefaults so this is only for gvim.
hi Normal guifg=White guibg=Black

hi Comment ctermbg=Black ctermfg=DarkGray guibg=Black guifg=DarkGray

hi Folded ctermfg=DarkGray ctermbg=Black guifg=DarkGray guibg=Black cterm=bold gui=bold

hi Conditional ctermfg=LightGreen guifg=LightGreen

hi DiffAdd ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
hi DiffChange ctermfg=Black ctermbg=Cyan guifg=Black guibg=Yellow
hi DiffDelete ctermbg=DarkGreen guibg=DarkGreen
" hi DiffText ctermfg=Green guifg=Black

hi Directory ctermfg=Magenta guifg=Magenta guibg=Black cterm=bold gui=bold

" Highlight tabs other than at start of line for indenting
"""match ErrorMsg /[^\t]\zs\t\+/
hi ErrorMsg ctermfg=Black ctermbg=124 guifg=Black guibg=Red

hi Function ctermfg=Yellow guifg=LightYellow guibg=Black

hi Identifier ctermfg=LightCyan guifg=LightCyan

" hi IncSearch ctermfg=White ctermbg=LightBlue guifg=White guibg=LightBlue

hi CursorLineNr ctermfg=White ctermbg=DarkGray guifg=White guibg=DarkGray cterm=bold gui=bold

hi MatchParen ctermfg=White ctermbg=Blue guifg=Cyan guibg=Magenta

hi ModeMsg ctermfg=Black ctermbg=Yellow guifg=Black guibg=Yellow
hi MoreMsg ctermfg=Blue ctermbg=Black guifg=Blue

hi Number ctermfg=Magenta guifg=Magenta
" For :se rnu relative number gutter
hi LineNr ctermfg=Black ctermbg=238 guifg=Black guibg=#444444

" Tab completion dropdown
hi Pmenu ctermfg=Black ctermbg=Gray guifg=White guibg=Gray 
hi PmenuSbar ctermfg=Black ctermbg=Gray guifg=White guibg=Black 
hi PmenuSel ctermfg=Blue ctermbg=Yellow guifg=Blue guibg=Yellow 

hi PreProc ctermfg=LightMagenta guifg=LightMagenta guibg=Black

" hls
hi Search ctermfg=Yellow ctermbg=DarkGray guifg=White guibg=DarkGray 

hi SpecialKey ctermfg=Black ctermbg=DarkMagenta guifg=Black guibg=DarkMagenta

hi Statement ctermfg=Yellow guifg=LightYellow guibg=Black

hi String ctermfg=White guifg=White guibg=Black cterm=bold gui=bold

" May be overridden by aucommands.  Mirror any change here to there.
" Alert if we're using older versions of Vim
if version < 600
  hi StatusLine ctermfg=Green ctermbg=White guifg=Green guibg=Blue
  hi StatusLineNC ctermfg=Green ctermbg=Black guifg=Green guibg=Black gui=inverse,bold
else
  " For statusline setting below
  hi User1 ctermfg=red guifg=red cterm=inverse,bold 
  " Active status line
  hi StatusLine ctermfg=23 ctermbg=White guifg=#005f5f guibg=White
  " Inactive status line
  hi StatusLineNC ctermfg=23 ctermbg=Gray guifg=#005f5f guibg=Gray
endif

hi TabLine ctermfg=Gray ctermbg=DarkGray
hi TabLineSel ctermfg=White ctermbg=DarkGray
hi TabLineFill cterm=underline ctermbg=Gray

hi Title ctermfg=White ctermbg=Magenta guifg=White guibg=Purple

hi Todo cterm=undercurl gui=undercurl 

hi Visual ctermfg=Black ctermbg=LightMagenta guifg=Black guibg=LightMagenta

hi WarningMsg ctermfg=Magenta ctermbg=Yellow guifg=Magenta guibg=Yellow

"""hi WhitespaceEOL ctermbg=red guibg=red
"""match WhitespaceEOL /\s\+$/

"""hi ColorizeFirst10 ctermbg=red guibg=red
"""match ColorizeFirst10 /^........../

"TODO why ignored but double quotes 201c & 201d are highlighted w/o this?
" Microsoft fancy single quote apostrophes and dashes of death cause vim 'CONVERSION ERROR' among other trauma
" hi EvilChars ctermfg=White ctermbg=Red
" match EvilChars /\%u2018\|\%u2019\|\%u2013/

hi GitCollision ctermbg=red guibg=yellow
match GitCollision /^\(<\|=\|>\)\{7\}\([^=].\+\)\?$/

"                                6 multiple windows {{{2

" Mandatory for displaying a status line:
set laststatus=2

" Depends on this being set above:
" hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red guifg=red
" ...and $VIMSTATUSL being set in .bashrc 
" E.g. ~/.vimrc [+,VIM,unix,b1] rsh868@ZEBWL12H99999   485/4494L,1C(10%)
" set statusline=%<%f%h\ [%1*%M%*%R%H%Y,%{&ff},b%n]\ %{$VIMSTATUSL}\ %=\ %l/%LL,%cC%V(%P)
set statusline=%<%f%h\ [%1*%M%*%R%H%Y,%{&ff},b%n]\ %{$VIMSTATUSL}\ %=\ %l/%LL,%cC%V(%P)%{AmIPasting()}

" Use <C-W>= to force equal as needed:
set noequalalways

set helpheight=999

" To prevent losing undo on buffer switch (but does create trouble with marks).
" Allows you to switch from an unsaved buffer without saving it first. 
set hidden

" Land in top window split
set nosplitbelow


"                                7 multiple tab pages {{{2


"                                8 terminal {{{2

" <C-r>" pastes while in insert mode:
set esckeys

set title

set titlelen=90


"                                9 using the mouse {{{2

set mousehide
" For spellchecking:
set mousemodel=popup
" 'unnamed' makes it so that you can't cw and then paste from the * register
set clipboard=

"                               10 printing {{{2

" Left margin is too wide by default:
set printoptions=wrap:y,left:5pc


"                               11 messages and info {{{2

set shortmess=xfilmwrItn

" E.g. 111L, 15C in bottom right status bar.  We're controlling the display via
" set statusline instead of set rulerformat.
set ruler

" Shhhhhhhhhhhhhhhhhhhh people are trying to work!
set visualbell

" Number of lines changed:
set report=0

set showcmd

set showmode


"                               12 selecting text {{{2

" Emulate xterm mouse.  Same as :behave xterm
set selectmode=
set keymodel=
set selection=inclusive


"                               13 editing text {{{2

" set dictionary=/usr/share/dict/words

" Toggle to stop undo on massive actions (prevent memory overload)
" set undolevels=-1
set undolevels=5000

" When using C-X + C-P, look in current file and buffers.  See inoremap <TAB>.
set complete=.,w,b

" Add angle brackets to the % bounce functionality
set matchpairs+=<:>

set joinspaces

" Want to avoid 0042 from being detected as octal during a C-A increment
set nrformats-=octal

" Omnicomplete C-X C-O (think Battlestar Galactica)
set omnifunc=syntaxcomplete#Complete

set showmatch

" ~ works like an operator.  E.g. ~fa changes case of all chars to the first
" 'a'.  BUT this screws up normal use so leave it off.
set notildeop


"                               14 tabs and indenting {{{2

set shiftwidth=2

" Tabs expanded to spaces.  Replaces the tabs you create when pressing <tab>
" with spaces (to the count of your tabstop).  Alternatively use :retab to
" replace tabs with spaces.
" Without this, doing an 'o' on an indented line, or a '>>' anywhere, inserts a
" new line that starts with one or more tabs.
set expandtab

" :retab to convert tabs to 2 spaces
set tabstop=2

set cinwords=if,elsif,else,while,do,for,switch,unless,until,when,otherwise,BEGIN,END

set autoindent

" Restore indent after typing hash
"""set nosmartindent
"""set cindent
"""set cinkeys-=0#
"""set indentkeys-=0#

"                               15 folding {{{2

set foldmethod=manual
" Fold on paragraphs
set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
set foldopen-=search


"                               16 diff mode {{{2

" 05-Oct-18 TODO doesn't ignore whitespace
" set diffopt=filler,vertical,iwhite
set diffopt+=iwhite
set diffopt+=filler
if v:version > 801 && has("patch148")
  set diffopt+=algorithm:patience
endif
set diffexpr="--ignore-blank-lines"


"                               17 mapping {{{2

" Mapping delay.  E.g. ,m   Also need to change HelpPager() if change this.
set timeoutlen=333


"                               18 reading and writing files {{{2

" Allow backspacing in insert mode.  Make sure stty is set properly.
set backspace=start,indent

if has('win32')
  set fileformat=dos
  set fileformats=dos,unix
elseif has('win32unix')  " Cygwin, make sure this comes before has('unix')
  set fileformat=dos
  set fileformats=dos,unix
elseif has('unix')
  set fileformat=unix
  set fileformats=unix,dos
endif

" For security reasons, set to 'no'
set nomodeline
set nosourceany

" Just use my ;5 checkpoint map before starting important changes
set nobackup

" Allow gf on %foo to open /sasdata/macros/foo.sas
set suffixesadd=.sas

"                               19 the swap file {{{2

" Avoid placing swapfiles where other users might be confused by them
if has('gui_win32')
  if $HOMEDRIVE == 'C:' && $HOMEPATH == '\Users\boheck'
    set directory=C:\cygwin64\home\boheck\tmp
  endif
else
    set directory=~/tmp/
endif

" Write swap file to disk after 60 inactive seconds
set updatetime=60000


"                               20 command line editing {{{2

" Maximize window for q: history
set cmdwinheight=999

set history=5000

" Want to emulate bash(1) tab completion
set wildmode=list:longest

set wildchar=<Tab>

if exists("&wildignorecase")
  set wildignorecase
endif

set wildmenu

set suffixes=.old,.old2,.OLD,OLD2,.o,.swp,.bak,.bak2,.BAK,.BAK2,~


"                               21 executing external commands {{{2

" We want the Unix version so make sure shell=/bin/sh, :se ep=  to restore indent default (gg=G)
set equalprg=sort

" Default.  K to activate.  See Autocommands for exceptions.
set keywordprg=man

if has('win32')
  " Allow uniq, etc. to run in Windows gvim
  set shell=c:\cygwin64\bin\bash.exe\ -login
  set shellcmdflag=-c
  set shellquote=\"
else
  set shell=bash
endif


"                               22 running make and jumping to errors {{{2

" Quickfix.  :mak[e]  jumps to errors (use :cn :cN to navigate).  See au
" commands for C++ files.  Warning: can't undo after make returns.
"""set makeprg=make
set makeprg=gcc\ -Wall\ %
"""set makeprg=gcc\ -mno-cygwin\ -Wall\ %
"""set makeprg=gcc\ -Wall\ %\ -lmenu\ -lncurses


"                               23 language specific {{{2

" Eliminated default '%' to enable SAS macro gf functionality
set isfname=@,48-57,/,.,-,_,+,,,#,$,~,=

"                               24 multi-byte characters {{{2

set encoding=utf-8
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

"                               25 other {{{2

" Comments default to:  sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set comments=sr:/*,mb:*,el:*/,://,b:#,b:\',b:\"

" For :mksession
set sessionoptions=curdir,folds,slash,unix,winsize,winpos,buffers

" 1000 files of marks.  750 lines of registers.  5000 lines of history (see 'history' above).
" Using the '%' switch is very subtle - if you open vim w/o a filename
" it'll silently put the MRU filelist into the buffer.  So don't use '%'
" because it's confusing as hell with BufExplorer.
" Make sure _viminfo file is ff=unix
set viminfo='1000,\"750,:5000

" For :mkview & :loadview.  Force gvim to Cygwin's default.
set viewdir=~/.vim/view

" Allow e.g. :bro e /todel/testing instead of :bro e \todel\testing
set shellslash


" end Settings


"--------------------------------------------------------------------------
"   Abbreviations 	{{{1
"   Who set it last e.g.:  :verbose ab BoB
" To get a literal (e.g. HtM) type CTRL-V *after* you finish typing the 
" abbreviation.  Do :ab to view your abbreviations.  Or e.g. view all HTML
" ab's with  :iab H  Do :abclear to remove all.
"--------------------------------------------------------------------------

" Personal
iab BoB Bob Heckel
iab RoB Robert S. Heckel Jr.
iab @@ rsh@rshdev.com

" Misc
iab AlP ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab MoN January February March April May June July August September October November December
iab MoO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
iab NuM 1234567890123456789012345678901234567890123456789012345678901234567890
iab RuL ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
iab ShE #!/bin/bash

" Date/Time see man strftime or date --help.  Convention stolen from Sven Guckes:
iab YdC Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)
" iab YdC Created: <C-R>=strftime("%d-%b-%y")<CR> (Bob Heckel)
iab YdM Modified: <C-R>=strftime("%d-%b-%Y")<CR> (Bob Heckel)
" Default.  Overridden later in au commands.
iab YdA  Adapted: <C-R>=strftime("%d-%b-%Y")<CR> (Bob Heckel)
" Short.  ISO-8601 format.  E.g. 2002-07-05
iab YdS <C-R>=strftime("%Y-%m-%d")<CR>
" 30-Jul-19
iab YdG <C-R>=strftime("%d-%b-%y")<CR>

" HTML (also see :TOhtml)
iab HtA <a href="http://example.com">example link</a>
iab HtM <!DOCTYPE html><CR><html><CR>  <head><meta charset="utf-8"><title></title></head><CR><body></body><CR><Left><Left></html>
iab HtT <table><CR>  <tr><td> </td></tr><CR><Left><Left></table>
" Character entities:
"""iab ;< &lt;
"""iab ;> &gt;
"""iab ;' &apos;
"""iab ;" &quot;
"""iab ;& &amp;
"""iab ;_ &nbsp;

" Pali
" A macron
"""iab paliA &#256;
"""" a macron
"""iab palia <Backspace>&#257;
"""" I macron
"""iab paliI <Backspace>&#298;
"""" i macron
"""iab palii <Backspace>&#299;
"""" U macron
"""iab paliU &#362;
"""" u macron
"""iab paliu <Backspace>&#363;
"""" n dot over (n.)
"""iab palino <Backspace>&#7749;
"""" n dot under (still renders as n.)
"""iab palinu <Backspace>&#7751;
"""" n tilde (no '#')
"""iab palit <Backspace>&ntilde;

" Mutt
"""iab MuX X-message-flag: Magic 8Ball says 'Outlook not so good.'  Let me ask about MS Exchange Server...

" Perl
iab PeD require Data::Dumper; print STDERR "DEBUG: ", Data::Dumper::Dumper( %h ),"\n";
" Use PeD for hash dumping, this for everything else on symbol table
iab PeF open F, '>junkdumpmain'; for $s(sort keys %main::) { local *sym=$main::{$s}; print F "\\$$s is $$s\\n" if defined $sym; print F "\\@$s is @$s\\n" if defined @sym;}
iab PeO open my $read, '<', $file or die "Error: $0: $!";<CR><CR>while ( <$read> ){<CR>}<Up>
iab PeR #!/usr/bin/perl<CR><CR>use warnings;<CR>use strict;<CR>use v5.10;<CR>
" iab PeW while ( (my $k, my $v) = each %h ) { print "$k=$v\\n"; }

" SAS
" SAS/(C)onnect
"""iab SaC options ls=max;<CR>%include "&HOME/code/sas/connect_setup.sas";<CR>signon cdcjes2;<CR>%global CHICKENPARM;<CR>%syslput CHICKENPARM=&SYSPARM;<CR>rsubmit;<CR><CR><CR><CR><CR><CR>endrsubmit;<CR>signoff cdcjes2;
" Debug Log inline, best:
iab SaD options ls=max;<Esc>0idata _NULL_; set _LAST_(obs=100 where=(myid in:('foo'))); put '!!!wtf '(_ALL_)(=);run;
" (E)lapsed
iab SaE %let START=%sysfunc(time());<CR>%put !!! (&SYSCC) Elapsed minutes: %sysevalf((%sysfunc(time())-&START)/60);
iab SaL options ls=180 ps=max; libname l '.';
iab SaO filename F 'junk'; data t(rename=(PRODDESC=nm APRCLASS=class)); infile F truncover; input PRODDESC= $100. APRCLASS= $100.; run;
iab SaP <Esc>0ititle "&SYSDSN";proc print data=_LAST_(obs=10) width=minimum heading=H;run;title;
iab SaQ proc sql;<CR>  create table t as<CR>select *<CR>from t a join t2 b on a.foo=b.foo<CR>where<CR>group by<CR>;<CR><Left><Left>quit;<Esc><Up><Up><Up>
iab SaS select ( myvar );<CR><Space><Space>when ( 42 ) delete;<CR><Space><Space>otherwise;<CR><Left><Left>end;

cab Sy0 source $VIMRUNTIME/syntax/nosyntax.vim
cab SyH source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/html.vim
cab SyL source $HOME/code/sas/saslog.vim
cab SyJ source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/javascript.vim
cab SyQ source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/sql.vim 
cab SyS source $VIMRUNTIME/syntax/nosyntax.vim \| source $HOME/code/sas/sas.vim
cab SyS source $HOME/code/sas/sas.vim

iab DbO DBMS_OUTPUT.put_line();<Esc><Left>i

" end Abbreviations-


"--------------------------------------------------------------------------
"   Mappings 	{{{1  
"
" Must come after Settings for <> notation
"--------------------------------------------------------------------------

" Toggle search highlighting
nnoremap <Return> :set nohlsearch<Return><Return>
nnoremap <Return><Return> :set hlsearch<Return><Return>

" Assumes stty -ixon in .bashrc
nnoremap <C-S> :w<CR>

" Easily navigate wrapped '^...' long lines with arrow keys
nnoremap <Up> gk
nnoremap <Down> gj

" Quickfix output navigation
" nnoremap <F1> :cnext<CR>
" nnoremap <F2> :cprevious<CR>

if has('gui')
  " Widen gvim to max column width
  nnoremap <F4> :call SetOpt('columns', MaxLineLen(0))<CR>
  nnoremap <F4><F4> :call SetOpt('columns', 80)<CR>
endif

"""nnoremap <F6> :se guifont=Consolas:h5<CR>z.
"""nnoremap <F7> :se guifont=Consolas:h7<CR>z.
"""nnoremap <F8> :se guifont=Consolas:h9<CR>z.
"""nnoremap <F9> :se guifont=Consolas:h12<CR>z.
"""nnoremap <F10> :se guifont=Consolas:h15<CR>z.

if has('win32')
  " Minimize gvim (like alt-spacebar-n) to taskbar
  " nnoremap <F2> :simalt ~n<CR>
  " Maximize gvim
  nnoremap <F11> :simalt ~x<CR>
  " Restore gvim
  nnoremap <F11><F11> :simalt ~r<CR>

  " Avoid mswin.vim forcing Ctrl-v act as paste, etc.
  nnoremap <C-V> <C-Q>
  nnoremap <C-A> <C-A>
endif

nnoremap <F12> :qa<CR>

" Like gv but for paste buffer.  Some day i may actually remember to use this...
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" Highlight last paste - (g)et (p)aste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open a window for the file under cursor - (g)et this file a (w)indow
nnoremap gw <Esc>:split<CR>gf

" Copy visual mode selection to system clipboard. Like gVim's default. See also :set clipboard=
if v:version > 801 || has("patch148")
  if $PATH =~ 'termux'
    vnoremap <silent> yx :'<,'>!termux-clipboard-set<CR>u
  elseif has('unix')
    " Use the normal world's clipboard (for pasting into a VM etc)
    vnoremap <silent> yx  "+y
  else
    vnoremap <silent> yx  "*y
  endif
endif

" Jump to the exact position where you left, not to beginning of line
nnoremap ' `

" Hack to fix the stray pixel problem with monospaced fonts under Cygwin rxvt
" nnoremap <Esc><Esc> <C-L>

" End of word fast append
nnoremap E ea

" Useful for visualize to the very end
nnoremap G G$

" Don't accidentally drop into ex mode
nnoremap Q :q

" Typo laziness
nnoremap :W :w

" Normalize yank until end of line with D and C
nnoremap Y y$

" The command {number}CTRL-G show the current buffer number.  Prevent a loop in
" the mapping by using 'nnoremap'.
nnoremap <C-G> 2<C-G>

" Like Firefox...
nnoremap <C-T> :tabnew<CR>
" ...except
au FileType help,HELP :nnoremap <C-T> <C-T>

noremap <Space> <C-F>

" Speed things up a bit
nnoremap <C-E> 2<C-E>
nnoremap <C-Y> 2<C-Y>

" Use for simple window jumping.  Use C-W for complex jumps.  Normal zz is the
" same as z. so override it here since z. is better.  Also see maps ,b ;b ;h ;j ;k ;ll
nnoremap zz <C-W>w

" Bondage & discipline
" inoremap <Esc> <NOP>
" I'm too lazy to reach <Esc> or deal with CapsLock remapping. The menu
" showing completion candidates will close it with <C-e> instead of exiting
" insert mode with <Esc>
inoremap <expr> jk pumvisible() ? "<C-e>" : "<Esc>"

" Reformat current paragraph to gq while in insert mode (avoid vap etc):
" inoremap <F1> <C-L><ESC>gqap{/<C-L><CR>xi

" Normal action, while in insert mode, CTR-E inserts the character below the
" cursor.  This prevents that and allows the more useful scrolling up/down.
inoremap  
inoremap  

" Required for using C-I to get a tab (when 'tab as word completion' is in effect)
inoremap <C-I> <C-X><C-I>

" Line completion.  Hides <C-L> so to clear the screen use my <Esc><Esc> mapping
inoremap <C-L> <C-X><C-L>

" Filesystem completion.  Hides an unused <C-F>.
inoremap <C-F> <C-X><C-F>

" Dictionary completion
inoremap <C-K> <C-X><C-K>

" Remap <TAB> for smart completion on various characters
"""inoremap <silent> <TAB> <C-R>=SmartComplete()<CR>

" Tab completion.  Find (p)revious completions.  See set complete.
inoremap <silent> <TAB> <C-P>

" TODO interferes with copy/paste inserts
" inoremap ( ()<Esc>i

" Add case-insensitivity
set grepprg=grep\ -ni\ $*\ /dev/null
" Search all open buffers
cmap bbb call setqflist([]) \| silent bufdo grepadd!  %<C-F>$hha

" Search all files recursively in pwd
cmap vvv vimgrep // **/*.*<C-F>$Bhhi
" Search all SAS files recursively in pwd
cmap vvs vimgrep //g **/*.sas<C-F>$Bhhhi

" Increment / sequence / (a)dd a visualized column.  Cursor on number to 
" start from.  C-V C-A.  To do more complicated things like increase by 100 use
" :'<,'>Inc(100)
vnoremap <C-A> :Inc<CR>

" Sum a column of digits.  Think (p)lus.  Assumes bc(1) exists.
vnoremap <C-P> "ey:call CalcBC()<CR>

" Uppercase current word on the fly
inoremap <C-U> <Esc>viwUea

" gvim - do not use, we need right click for Paste on Linux (where there are multiple clipboards)
"""nnoremap <RightMouse> <Insert>
"""inoremap <RightMouse> <ESC>

""""""""""""""""""""""""""""""
" Begin ',' comma map leader 
""""""""""""""""""""""""""""""
" Greenbar highlight every other line.  Also see HighlightCurrentLine()
nnoremap ,<Tab> :set hls<CR>/\\n.*\\n/<CR>

" Single quote a word
nnoremap ,, :let @z=substitute(expand("<cword>"),".*","'&'","g")<CR>ciw<C-R>z<ESC>

" Double quote a word
nnoremap ,. :let @z=substitute(expand('<cword>'),'.*','\"&\"','g')<CR>ciw<C-R>z<ESC>

" Pad current line's parameters with spaces e.g if(foo) { ...   to  if ( foo ) { ...      
nnoremap ,0 :s# \*(\\([^ ].*[^ ]\\))# ( \\1 )#<CR>

" Mnemonic remove '3 stars':
" nnoremap ,3 :s:\\/\\*\\*\\*\\\|\\*\\*\\*\\/::g<CR>:se nohls<CR>

" Insert (a) space
nnoremap ,a a <ESC>

" Use for simple window jumping & maximizing (think [b]ig [b]uffer and my ;b
" z66-like map).  Works to cycle through horizontal AND vertical split
" windows.  Also see nnoremap zz to cycle windows without maximizing.
nnoremap ,b <C-W>w<C-W>_

" Edit another file in the same directory as the current file that you navigated to (without having to change pwd via cd %:h):
if has('unix')
  nnoremap ,d :e <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap ,d :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Toggle between two buffers (e fails if 2+ files are opened together and have never used :n)
nnoremap ,e :e#<CR>

" Auto reflow text:
nnoremap ,f :set formatoptions=aw2tq<CR>
  
" Split window and open file under cursor.  Usually used to view query results
" within my b(g)rep (which is why it also jumps to the last search register '/' as
" defined by bgrep)
nnoremap ,g <C-W>f :set winheight=9999<CR>/<C-R>/<CR>

" Copy w(h)ole buffer to Clipboard:
if has('win32unix')
  " nnoremap ,h :%!putclip<CR><Esc>u
  nnoremap ,h :1,$ y *<CR>
elseif has('unix')
  nnoremap ,h :%!xclip<CR>
elseif has('gui_running')
  nnoremap ,h mz<ESC>ggvG"*Y`z
endif

" (L)owercase a word and stay on the same character
nnoremap ,l mzviwu\|:echon '.vimrc: word lowercased'<CR>`z

" Comment out and yank/paste current line.  Default (may be overridden below, see au commands).  TODO use FileType instead of *.foo in au commands below
" nnoremap ,m yy0I***<ESC>p

nnoremap ,n :bnext<CR>

" ,p is an autocmd

nnoremap ,qq :q!<CR>

" Quick search template:
nnoremap ,s :%s::g<Left><Left>

" (T)oggle this prior to pasting
nnoremap ,t :set invpaste<CR>\|:set paste?<CR>

" Uppercase a word and stay on the same character
nnoremap ,u mzviwU \| :echon '.vimrc: word uppercased'<CR>`z

nnoremap ,w :call WrapToggle()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin ';' semicolon map leader
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment out (using the most common comment style '###' for suffix-less files).
" This default may be overridden by au commands below.
"""nnoremap ;; :call setline('.', Commentout(getline('.'), 'default'))<CR>
" If filetype isn't set for /* this style */
"""nnoremap ;;; :silent s:^:/\*\*\*:g \| :s:$:\*\*\*/:g<CR>
"""nnoremap ;;;; :silent s:^/\\*\\*\\*::g \| :s:\\*\\*\\*/$::g<CR>
" 07-Mar-17 just use Commentary
noremap ;; :Commentary<CR>

if has('unix')
"""  nnoremap ;0 <ESC>:!/usr/bin/google-chrome 'https://google.com/search?q=<C-R>=Websearch()<CR>'<CR><CR>
  nnoremap ;0 <ESC>:!/usr/bin/firefox 'https://google.com/search?q=<C-R>=Websearch()<CR>'<CR><CR>
endif

" Quick save as (usually) to ~/tmp/1 for diffs or my d12 functions
nnoremap ;1 mx \| :%call WriteToFile(VTMP, 1, 0)<CR> \| 'x
nnoremap ;2 mx \| :%call WriteToFile(VTMP, 2, 0)<CR> \| 'x
nnoremap ;3 mx \| :%call WriteToFile(VTMP, 3, 0)<CR> \| 'x
nnoremap ;4 mx \| :%call WriteToFile(VTMP, 4, 0)<CR> \| 'x

" Checkpoint backup current file:
" map ;5 :silent write! /c/temp/%:t<CR>
nnoremap ;5 :call BkupFile(VTMP)<CR>

" Maximize window without RSI.  Alternative to z99.  Same as map ,b without
" the jumping.  (B)ig buffer.  Also see nnoremap zz for cycling windows.
nnoremap ;b <C-W>_

" Same as  'ab YdC' but replaces existing Created line first:
" nnoremap ;c 0Di#  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>
nnoremap ;c 0Di#  Created: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>

" Change (d)irectory to where the open file resides:
nnoremap ;d :call CDtoThisFilesLoc()<CR>

nnoremap ;e :split $MYVIMRC<CR>

" (F)latten paragraph to single line - prepare text for paste into an input box, etc.
nnoremap ;f vipgq
" Unflatten toggle, reflow to current tw:
nnoremap ;ff mfvipJ`f

" Jump to leftside window without chording
nnoremap ;h <C-W>h

" Jump to lower window without chording
nnoremap ;j <C-W>j

" Jump to upper window without chording
nnoremap ;k <C-W>k

" Buffer navigation
nnoremap ;l :ls<CR>:e#

" Jump to rightside window without chording.  Non-intutitive but ';l' is already taken.
nnoremap ;ll <C-W>l

" Same as  'ab YdM' but replaces existing Modified line first.
" nnoremap ;m 0Di# Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
nnoremap ;m 0Di# Modified: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0

" Simplify navigating the output of :makeprg (use :cN to reverse) when using Vim as an IDE.
" nnoremap ;n :cn<CR>
nnoremap ;n :set norelativenumber<CR>
nnoremap ;nn :set relativenumber<CR>

if has('win32')
  nnoremap ;o :silent !explorer /e, . <CR>
elseif has('win32unix')
  nnoremap ;o :silent !cygstart %:p:h <CR>
endif

" Swap exchange flip two parameters (foo, bar) TODO function to handle all cases
nnoremap ;q viw"zxllciwhhpll"zp

" Pt. 1 Transfer/read and write one block of text between vim sessions/terminals:
"""if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
"""  nmap ;r :call ReadFromFile(VTMP, '.vimxfer')<CR>
"""  echon VTMP 'x' THISBOX
  " Temporary ugly hack for XP vs. Win7 Cygwin permission battle
"""  nmap ;rx :!chmod 755 $u/temp/.vimxfer
"""else
  " nmap ;r :call ReadFromFile(VTMP, '.vimxfer')<CR>
  nmap ;r :call ReadFromFile(VTMP, '.vimxfer')<CR>
"""  echon VTMP 'x' THISBOX
"""endif

" Pt. 2 Transfer/read and write one block of text between vim sessions:
noremap ;a :call WriteToFile(VTMP, '.vimxfer', 1)<CR>
vnoremap ;a :call WriteToFile(VTMP, '.vimxfer', 1)<CR>
noremap ;w :call WriteToFile(VTMP, '.vimxfer', 0)<CR>
vnoremap ;w :call WriteToFile(VTMP, '.vimxfer', 0)<CR>
" The non-pathologically-overengineered version:
" map ;w :. write! /c/temp/.vimxfer<CR>
" vmap ;w :'<,'>write! /c/temp/.vimxfer<CR>

" nnoremap ;sv :source $MYVIMRC<CR>

"""nnoremap ;t mz<Esc>:se tw=99999<CR>\|:echon '.vimrc: tw set to 99999'<CR>'z
"""nnoremap ;tt mz<Esc>:se tw=78<CR>\|:echon '.vimrc: tw set to 78'<CR>'z
if version > 800
  nnoremap ;t :term bash<CR>
" Hijack the muscle memory of tmux when we're in a terminal
  tnoremap <C-A> <C-W>w
endif

" Upload file to mainframe (basename without extension)
"""nnoremap ;u :!bfp % 'bqh0.pgm.lib(%:t:r)'<CR>

" Display gvim text as if it were presented on a lightbulb
nnoremap ;v :highlight Normal guibg=white guifg=black<CR>

" Toggle ROT13 - scramble entire file against inquiring minds that want to know:
nnoremap ;x mzggVGg?`z

" Default if no execution code aucommand exists
nnoremap ;z :echon ";z 'compile' map not implemented for this filetype"<CR>

"                                Pseudo maps 
" (weaknesses - won't accept <CR>, can be accidentally overwritten):
" Mutt on sdf
" Treo 650 pssh width
"""let @t=':se tw=53'
" For mutt mail editing
"""let @6=':se tw=68'
" Mostly for Mutt after a region has been highlighted.
"""let @p='!par'
" Strip trailing spaces.
"""let @s=":%:s:\\s*$::g|''"

" end Mappings-

"--------------------------------------------------------------------------
"   Commands 	{{{1  
"--------------------------------------------------------------------------

" Render an HTML file
command! Htm :!w3m "%"

" Speed quickfixing.
"""command! W :write|make

" See the difference between the current buffer and the file it was loaded
" from, thus the changes you made.  From vimrc_example.vim.  Use :diffupdate to
" see the diffs made since you ran DiffSwp.
if !exists(":DiffSwp")
  command DiffSwp vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" end Commands-

"--------------------------------------------------------------------------
"   Functions 	{{{1  
"
" Must start with Capital Letter!  Must precede auto commands in this file.
"
" To execute for debugging, use a standalone file then :so % | :call MyFunc()
"
" Run from Vim commandline:  :call Helloworld()
" or shortcut - create an EX command that will call the function.  Then just
" type :Xbit
" command! -nargs=0 Xbit call SetExecutableBit()
"
" Show all  :fun or :com
" View definition  :fun Helloworld
"
" a:foo means foo comes from an function call's parameter (same as a:1 if it's
" the 1st arg)
"
" echon 'debug print'
"--------------------------------------------------------------------------

fu! SASrunSelection()  " {{{2
  '<,'>write! ~/tmp/SASrunSelection.sas | !~/code/sas/sasrun ~/tmp/SASrunSelection.sas
endfu
" :call SASrunSelection() 
" This won't work:
"""command! -nargs=0 Sas call SASrunSelection()  " }}}


fu! CalcBC()   " {{{2
  " Highlight a calculation that has a trailing '=' and this will fill in the
  " answer or echo the result if no '='.  Requires that bc(1) is available.
  " <C-p> to call, think (p)lus
  "
  " E.g. highlight
  " 1+2+3=
  "
  " or
  " 1
  " 2
  " 3
  "
  " NOTE: This fn assumes that buffer 'e' holds the numbers to be summed!! (see <C-b>
  " mapping).
  "
  let has_equal = 0

  " If buffer does not hold plus signs
  if @e =~ "[^+]$"
    " Add implied plus signs so they don't have to be literally in the file.
    " Assumes numbers are in a column.
    let @e = substitute(@e, "\n", "+", "g")
    " Ignore comma separators.
    let @e = substitute(@e, ",", "", "g")
    let @e = substitute(@e, '\s*$', "", "g")
  else
    " Remove newlines and trailing spaces.
    let @e = substitute(@e, "\n", "", "g")
    let @e = substitute(@e, '\s*$', "", "g")
  endif

  " Remove the trailing plus sign we just added.
  if @e =~ "+$"
    let @e = substitute(@e, '+$', "", "")
  endif

  " If we end with an equal, strip, and remember for output.
  if @e =~ "=$"
    let @e = substitute(@e, '=$', "", "")
    let has_equal = 1
  endif

  " Substitute common func names for bc equivalent.
  let @e = substitute(@e, '\csin\s*(', "s (", "")
  let @e = substitute(@e, '\ccos\s*(', "c (", "")
  let @e = substitute(@e, '\catan\s*(', "a (", "")
  let @e = substitute(@e, "\cln\s*(", "l (", "")

  " Escape chars for shell.
  let @e = escape(@e, '*()')

  " Run bc(1), strip newline.
  let answer = substitute(system ("echo " . @e . " \| bc -l"), "\n", "", "")

  " Append answer or echo it.
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echon 'CalcBC(): ' . answer
  endif
endfu   " }}}


fu! CDtoThisFilesLoc()  " {{{2
  " This changes Vim to the pwd (not the OS to the pwd)
  " TODO how to handle spaces in path?
  let _dir = expand("%:p:h")
  exec "cd " . _dir
  unlet _dir
endfu  " }}}


fu! MaxLineLen(printmaxlen)  " {{{2
  " This may be simpler:
  " $ wc -L foo.txt
  " or
  " echo max(map(range(1, line('$')), "virtcol([v:val, '$'])")
  "
  " Determine the longest line of a file
  " E.g. :call MaxLineLen(1) 
  "      :Maxl
  let s:n=a:printmaxlen
  let s:m=0

  " Don't count all lines in case of huge files
  """for s:l in readfile('externalfile.txt', '', 5000)
  for s:l in getline(1, 5000)
    " TODO check if rnu is set, then add 3
    if len(s:l) > s:m
      let s:m = len(s:l)
    endif
  endfor
  if s:n
    echo ".vimrc MaxLineLen: checked up to 1st 5000 lines, max line length is " s:m
    echo s:m
  else
    return s:m
  endif
endfu
command! -nargs=0 Maxl call MaxLineLen(1)  " }}}


function! SetOpt(opt, val)  " {{{2
  " Used to widen gvim to max column width
  let s:opt = a:opt
  let s:val = a:val

  execute("set " . s:opt . "=" . s:val)
endfunction  " }}}


fu! BkupFile(vtpth)  " {{{2
  " Quickly timestamp a backup copy.  Inserts stamp before the rightmost
  " extension.  Usually mapped to ;5
  " TODO elim e.g. x:/ etc if remote file
  " No path and no extension info.  See :h cmdline-special
  let s:head = expand("%:t:r")
  """echo 'head ' . s:head
  let s:tail = expand("%:e")
  """echo 'tail ' . s:tail
  " Make it unique to the second
  let s:stamp = strftime("__%d%b%y_%H.%M.%S__")

  if len(s:tail) > 0
    let s:all = s:head .'.'  . s:stamp . '.' . s:tail
    """echo 'all ' . s:all
  else
    " Suffix-less file
    let s:all = s:head .'.'  . s:stamp 
  endif

  " exec("write! " . a:vtpth . "/" . s:all)
  exec("silent write! " . a:vtpth . "/" . s:all)
endfu  " }}}


fu! Commadelim()   " {{{2
  " Assumes data has one element per row to be single-quoted and terminated with ','
  " for each row.
   
  " Automatically loops lines
  let e = a:lastline
  let l = getline('.')
  let m = substitute(l, "^", "'", "g")
  let curr = line('.')

  "TODO need an isnum fn
  " if l isnum 
		 " echohl WarningMsg | echo l | echohl None
    " let n = substitute(m, "$", ",", "g")

  if curr == e
    " Don't add comma on the last line
    let n = substitute(m, "$", "'", "g")
  else
    let n = substitute(m, "$", "',", "g")
  endif

  call setline('.', n)
endfu
" TODO for now we'll highlight rows to be modified then  :'<,'>call Commadelim()
" command! -nargs=0 Commadelim call Commadelim()
" }}}


fu! HighlightCurrentLine()  " {{{2
  " Also see greenbar mapping
  if ! exists("g:CurrentLineUpdateTime")
    syntax match CurrentLine /.*\%#.*/
    highlight link CurrentLine Visual
    let g:CurrentLineUpdateTime = &updatetime
    set updatetime=50
    augroup CurrentLine
      au!
      au CursorHold * nested syntax clear CurrentLine | syntax match CurrentLine /.*\%#.*/ containedin=ALL
    augroup END
  else
    highlight CurrentLine NONE
    windo syntax clear CurrentLine
    augroup CurrentLine
      au!
    augroup END
    exe 'set updatetime=' . expand(g:CurrentLineUpdateTime)
    unlet g:CurrentLineUpdateTime
  endif
endfu  " }}}


fu! ReadFromFile(vtpth, fnm)  " {{{2
  " Used by mappings that transfer/read/write a block of text between vim sessions/terminals
  let fqfn = a:vtpth . '/' . a:fnm
  " TODO want something like 0read instead of read to insert on current line but that only works for empty files
  " TODO use :silent! somehow
  exec("read " . fqfn)
endfu
" }}}


fu! WriteToFile(vtpth, fnm, append, ...) range  " {{{2
  " Used by transfer/read and write one block of text between vim sessions/terminals maps
  let lfirst = a:firstline
  let llast = a:lastline

  if (a:append == 1)
    " ;a map
    exec(lfirst . ',' . llast . " write! >> " . a:vtpth . '/' . a:fnm)
  else
    " ;w map
    " TODO why does ,silent not work?
    execute(lfirst . ',' . llast . " write! " . a:vtpth . '/' . a:fnm)
  endif

  " Variable args processing for message to be cut 'n' pasted
  let i = 1
  while i <= a:0
    echo a:{i}
    let i = i+1
  endwhile

  " echom a:vtpth . "/" . a.fnm
endfu
" }}}


fu! Commentout(line, lang)  " {{{2
"                                                   ___ not necessarily vim filetype, refers instead to my tags below
" E.g. :call setline('.', Commentout(getline('.'), 'sas') )
  let line = a:line
  let lang = a:lang

  if lang == 'sas'
    echon '.vimrc: sas Commentout'
    let marker1 = '/***'
    let marker2 = '***/'
    if !match(line, '^/')
      echon '.vimrc: remove sas comment'
      let l1 = substitute(line, '^/\*\*\*', '', 'g')
      let l2 = substitute(l1, '\*\*\*/$', '', 'g')
      return l2
    endif
  elseif lang == 'html'
    echon '.vimrc: html Commentout'
    let marker1 = '<!--'
    let marker2 = '-->'
    if !match(line, '^<!--')
      echon '.vimrc: remove html comment'
      let l1 = substitute(line, '^<!--', '', 'g')
      let l2 = substitute(l1, '-->$', '', 'g')
      return l2
    endif
  elseif lang == 'sas2'
    echon '.vimrc: sas2 Commentout'
    let marker1 = '***'
    let marker2 = ''
  elseif lang == 'cpp'
    echon '.vimrc: cpp Commentout'
    let marker1 = '///'
    let marker2 = ''
  elseif lang == 'vb'
    echon '.vimrc: vb Commentout'
    let marker1 = "'''"
    let marker2 = ''
  elseif lang == 'bat'
    echon '.vimrc: bat Commentout'
    let marker1 = ":::"
    let marker2 = ''
    if !match(line, ':')
      echon '.vimrc: remove bat comment'
      let l1 = substitute(line, '^:::', '', 'g')
      let l2 = substitute(l1, '', '', 'g')
      return l2
    endif
  elseif lang == 'vim'
    echon '.vimrc: vim Commentout'
    let marker1 = '"""'
    let marker2 = ''
    if !match(line, '"')
      echon '.vimrc: remove vim comment'
      let l1 = substitute(line, '^"""', '', 'g')
      let l2 = substitute(l1, '', '', 'g')
      return l2
    endif
  else
"""    if lang == 'default'
"""      echon '.vimrc: unknown language: (' lang ') so using default Commentout style'
"""    endif
    let marker1 = '###'
    let marker2 = ''
    if !match(line, '#')
      echon '.vimrc: remove comment'
      let l1 = substitute(line, '^###', '', 'g')
      let l2 = substitute(l1, '', '', 'g')
      return l2
    endif
  endif

  let l1 = substitute(line, '^', marker1, 'g')
  let l2 = substitute(l1, '$', marker2, 'g')

  return l2
endfu
" }}}


fu! AlignAssignments()  " {{{2
  " Adapated from Damien Conway http://www.ibm.com/developerworks/linux/library/l-vim-script-2/index.html

  "Patterns needed to locate assignment operators...
  let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
  let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'

  "Locate block of code to be considered (same indentation, no blanks)
  " Assumes we have cursor in the block of interest.
  let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
  " Search upwards to find the first contiguous line with the same indentation
  " as the current line
  let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
  let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
  " The search might hit the end of the file without finding a differently
  " indented line, in which case search() would return -1
  if lastline < 0
    let lastline = line('$')
  endif

  "Find the column at which the operators should be aligned...
  let max_align_col = 0
  let max_op_width  = 0
  for linetext in getline(firstline, lastline)
    "Does this line have an assignment in it?
    let left_width = match(linetext, '\s*' . ASSIGN_OP)

    "If so, track the maximal assignment column and operator width...
    if left_width >= 0
      let max_align_col = max([max_align_col, left_width])

      let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
      let max_op_width  = max([max_op_width, op_width+1])
     endif
  endfor

  "Code needed to reformat lines so as to align operators...
  " Note printf is actually sprintf in most languages except vimscript
  let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
  \                                    max_op_width,  submatch(2))'

  " Reformat lines with operators aligned in the appropriate column...
  for linenum in range(firstline, lastline)
    let oldline = getline(linenum)
    let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
    call setline(linenum, newline)
  endfor
endfu
"""nmap <silent>  ;=  :call AlignAssignments()<CR>


" Table of completion specifications (a list of lists)...   
" Build a TAB key function that can:
"  -Recognize special user-defined insertion contexts and complete them appropriately
"   Fall back to regular CTRL-N completion after an identifier
"   -till act like a TAB everywhere else
let s:completions = []
" Function to add user-defined completions...
fu! AddCompletion (left, right, completion, restore)
  " Adapted: Tue 13 Mar 2012 12:33:32 (Bob Heckel -- Damian Conway)
  " http://www.ibm.com/developerworks/linux/library/l-vim-script-3/index.html
  call insert(s:completions, [a:left, a:right, a:completion, a:restore])
endfunction
let s:NONE = ""
" Table of completions...
"                    Left          Right    Complete with...       Restore
"                    =====         =======  ====================   =======
call AddCompletion( '{',           s:NONE,  "}",                      1 )
call AddCompletion( '{',           '}',     "\<CR>\<C-D>\<ESC>O",     0 )
call AddCompletion( '\[',          s:NONE,  "]",                      1 )
call AddCompletion( '\[',          '\]',    "\<CR>\<ESC>O\<TAB>",     0 )
call AddCompletion( '(',           s:NONE,  ")",                      1 )
call AddCompletion( '(',           ')',     "\<CR>\<ESC>O\<TAB>",     0 )
call AddCompletion( '<',           s:NONE,  ">",                      1 )
call AddCompletion( '<',           '>',     "\<CR>\<ESC>O\<TAB>",     0 )
call AddCompletion( '"',           s:NONE,  '"',                      1 )
call AddCompletion( '"',           '"',     "\\n",                    1 )
call AddCompletion( "'",           s:NONE,  "'",                      1 )
call AddCompletion( "'",           "'",     s:NONE,                   0 )
call AddCompletion( 'function!\?', "",      "\<CR>endfunction",       1 )
" Implement smart completion magic...
function! SmartComplete ()
  let cursorpos = getpos('.')
  let cursorcol = cursorpos[2]
  let curr_line = getline('.')

  " Special subpattern to match only at cursor position...
  let curr_pos_pat = '\%' . cursorcol . 'c'

  " Tab as usual at the left margin...
  if curr_line =~ '^\s*' . curr_pos_pat
      return "\<TAB>"
  endif

  " How to restore the cursor position...
  let cursor_back = "\<C-O>:call setpos('.'," . string(cursorpos) . ")\<CR>"

  " If a matching smart completion has been specified, use that...
  for [left, right, completion, restore] in s:completions
      let pattern = left . curr_pos_pat . right
      if curr_line =~ pattern
          " Code around bug in setpos() when used at EOL...
          if cursorcol == strlen(curr_line)+1 && strlen(completion)==1 
              let cursor_back = "\<LEFT>"
          endif

          " Return the completion...
          return completion . (restore ? cursor_back : "")
      endif
  endfor

  " If no contextual match and after an identifier, do keyword completion...
  if curr_line =~ '\k' . curr_pos_pat
      return "\<C-N>"

  " Otherwise, just be a <TAB>...
  else
      return "\<TAB>"
  endif
endfu
" }}}


fu! Websearch()  "{{{2
  " Adapted from http://hartley.io.  Depends on noremap to determine browser and search engine.
  call inputsave()
  let searchterm = input('search: ')
  call inputrestore()
  return searchterm
endfu
" }}}


fu! WrapToggle()  " {{{2
  if &textwidth == 0
    setlocal textwidth=80
    setlocal linebreak
    setlocal wrap
    map j gj
    map k gk
  else
    setlocal textwidth=0
    setlocal nolinebreak
    setlocal nowrap
"""    unmap j
"""    unmap k
  endif
endfu
" }}}


fu! WhichEnv() abort  " {{{2
  " ...else if (WhichEnv() =~# 'LINUX')
  if has('win64') || has('win32') || has('win16')
      return 'WINDOWS'
  else
     return toupper(substitute(system('uname'), '\n', '', ''))
  endif
endfu
" }}}


function! AmIPasting()  " {{{2
  if &paste
		" :echohl WarningMsg | echo "Don't panic!" | echohl None
    return ' <<<                                   P A S T E                                   >>>'
  else
    return ''
  endif
endfunction
" }}}

" end Functions-


"   Autocommands  {{{1  
"  Begin aucommands 	
"
"  Chain commands with '\\\|'
"  No spaces between comma-delimited file lists!
"--------------------------------------------------------------------------

" Avoid double sourcing
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
 
	" Return to the line and column of last edited position
	autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif
	" autocmd BufReadPost [^vimxfer_ses] if line("'\"") | exe "normal '\"" | endif

  " Move cursor to filename for fast gf
	" autocmd BufReadPost /tmp/.loc,/tmp/.rme exe "normal $"

  " Handle my ~/bin/sasrun script files
  au BufRead tmpsas.*.log,tmpsas.*.lst map q :qa!<CR>
  au BufRead tmpsas.*.log,tmpsas.*.lst echo '.vimrc: q to quit all'
  " au BufRead /cygdrive/c/temp/query.out map q :qa!<CR>
  " au BufRead /cygdrive/c/temp/query.out echo '.vimrc: q to quit all'

  " au BufNewFile,BufRead,BufEnter *.sas map ;; :call setline('.', Commentout(getline('.'), 'sas'))<CR>
  " au BufNewFile,BufRead,BufEnter *.sas map ;c 0Di  *  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.sas map ;c 0Di  *  Created: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.sas map ;m 0Di  * Modified: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.sas map ,m yy0I***<ESC>p
  " Define pairs to allow the 'bounce on %' plugin to work.  Case insensitive.  No spaces between pairs!
  au BufNewFile,BufRead,BufEnter *.sas let b:match_words = '\<do\>:\<end\>,\<data\s\+\w\+:\<run\;,%macro.*\;:\<mend\>.*\;,\<sql.*;:\<quit;'
  " Filter SAS Log for error-like lines (and lines that should be errors) only
  au BufNewFile,BufRead,BufEnter *.log nnoremap <silent> <F8> :g!/^ERROR:\\\|^WARNING:\\\|lines were truncated\\\|^NOTE: Invalid data for\\\|^NOTE: Variable/d<CR>
  " au BufNewFile,BufRead,BufEnter *.sas,*.log map ;e /^ERROR:/<CR>
  au BufNewFile,BufRead,BufEnter *.sas,*.log map ;e /^ERROR\\\|^WARNING:/<CR>
  " Bounce
  au BufNewFile,BufRead,BufEnter *.plsql,*.pck,*.prc,*.fnc let b:match_words = '\<begin\>:\<end\>,\<loop\>:\<end loop\>'

  " TOGGLE. Delete the yearly warning lines
  """au BufRead *.log :g/^WARNING: The Base Product\|installation repres/d
  """au BufRead *.log :g/^WARNING: Your system is scheduled to expire on/d
  """au BufRead *.log :g/Please contact your SAS/d
  """au BufRead *.log :g/information.  The SAS System will no longer function on or after that/d
  """au BufRead *.log :g/representative to have it renewed/d

  au BufNewFile,BufRead,BufEnter *.pl nmap ,p :!perl -c %<CR>
  au BufNewFile,BufRead,BufEnter *.pl nmap ;z :!echo && echo && perl %<CR>
  " Alternate help files via 'K'.  Default s/b set above as keywordprg=man
  au BufNewFile,BufRead,BufEnter *.p[lm] set keywordprg=perldoc\ -f
  au BufNewFile,BufRead,BufEnter *.pl map ,3 :s:^###::g<CR>:se nohls<CR>
  " if has ('unix') && version > 599
    " au BufWritePost *.pl silent !chmod a+x <afile>
  " endif
"""  au BufNewFile,BufRead,BufEnter *.pl,*.pm map ;; :call setline('.', Commentout(getline('.'), 'perl'))<CR>
  " end Perl
  
	au BufRead,BufNewFile *.plsql,*.pkg,*.pck,*.spc,*.prc,*.fnc set filetype=plsql

  " TODO use &ft instead of python, need function?
  au BufNewFile,BufRead,BufEnter *.py nmap ;z :!echo && echo && python %<CR>
  " TODO
  " au BufNewFile,BufEnter *.py set tabstop=4

  " au FileType sh set fileformat=unix
  au BufWritePost *.sh silent !chmod a+x <afile>
  au FileType basic map ,m yy0I'''<ESC>p
  au FileType basic map ;s :s:^:''':<CR>
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ;c 0Di//  Created: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ;m 0Di// Modified: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ,m yy0I///<ESC>p
"""  au FileType sh map ;; :call setline('.', Commentout(getline('.'), 'default'))<CR>
  " Default Vim make is for C, this handles C++
  au BufNewFile,BufRead,BufEnter *.cpp set makeprg=g++\ -Wall\ %
  au BufNewFile,BufRead,BufEnter *.c nmap ;z :!gcc %<CR>\|:echon 'compiled a.exe via ;z map'<CR>
"""  au FileType javascript map ;; :call setline('.', Commentout(getline('.'), 'cpp'))<CR>
"""  au BufNewFile,BufRead,BufEnter *.htm*,*xsl* map ;; :call setline('.', Commentout(getline('.'), 'html'))<CR>
  au BufNewFile,BufRead,BufEnter *.htm* map ,m yy0I///<ESC>p
  au BufNewFile,BufRead,BufEnter *.asp,*.bas let s:VBnotend = '\%(\<end\s\+\)\@<!'
  au BufNewFile,BufRead,BufEnter *.asp,*.bas let b:match_words = s:VBnotend . '\<if\>:\<end\s\+if\>'
  " Automatically flow text
  au BufReadPre,FileReadPre *.email set formatoptions=a

  " au BufNewFile,BufRead,BufEnter *vimperatorrc* source ~/code/misccode/vimperator.vim

	" Conveniences for my custom searching code e.g. bgrep, rme or prj
  au BufNewFile,BufEnter */tmp/*.grep source ~/code/misccode/bgrep.vim
  au BufNewFile,BufEnter */tmp/*.grep,*/tmp/prj.out,*/tmp/.rme map <CR> <C-W>f :set winheight=9999<CR>/<C-R>/<CR>
  au BufNewFile,BufEnter */tmp/*.grep,*/tmp/prj.out,*/tmp/.rme map q :q<CR>
  au BufNewFile,BufEnter */tmp/*.grep,*/tmp/prj.out,*/tmp/.rme set hls
  au BufNewFile,BufEnter */tmp/*.grep,*/tmp/prj.out,*/tmp/.rme echon '.vimrc: <CR> to select file, q to quit'

  "TODO how to keep non-txt bufs that are switched into from being se wrap?
  " au BufRead,BufEnter *.txt set wrap

  " Don't wrap these
  au BufRead,BufEnter *.htm*,*.cgi,*/tmp/bash*,afiedt.buf,*.sql set tw=0 wm=0

  au BufRead,BufEnter afiedt.buf set filetype=sql
  " TODO 06-Feb-19 getting tab indentation some reason - block for now:
  " au BufRead,BufEnter *.sql,afiedt.buf set noexpandtab
  au BufRead,BufEnter *.sql,afiedt.buf iab LI limit 10
  au BufRead,BufEnter *.sql,afiedt.buf iab OB order by 1
  au BufRead,BufEnter *.sql,afiedt.buf iab SF select * from
  au BufRead,BufEnter *.sql,afiedt.buf iab SC select count(*) from
  au BufRead,BufEnter *.sql,afiedt.buf iab WH where

  " Add to /usr/share/vim/vim81/syntax/sqloracle.vim for when PLSQL code sneaks into a .sql
  au BufRead,BufEnter *.sql syn keyword sqlFunction	FORALL SAVE EXCEPTIONS
  au BufRead,BufEnter *.sql syn keyword sqlKeyword SIBLINGS MERGE

  " See  set cinwords  above.
"""  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.pl,*.pm,*.sas set smartindent
  " Fix not-so-smartindent comment outdenting:  TODO ignored, can't use
  " >> to shift lines starting with '#'
"""  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.pl,*.pm,*.sas inoremap # X#
  " Remove trailing blank lines so they don't get '>' quoted.
  " TODO need to remove blank > lines instead of blank lines
  """autocmd BufRead mutt-*[0-9],.followup,.article,.letter :1,$!sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba'
  " end ~/bin/bgrep

  " We never edit these files so simplify exiting:
  au BufEnter $VIMRUNTIME/doc/*.txt nnoremap q :q<CR>
  au BufLeave $VIMRUNTIME/doc/*.txt unmap q

  " Set to empty to default to Vim's help:
  au BufNewFile,BufRead,BufEnter *.vim,.vimrc,*.htm,*.html,*_vimrc set keywordprg=
  au FileType HELP set keywordprg=

  " au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;c 0Di"  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;c 0Di"  Created: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;m 0Di" Modified: <C-R>=strftime("%a %d-%b-%Y")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ,m yy0I"""<ESC>p
"""  au BufNewFile,BufRead,BufEnter .bashrc,_bashrc* map ;; :call setline('.', Commentout(getline('.'), 'bash'))<CR>
  au BufNewFile,BufRead,BufEnter *.vim nmap ;z :source %<CR>

  " MS Office
  au BufReadPre *.doc set ro
  au BufReadPre *.doc set hlsearch!
  au BufReadPre *.doc nnoremap q :q!<CR>
  au BufReadPost *.doc echon '.vimrc: q mapped to :q!'
  " If installed
  if exists(":antiword")
    au BufReadPost *.doc %!antiword "%"
  endif

  augroup Binary
    au!
    au BufReadPre  *.exe let &bin=1
    au BufReadPost *.exe if &bin | %!xxd
    au BufReadPost *.exe set ft=xxd | endif
    au BufWritePre *.exe if &bin | %!xxd -r
    au BufWritePre *.exe endif
    au BufWritePost *.exe if &bin | %!xxd
    au BufWritePost *.exe set nomod | endif
  augroup END

  "TODO handle Cygwin paths
  " au BufRead *.pdf silent execute "!explorer" . shellescape(expand("%:p")) . " &>/dev/null &" | buffer# | bdelete# | redraw! | syntax on

  " This block must be placed near end of au commands for syntax coloring to
  " be disabled.
  if &diff
    " Don't interfere with diff's syntax
    au BufNewFile,BufRead,BufEnter * syntax off
    " Always maximize gvim when using vimdiff
    au GUIEnter * simalt ~x
    """set guifont=Andale_Mono:h7
    " TODO gtk
    set guifont=Consolas:h7
  endif

  au BufRead *.xml map <F3> :silent 1,$!xmllint --format --recover - 2>/dev/null

  au BufEnter .vimrc echo ".vimrc: $MYVIMRC:" $MYVIMRC
  au BufEnter .vimrc set textwidth=100

  au BufEnter oneliners,.vimrc,_vimrc,.bashrc,_bashrc set foldmethod=marker
	au BufRead,BufNewFile oneliners set filetype=txt

  " We'll never need to edit a tarball or QuickFix list
  au FileType TAR,QF map q :q<CR>

  " Always edit git commit messages at position 1L,1C
  au FileType GITCOMMIT :1

  " Act like gvim when a file was changed behind our back:
  au WinEnter * checktime

  au BufNewFile,BufRead *.md   set syntax=markdown

  " Without this, NetRW loses its place when returning to the tree (use buffer n because mz is taken by netrw):
	au BufLeave NetrwTreeListing mn
	au BufEnter NetrwTreeListing `n

  " Enterprise Guide files
  au BufReadCmd *.egp call zip#Browse(expand("<amatch>"))

  " See my .bashrc function ses()
  " au BufReadCmd /tmp/bash-fc* nmap ;r :call ReadFromFile(VTMP, '.vimxfer_ses')<CR>
  " au BufEnter /tmp/bash-fc* set ff=unix

  " au BufNewFile,BufRead,BufEnter *.log set noswapfile | set hlsearch | source c:/cygwin64/home/bob.heckel/code/sas/saslog.vim
  " au BufNewFile,BufRead,BufEnter *.log set noswapfile | set hlsearch | source $HOME/code/sas/saslog.vim
  " au BufNewFile,BufRead,BufEnter *.log set noswapfile | set hlsearch | source $VIMRUNTIME\syntax\saslog.vim

  " Avoid ;w failure if this file is open by accident anywhere by ,e (it should never be edited)
  au BufReadPre,FileReadPre .vimxfer set noswapfile

  " if THISBOX == 'appa'
    " au BufNewFile,BufRead,BufEnter *.sas | syntax clear | source $HOME/code/sas/sas.vim
  " endif

  " Resize buffer (most convenient with number keypad) if more than one exists
  " GUI uses + for font resizing (due to inability to use control-mousewheel)
  if ! has('gui')
    if exists('+getbufinfo')
      au BufEnter * if len(getbufinfo({'buflisted':1})) > 1 | exe "nnoremap + <C-W>+" | endif
      au BufEnter * if len(getbufinfo({'buflisted':1})) > 1 | exe "nnoremap - <C-W>-" | endif
      "TODO reset when back to 1 buf
      " au BufEnter * if len(getbufinfo({'buflisted':1})) == 1 | exe "nnoremap - noop" | endif
    endif
  endif

  au BufRead * if @% =~ 'oneliners$' 
    hi Oneliners ctermbg=Black ctermfg=DarkGray guifg=DarkGray guibg=Black 
    match Oneliners @^".*$\|^--.*$\|^\/\/.*$\|^#.*$\|^::.*$\|^\s\?\/\*.*$@

  "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
  "
	" TODO move to ~/.vimrc.project or something
  " Temporary project-specific hacks to normalize messy problem-spaces:

  if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
"""    au BufRead LimsGistTableCount.txt :se list
"""    au GUIEnter oracle_queries.sql,update.sql winpos 37 55 | se lines=20 | se columns=170 | se wrap | map j gj
    " SQL*Plus hack to get table/field name completion
"""    au BufRead afiedt.buf winpos 37 55 | se lines=20 | se columns=170 | se tw=999999 | :new | silent :args $HOME/code/misccode/spool/links/*.LST | :hide | map :wq :wq! | noremap ZZ :wq!<CR>
    """au VimLeavePre afiedt.buf execute "w ~/tmp/afiedt.buf." . strftime("%m_%d-%H_%M_%S")

    " Platform warning indicators:
    " gvim
    " au BufRead,BufWinEnter H:/*             hi StatusLine   guifg=Green guibg=Black gui=inverse,bold
    " au BufRead,BufWinLeave H:/*             hi StatusLineNC guifg=Green guibg=Gray gui=inverse,bold
    " vim
"""    au BufRead,BufWinEnter /cygdrive/c/*    hi StatusLine   ctermfg=Blue ctermbg=White
"""    au BufRead,BufWinLeave /cygdrive/c/*    hi StatusLineNC ctermfg=Blue ctermbg=Gray gui=inverse,bold

    " au BufReadPre,FileReadPre [ETHR]:/* set noswapfile
    " TODO what event is a diff window open
    au BufReadPre,FileReadPre Source/* set noswapfile
"""    au BufReadPre,FileReadPre /cygdrive/[mswxyz]/* set noswapfile

    " Do not use The Force on Test & Production
    """au BufEnter [YZ]:/DataPost* set readonly
    """au BufEnter /cygdrive/[yz]/DataPost* set readonly

		"""au BufNewFile,BufRead,BufEnter DataPost*.log set noswapfile | set hlsearch | source u:/code/sas/saslog.vim 
		"""au BufRead,BufNewFile *.map set filetype=xslt
"""    au BufReadPre,FileReadPre /Drugs/Macros/* set noswapfile
"""    au BufReadPre,FileReadPre /Drugs/Cron/* set directory=/Drugs/Personnel/bob/

  " cab SqL e /cygdrive/c/Orion/workspace/data/Source/SQL/

  " end Temporary project-specific
    au BufWritePre,BufLeave * set nobomb
  end
  
  if has('gui')
    " Maximize window upon opening
    " au GUIEnter *.log simalt ~x
    " Run SAS on current .sas file:
    au BufNewFile,BufRead,BufEnter *.sas nmap ;z :!c:/Progra~1/SASIns~1/SAS/V8/sas.exe -sysin %<CR>:args %:r.lst %:r.log<CR>
  else
    " Run my execute SAS shell script in a terminal:
    " au BufNewFile,BufRead,BufEnter *.sas nmap ;z :!~/code/sas/sasrun %:p<CR>
    au BufNewFile,BufRead,BufEnter *.sas nmap ;z :!~/code/sas/sasrun2 "%:p"<CR>
  endif
  "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

endif  " ! autocommands_loaded

" end Autocommands-

"--------------------------------------------------------------------------}}}
"  Inlined Plugins  {{{1
" Simple plugins that are easier to lazily store here rather than ~/.vim/plugin/
" And to improve portability (e.g. Cygwin vs gvim problems).
" This section has to be located after Autocommands.
"--------------------------------------------------------------------------

" 2007-08-08 inlined Inc {{{
" Canonical:
" :'<,'>Inc
" :'<,'>Inc(2)    <---goes 1, 3, 5, etc
"
" For aligned rows, use this one (ctrl-v on the col then :Inc or better, use my ctrl-a
" vnoremap) to sequence the numbers.
"
" File:   increment.vim
" Author: Srinath Avadhanula
" Email:  srinath@eecs.berkeley.edu
" Adapted: Tue Apr 22 11:06:52 2003 (Bob Heckel)
" TODO add arg to determine whether to use zero to left pad (it's the default
" now)
"
" This script provides a way to quickly create incremented lists (either
" increasing or decreasing) using the visual block mode. 
" 
" Synopsis:
" =========
" 1. Suppose you have a column of the following form:
"     array(1) = 3;
"     array(1) = 3;
"     array(1) = 3;
"     array(1) = 3;
"     array(1) = 3;
" 2. Choose the column of '1's using Ctrl-V and then run the command Inc (you
"    should see "'<,'>Inc" on the command line at this point)(if you do not
"    have any other user commands starting with 'I', just I will suffice).
"    This will tranform the text as:
"     array(1) = 3;       array(1) = 3;
"     array(1) = 3;       array(2) = 3;
"     array(1) = 3;  -->  array(3) = 3;
"     array(1) = 3;       array(4) = 3;
"     array(1) = 3;       array(5) = 3;
" 3. You can then choose the column of '3's (again using Ctrl-V) and run the
"    command "Inc 3" to generate another incremented list. This will
"    generate:
"     array(1) = 3;        array(1) =  3;
"     array(2) = 3;        array(2) =  6;
"     array(3) = 3;  -->   array(3) =  9;
"     array(4) = 3;        array(4) = 12;
"     array(5) = 3;        array(5) = 15;
" 	
" 	Note: increment.vim automatically pads the numbers in the the column
" 	with spaces in order to get them right aligned. This is useful in most
" 	cases, but for cases when this might be bad, use IncN which doesnt do
" 	any alignment. 
" 
" Commands:
" =========
" 1. Inc : generates a column of increasing numbers with RIGHT  alignment.
" 2. IncN: generates a column of increasing numbers with NO     alignment.
" 3. IncL: generates a column of increasing numbers with LEFT   alignment
" 
" Tip:
" A mapping which goes well with this command is the following:
" 
" vnoremap <c-a> :Inc<CR>
" 
" With this mapping, select a column of numbers and press Ctrl-A, which will
" get them in increasing order. I use <c-a> because its similar to the <c-a>
" command in normal mode which increments the number under the cursor.
" 

"=========================================================================== 
" (Bob Heckel) default align right
com! -ra -nargs=? Inc :call IncrementColumn(1, <args>)
"""com! -ra -nargs=? IncR :call IncrementColumn(2,<args>)
" (Bob Heckel) align left
" TODO Using the zero char for padding left is not a good idea.  E.g. 1
" becomes 100
com! -ra -nargs=? IncL :call IncrementColumn(4, <args>)
" (Bob Heckel) no padding
com! -ra -nargs=? IncN :call IncrementColumn(0, <args>)

"=========================================================================== 
" (Bob Heckel)
" E.g. for zero pads, return a 0
" Accepts str to use for left padding (if necessary) and number of times to
" repeat that str (e.g. 2 times for 001).
function! StrRepeat(str, count)
  let i = 1
  let retStr = ""
  while i <= a:count
          let retStr = retStr . a:str
          let i = i + 1
  endwhile
  return retStr
endfunction


" first argument is either 0 or 1 or 2 depending on whether padding with
" spaces is desired (pad = 1,2) or not. the second argument contains the
" counter increment. its optional. if not specified, its assumed to be 1.
function! IncrementColumn(pad, ...)
  " (Bob Heckel)
  echon '.vimrc: IncrementColumn() using defaults.'

	if a:0 == 0
		let incr = 1
	elseif a:0 == 1
		let incr = a:1
    " (Bob Heckel)
    echon "\t\tIncrement == " a:1
	else
		return
	end

	let c1 = col("'<")
	let c2 = col("'>")
	let c1v = virtcol("'<")
	let c2v = virtcol("'>")
	let clen = c2v - c1v
	if c1 > c2
		let temp = c1
		let c1 = c2
		let c2 = temp
	end

	let r1 = line("'<")
	let r2 = line("'>")
	if r1 > r2
		let temp = r1
		let r1 = r2
		let r2 = temp
	end

	exe r1

	exe "let presNum = ".strpart(getline('.'), c1-1, clen+1)

	let lastnum = presNum + incr*(r2-r1)
	" a simple way to find the number of digits in a number (including decimal
	" points, - signs etc).
	let maxstrlen = strlen("".lastnum)

	let r = r1
	exe 'normal '.c1v.'|'
	while (r <= r2)
		let cnow = col(".")
		let linebef = strpart(getline('.'), 0, cnow-1)
		let lineaft = strpart(getline('.'), cnow+clen, 1000)

		" find the number of padding spaces required for left/rigth alignment
		if a:pad
			let preslen = strlen("".presNum)
      " (Bob Heckel) 
      " Changed from "" to zero char for padding.
			let padspace = StrRepeat("0", maxstrlen - preslen)
		else
			let padspace = ""
		end

		" the final line is made up of 
		" 1. the part of the line before the number
		" 2. the padding spaces.
		" 3. the present number
		" 4. the part of the line after the number
		" the padding spaces are either before or after the current number
		" depending on whether the pad argument is 1 or 2 (respectively).
		if a:pad == 1
			let lineset = linebef.padspace.presNum.lineaft
		elseif a:pad == 2
			let lineset = linebef.presNum.padspace.lineaft
		else
			let lineset = linebef.presNum.lineaft
		end

		call setline('.', lineset)
		let presNum = presNum + incr
		normal j
		let r = r + 1
	endwhile
	normal `<
endfunction/*}}}*/

" 2007-08-08 inlined IncPattern {{{
"=============================================================================
" Canonical:
" :'<,'>Incpat
" :%Incpat 
"
" Replaces '@'s with a sequence starting with 1 and incrementing by 1
"
" :[line1,line2]Inc [i<number>] [s<number>] [p<string>]
" Arguments to the function:
"   range with firstline and lastline
"   ['p<regexp>'] to change the pattern
"   ['s<number>'] to change the starting value
"   ['i<number>'] to change the increment between two consecutive matching lines
"
" :,$s:/\* \d\+ \*/:/\* @ \*/:gc  <---reset to @s
"
" Adapted: Mon 05 May 2008 16:16:06 (Bob Heckel -- from Stanislav Sitar 
"          sitar@procaut.sk increment.vim)
"=========================================================================
function! IncPattern(...) range
  " save line numbers
  let lfirst = a:firstline
  let llast = a:lastline

  " Defaults
  " i1
  let incr = 1
  " s1
  let startingValue = 1
  " p@
  let pattern = "@"

  " Get arguments
  let nargs = 1
  " a:0 is the number of variable/optional arguments passed into the function
  while nargs <= a:0
    let toex = ""
    if a:{nargs} =~? "^i"
      let toex = substitute(a:{nargs},"^i","let incr = ","")
    elseif a:{nargs} =~? "^s"
      let toex = substitute(a:{nargs},"^s","let startingValue = ","")
    elseif a:{nargs} =~? "^p"
      let toex = substitute(a:{nargs},"^p","let pattern = \"","")
      let toex = substitute(toex,"$","\"","")
    else
      " Ignore
      let toex = ""
    endif
    execute toex
    let nargs = nargs + 1
  endwhile

  let val = startingValue
  silent! execute lfirst
  let lineNb = line(".")
  while search(pattern, "W")
    let lineNb = line(".")
    if lineNb > llast
        break
    endif
    silent! execute lineNb."s/".pattern."/".val."/"
    " TODO zeropad
    """if val < 10
      let val = val + incr
      """let val = 0.val
    """else
      """let val = val + incr
    """endif
  endwhile

  if a:0 == 0
    echon ".vimrc (IncPattern()): Using defaults. To override e.g. :1,4call IncPattern('pX','s0','i5')"
  endif
endfunction
command! -nargs=* -range Incpat :<line1>,<line2>call IncPattern(<f-args>) " /*}}}*/

" 2007-08-08 inlined Matchit {{{
" Bounce on '%'
"  matchit.vim: (global plugin) Extended "%" matching
"  Last Change: Sun Feb 26 10:00 AM 2006 EST
"  Maintainer:  Benji Fisher PhD   <benji@member.AMS.org>
"  Version:     1.10, for Vim 6.3
"  URL:		http://www.vim.org/script.php?script_id=39

" Documentation:
"  The documentation is in a separate file, matchit.txt .

" Credits:
"  Vim editor by Bram Moolenaar (Thanks, Bram!)
"  Original script and design by Raul Segura Acevedo
"  Support for comments by Douglas Potts
"  Support for back references and other improvements by Benji Fisher
"  Support for many languages by Johannes Zellner
"  Suggestions for improvement, bug reports, and support for additional
"  languages by Jordi-Albert Batalla, Neil Bird, Servatius Brandt, Mark
"  Collett, Stephen Wall, Dany St-Amant, and Johannes Zellner.

" Debugging:
"  If you'd like to try the built-in debugging commands...
"   :MatchDebug      to activate debugging for the current buffer
"  This saves the values of several key script variables as buffer-local
"  variables.  See the MatchDebug() function, below, for details.

" TODO:  I should think about multi-line patterns for b:match_words.
"   This would require an option:  how many lines to scan (default 1).
"   This would be useful for Python, maybe also for *ML.
" TODO:  Maybe I should add a menu so that people will actually use some of
"   the features that I have implemented.
" TODO:  Eliminate the MultiMatch function.  Add yet another argument to
"   Match_wrapper() instead.
" TODO:  Allow :let b:match_words = '\(\(foo\)\(bar\)\):\3\2:end\1'
" TODO:  Make backrefs safer by using '\V' (very no-magic).
" TODO:  Add a level of indirection, so that custom % scripts can use my
"   work but extend it.

" allow user to prevent loading
" and prevent duplicate loading
if exists("loaded_matchit") || &cp
  finish
endif
let loaded_matchit = 1
let s:last_mps = ""
let s:last_words = ""

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> %  :<C-U>call <SID>Match_wrapper('',1,'n') <CR>
nnoremap <silent> g% :<C-U>call <SID>Match_wrapper('',0,'n') <CR>
vnoremap <silent> %  :<C-U>call <SID>Match_wrapper('',1,'v') <CR>m'gv``
vnoremap <silent> g% :<C-U>call <SID>Match_wrapper('',0,'v') <CR>m'gv``
onoremap <silent> %  v:<C-U>call <SID>Match_wrapper('',1,'o') <CR>
onoremap <silent> g% v:<C-U>call <SID>Match_wrapper('',0,'o') <CR>

" Analogues of [{ and ]} using matching patterns:
nnoremap <silent> [% :<C-U>call <SID>MultiMatch("bW", "n") <CR>
nnoremap <silent> ]% :<C-U>call <SID>MultiMatch("W",  "n") <CR>
vnoremap [% <Esc>[%m'gv``
vnoremap ]% <Esc>]%m'gv``
" vnoremap <silent> [% :<C-U>call <SID>MultiMatch("bW", "v") <CR>m'gv``
" vnoremap <silent> ]% :<C-U>call <SID>MultiMatch("W",  "v") <CR>m'gv``
onoremap <silent> [% v:<C-U>call <SID>MultiMatch("bW", "o") <CR>
onoremap <silent> ]% v:<C-U>call <SID>MultiMatch("W",  "o") <CR>

" text object:
vnoremap a% <Esc>[%v]%

" Auto-complete mappings:  (not yet "ready for prime time")
" TODO Read :help write-plugin for the "right" way to let the user
" specify a key binding.
"   let g:match_auto = '<C-]>'
"   let g:match_autoCR = '<C-CR>'
" if exists("g:match_auto")
"   execute "inoremap " . g:match_auto . ' x<Esc>"=<SID>Autocomplete()<CR>Pls'
" endif
" if exists("g:match_autoCR")
"   execute "inoremap " . g:match_autoCR . ' <CR><C-R>=<SID>Autocomplete()<CR>'
" endif
" if exists("g:match_gthhoh")
"   execute "inoremap " . g:match_gthhoh . ' <C-O>:call <SID>Gthhoh()<CR>'
" endif " gthhoh = "Get the heck out of here!"

let s:notslash = '\\\@<!\%(\\\\\)*'

function! s:Match_wrapper(word, forward, mode) range
  " In s:CleanUp(), :execute "set" restore_options .
  let restore_options = (&ic ? " " : " no") . "ignorecase"
  if exists("b:match_ignorecase")
    let &ignorecase = b:match_ignorecase
  endif
  let restore_options = " ve=" . &ve . restore_options
  set ve=
  " If this function was called from Visual mode, make sure that the cursor
  " is at the correct end of the Visual range:
  if a:mode == "v"
    execute "normal! gv\<Esc>"
  endif
  " In s:CleanUp(), we may need to check whether the cursor moved forward.
  let startline = line(".")
  let startcol = col(".")
  " Use default behavior if called with a count or if no patterns are defined.
  if v:count
    exe "normal! " . v:count . "%"
    return s:CleanUp(restore_options, a:mode, startline, startcol)
  elseif !exists("b:match_words") || b:match_words == ""
    silent! normal! %
    return s:CleanUp(restore_options, a:mode, startline, startcol)
  end

  " First step:  if not already done, set the script variables
  "   s:do_BR	flag for whether there are backrefs
  "   s:pat	parsed version of b:match_words
  "   s:all	regexp based on s:pat and the default groups
  "
  " Allow b:match_words = "GetVimMatchWords()" .
  if b:match_words =~ ":"
    let match_words = b:match_words
  else
    execute "let match_words =" b:match_words
  endif
" Thanks to Preben "Peppe" Guldberg and Bram Moolenaar for this suggestion!
  if (match_words != s:last_words) || (&mps != s:last_mps) ||
    \ exists("b:match_debug")
    let s:last_words = match_words
    let s:last_mps = &mps
    if match_words !~ s:notslash . '\\\d'
      let s:do_BR = 0
      let s:pat = match_words
    else
      let s:do_BR = 1
      let s:pat = s:ParseWords(match_words)
    endif
    " The next several lines were here before
    " BF started messing with this script.
    " quote the special chars in 'matchpairs', replace [,:] with \| and then
    " append the builtin pairs (/*, */, #if, #ifdef, #else, #elif, #endif)
    " let default = substitute(escape(&mps, '[$^.*~\\/?]'), '[,:]\+',
    "  \ '\\|', 'g').'\|\/\*\|\*\/\|#if\>\|#ifdef\>\|#else\>\|#elif\>\|#endif\>'
    let default = escape(&mps, '[$^.*~\\/?]') . (strlen(&mps) ? "," : "") .
      \ '\/\*:\*\/,#if\%(def\)\=:#else\>:#elif\>:#endif\>'
    " s:all = pattern with all the keywords
    let s:all = s:pat . (strlen(s:pat) ? "," : "") . default
    let s:all = substitute(s:all, s:notslash . '\zs[,:]\+', '\\|', 'g')
    let s:all = '\%(' . s:all . '\)'
    " let s:all = '\%(' . substitute(s:all, '\\\ze[,:]', '', 'g') . '\)'
    if exists("b:match_debug")
      let b:match_pat = s:pat
    endif
  endif

  " Second step:  set the following local variables:
  "     matchline = line on which the cursor started
  "     curcol    = number of characters before match
  "     prefix    = regexp for start of line to start of match
  "     suffix    = regexp for end of match to end of line
  " Require match to end on or after the cursor and prefer it to
  " start on or before the cursor.
  let matchline = getline(startline)
  if a:word != ''
    " word given
    if a:word !~ s:all
      echohl WarningMsg|echo 'Missing rule for word:"'.a:word.'"'|echohl NONE
      return s:CleanUp(restore_options, a:mode, startline, startcol)
    endif
    let matchline = a:word
    let curcol = 0
    let prefix = '^\%('
    let suffix = '\)$'
  " Now the case when "word" is not given
  else	" Find the match that ends on or after the cursor and set curcol.
    let regexp = s:Wholematch(matchline, s:all, startcol-1)
    let curcol = match(matchline, regexp)
    let suf = strlen(matchline) - matchend(matchline, regexp)
    let prefix = (curcol ? '^.\{'  . curcol . '}\%(' : '^\%(')
    let suffix = (suf ? '\).\{' . suf . '}$'  : '\)$')
    " If the match comes from the defaults, bail out.
    if matchline !~ prefix .
      \ substitute(s:pat, s:notslash.'\zs[,:]\+', '\\|', 'g') . suffix
      silent! norm! %
      return s:CleanUp(restore_options, a:mode, startline, startcol)
    endif
  endif
  if exists("b:match_debug")
    let b:match_match = matchstr(matchline, regexp)
    let b:match_col = curcol+1
  endif

  " Third step:  Find the group and single word that match, and the original
  " (backref) versions of these.  Then, resolve the backrefs.
  " Set the following local variable:
  " group = colon-separated list of patterns, one of which matches
  "       = ini:mid:fin or ini:fin
  "
  " Reconstruct the version with unresolved backrefs.
  let patBR = substitute(match_words.',',
    \ s:notslash.'\zs[,:]*,[,:]*', ',', 'g')
  let patBR = substitute(patBR, s:notslash.'\zs:\{2,}', ':', 'g')
  " Now, set group and groupBR to the matching group: 'if:endif' or
  " 'while:endwhile' or whatever.  A bit of a kluge:  s:Choose() returns
  " group . "," . groupBR, and we pick it apart.
  let group = s:Choose(s:pat, matchline, ",", ":", prefix, suffix, patBR)
  let i = matchend(group, s:notslash . ",")
  let groupBR = strpart(group, i)
  let group = strpart(group, 0, i-1)
  " Now, matchline =~ prefix . substitute(group,':','\|','g') . suffix
  if s:do_BR " Do the hard part:  resolve those backrefs!
    let group = s:InsertRefs(groupBR, prefix, group, suffix, matchline)
  endif
  if exists("b:match_debug")
    let b:match_wholeBR = groupBR
    let i = matchend(groupBR, s:notslash . ":")
    let b:match_iniBR = strpart(groupBR, 0, i-1)
  endif

  " Fourth step:  Set the arguments for searchpair().
  let i = matchend(group, s:notslash . ":")
  let j = matchend(group, '.*' . s:notslash . ":")
  let ini = strpart(group, 0, i-1)
  let mid = substitute(strpart(group, i,j-i-1), s:notslash.'\zs:', '\\|', 'g')
  let fin = strpart(group, j)
  "Un-escape the remaining , and : characters.
  let ini = substitute(ini, s:notslash . '\zs\\\(:\|,\)', '\1', 'g')
  let mid = substitute(mid, s:notslash . '\zs\\\(:\|,\)', '\1', 'g')
  let fin = substitute(fin, s:notslash . '\zs\\\(:\|,\)', '\1', 'g')
  " searchpair() requires that these patterns avoid \(\) groups.
  let ini = substitute(ini, s:notslash . '\zs\\(', '\\%(', 'g')
  let mid = substitute(mid, s:notslash . '\zs\\(', '\\%(', 'g')
  let fin = substitute(fin, s:notslash . '\zs\\(', '\\%(', 'g')
  " Set mid.  This is optimized for readability, not micro-efficiency!
  if a:forward && matchline =~ prefix . fin . suffix
    \ || !a:forward && matchline =~ prefix . ini . suffix
    let mid = ""
  endif
  " Set flag.  This is optimized for readability, not micro-efficiency!
  if a:forward && matchline =~ prefix . fin . suffix
    \ || !a:forward && matchline !~ prefix . ini . suffix
    let flag = "bW"
  else
    let flag = "W"
  endif
  " Set skip.
  if exists("b:match_skip")
    let skip = b:match_skip
  elseif exists("b:match_comment") " backwards compatibility and testing!
    let skip = "r:" . b:match_comment
  else
    let skip = 's:comment\|string'
  endif
  let skip = s:ParseSkip(skip)
  if exists("b:match_debug")
    let b:match_ini = ini
    let b:match_tail = (strlen(mid) ? mid.'\|' : '') . fin
  endif

  " Fifth step:  actually start moving the cursor and call searchpair().
  " Later, :execute restore_cursor to get to the original screen.
  let restore_cursor = virtcol(".") . "|"
  normal! g0
  let restore_cursor = line(".") . "G" .  virtcol(".") . "|zs" . restore_cursor
  normal! H
  let restore_cursor = "normal!" . line(".") . "Gzt" . restore_cursor
  execute restore_cursor
  normal! 0
  if curcol
    execute "normal!" . curcol . "l"
  endif
  if skip =~ 'synID' && !(has('syntax') && exists('g:syntax_on'))
    let skip = "0"
  else
    execute "if " . skip . "| let skip = '0' | endif"
  endif
  let sp_return = searchpair(ini, mid, fin, flag, skip)
  let final_position = "call cursor(" . line(".") . "," . col(".") . ")"
  " Restore cursor position and original screen.
  execute restore_cursor
  normal! m'
  if sp_return > 0
    execute final_position
  endif
  return s:CleanUp(restore_options, a:mode, startline, startcol, mid.'\|'.fin)
endfun

" Restore options and do some special handling for Operator-pending mode.
" The optional argument is the tail of the matching group.
fun! s:CleanUp(options, mode, startline, startcol, ...)
  execute "set" a:options
  " Open folds, if appropriate.
  if a:mode != "o"
    if &foldopen =~ "percent"
      normal! zv
    endif
    " In Operator-pending mode, we want to include the whole match
    " (for example, d%).
    " This is only a problem if we end up moving in the forward direction.
  elseif (a:startline < line(".")) ||
	\ (a:startline == line(".") && a:startcol < col("."))
    if a:0
      " Check whether the match is a single character.  If not, move to the
      " end of the match.
      let matchline = getline(".")
      let currcol = col(".")
      let regexp = s:Wholematch(matchline, a:1, currcol-1)
      let endcol = matchend(matchline, regexp)
      if endcol > currcol  " This is NOT off by one!
	execute "normal!" . (endcol - currcol) . "l"
      endif
    endif " a:0
  endif " a:mode != "o" && etc.
  return 0
endfun

" Example (simplified HTML patterns):  if
"   a:groupBR	= '<\(\k\+\)>:</\1>'
"   a:prefix	= '^.\{3}\('
"   a:group	= '<\(\k\+\)>:</\(\k\+\)>'
"   a:suffix	= '\).\{2}$'
"   a:matchline	=  "123<tag>12" or "123</tag>12"
" then extract "tag" from a:matchline and return "<tag>:</tag>" .
fun! s:InsertRefs(groupBR, prefix, group, suffix, matchline)
  if a:matchline !~ a:prefix .
    \ substitute(a:group, s:notslash . '\zs:', '\\|', 'g') . a:suffix
    return a:group
  endif
  let i = matchend(a:groupBR, s:notslash . ':')
  let ini = strpart(a:groupBR, 0, i-1)
  let tailBR = strpart(a:groupBR, i)
  let word = s:Choose(a:group, a:matchline, ":", "", a:prefix, a:suffix,
    \ a:groupBR)
  let i = matchend(word, s:notslash . ":")
  let wordBR = strpart(word, i)
  let word = strpart(word, 0, i-1)
  " Now, a:matchline =~ a:prefix . word . a:suffix
  if wordBR != ini
    let table = s:Resolve(ini, wordBR, "table")
  else
    " let table = "----------"
    let table = ""
    let d = 0
    while d < 10
      if tailBR =~ s:notslash . '\\' . d
	" let table[d] = d
	let table = table . d
      else
	let table = table . "-"
      endif
      let d = d + 1
    endwhile
  endif
  let d = 9
  while d
    if table[d] != "-"
      let backref = substitute(a:matchline, a:prefix.word.a:suffix,
	\ '\'.table[d], "")
	" Are there any other characters that should be escaped?
      let backref = escape(backref, '*,:')
      execute s:Ref(ini, d, "start", "len")
      let ini = strpart(ini, 0, start) . backref . strpart(ini, start+len)
      let tailBR = substitute(tailBR, s:notslash . '\zs\\' . d,
	\ escape(backref, '\\'), 'g')
    endif
    let d = d-1
  endwhile
  if exists("b:match_debug")
    if s:do_BR
      let b:match_table = table
      let b:match_word = word
    else
      let b:match_table = ""
      let b:match_word = ""
    endif
  endif
  return ini . ":" . tailBR
endfun

" Input a comma-separated list of groups with backrefs, such as
"   a:groups = '\(foo\):end\1,\(bar\):end\1'
" and return a comma-separated list of groups with backrefs replaced:
"   return '\(foo\):end\(foo\),\(bar\):end\(bar\)'
fun! s:ParseWords(groups)
  let groups = substitute(a:groups.",", s:notslash.'\zs[,:]*,[,:]*', ',', 'g')
  let groups = substitute(groups, s:notslash . '\zs:\{2,}', ':', 'g')
  let parsed = ""
  while groups =~ '[^,:]'
    let i = matchend(groups, s:notslash . ':')
    let j = matchend(groups, s:notslash . ',')
    let ini = strpart(groups, 0, i-1)
    let tail = strpart(groups, i, j-i-1) . ":"
    let groups = strpart(groups, j)
    let parsed = parsed . ini
    let i = matchend(tail, s:notslash . ':')
    while i != -1
      " In 'if:else:endif', ini='if' and word='else' and then word='endif'.
      let word = strpart(tail, 0, i-1)
      let tail = strpart(tail, i)
      let i = matchend(tail, s:notslash . ':')
      let parsed = parsed . ":" . s:Resolve(ini, word, "word")
    endwhile " Now, tail has been used up.
    let parsed = parsed . ","
  endwhile " groups =~ '[^,:]'
  return parsed
endfun

" TODO I think this can be simplified and/or made more efficient.
" TODO What should I do if a:start is out of range?
" Return a regexp that matches all of a:string, such that
" matchstr(a:string, regexp) represents the match for a:pat that starts
" as close to a:start as possible, before being preferred to after, and
" ends after a:start .
" Usage:
" let regexp = s:Wholematch(getline("."), 'foo\|bar', col(".")-1)
" let i      = match(getline("."), regexp)
" let j      = matchend(getline("."), regexp)
" let match  = matchstr(getline("."), regexp)
fun! s:Wholematch(string, pat, start)
  let group = '\%(' . a:pat . '\)'
  let prefix = (a:start ? '\(^.\{,' . a:start . '}\)\zs' : '^')
  let len = strlen(a:string)
  let suffix = (a:start+1 < len ? '\(.\{,'.(len-a:start-1).'}$\)\@=' : '$')
  if a:string !~ prefix . group . suffix
    let prefix = ''
  endif
  return prefix . group . suffix
endfun

" No extra arguments:  s:Ref(string, d) will
" find the d'th occurrence of '\(' and return it, along with everything up
" to and including the matching '\)'.
" One argument:  s:Ref(string, d, "start") returns the index of the start
" of the d'th '\(' and any other argument returns the length of the group.
" Two arguments:  s:Ref(string, d, "foo", "bar") returns a string to be
" executed, having the effect of
"   :let foo = s:Ref(string, d, "start")
"   :let bar = s:Ref(string, d, "len")
fun! s:Ref(string, d, ...)
  let len = strlen(a:string)
  if a:d == 0
    let start = 0
  else
    let cnt = a:d
    let match = a:string
    while cnt
      let cnt = cnt - 1
      let index = matchend(match, s:notslash . '\\(')
      if index == -1
	return ""
      endif
      let match = strpart(match, index)
    endwhile
    let start = len - strlen(match)
    if a:0 == 1 && a:1 == "start"
      return start - 2
    endif
    let cnt = 1
    while cnt
      let index = matchend(match, s:notslash . '\\(\|\\)') - 1
      if index == -2
	return ""
      endif
      " Increment if an open, decrement if a ')':
      let cnt = cnt + (match[index]=="(" ? 1 : -1)  " ')'
      " let cnt = stridx('0(', match[index]) + cnt
      let match = strpart(match, index+1)
    endwhile
    let start = start - 2
    let len = len - start - strlen(match)
  endif
  if a:0 == 1
    return len
  elseif a:0 == 2
    return "let " . a:1 . "=" . start . "| let " . a:2 . "=" . len
  else
    return strpart(a:string, start, len)
  endif
endfun

" Count the number of disjoint copies of pattern in string.
" If the pattern is a literal string and contains no '0' or '1' characters
" then s:Count(string, pattern, '0', '1') should be faster than
" s:Count(string, pattern).
fun! s:Count(string, pattern, ...)
  let pat = escape(a:pattern, '\\')
  if a:0 > 1
    let foo = substitute(a:string, '[^'.a:pattern.']', "a:1", "g")
    let foo = substitute(a:string, pat, a:2, "g")
    let foo = substitute(foo, '[^' . a:2 . ']', "", "g")
    return strlen(foo)
  endif
  let result = 0
  let foo = a:string
  let index = matchend(foo, pat)
  while index != -1
    let result = result + 1
    let foo = strpart(foo, index)
    let index = matchend(foo, pat)
  endwhile
  return result
endfun

" s:Resolve('\(a\)\(b\)', '\(c\)\2\1\1\2') should return table.word, where
" word = '\(c\)\(b\)\(a\)\3\2' and table = '-32-------'.  That is, the first
" '\1' in target is replaced by '\(a\)' in word, table[1] = 3, and this
" indicates that all other instances of '\1' in target are to be replaced
" by '\3'.  The hard part is dealing with nesting...
" Note that ":" is an illegal character for source and target,
" unless it is preceded by "\".
fun! s:Resolve(source, target, output)
  let word = a:target
  let i = matchend(word, s:notslash . '\\\d') - 1
  let table = "----------"
  while i != -2 " There are back references to be replaced.
    let d = word[i]
    let backref = s:Ref(a:source, d)
    " The idea is to replace '\d' with backref.  Before we do this,
    " replace any \(\) groups in backref with :1, :2, ... if they
    " correspond to the first, second, ... group already inserted
    " into backref.  Later, replace :1 with \1 and so on.  The group
    " number w+b within backref corresponds to the group number
    " s within a:source.
    " w = number of '\(' in word before the current one
    let w = s:Count(
    \ substitute(strpart(word, 0, i-1), '\\\\', '', 'g'), '\(', '1')
    let b = 1 " number of the current '\(' in backref
    let s = d " number of the current '\(' in a:source
    while b <= s:Count(substitute(backref, '\\\\', '', 'g'), '\(', '1')
    \ && s < 10
      if table[s] == "-"
	if w + b < 10
	  " let table[s] = w + b
	  let table = strpart(table, 0, s) . (w+b) . strpart(table, s+1)
	endif
	let b = b + 1
	let s = s + 1
      else
	execute s:Ref(backref, b, "start", "len")
	let ref = strpart(backref, start, len)
	let backref = strpart(backref, 0, start) . ":". table[s]
	\ . strpart(backref, start+len)
	let s = s + s:Count(substitute(ref, '\\\\', '', 'g'), '\(', '1')
      endif
    endwhile
    let word = strpart(word, 0, i-1) . backref . strpart(word, i+1)
    let i = matchend(word, s:notslash . '\\\d') - 1
  endwhile
  let word = substitute(word, s:notslash . '\zs:', '\\', 'g')
  if a:output == "table"
    return table
  elseif a:output == "word"
    return word
  else
    return table . word
  endif
endfun

" Assume a:comma = ",".  Then the format for a:patterns and a:1 is
"   a:patterns = "<pat1>,<pat2>,..."
"   a:1 = "<alt1>,<alt2>,..."
" If <patn> is the first pattern that matches a:string then return <patn>
" if no optional arguments are given; return <patn>,<altn> if a:1 is given.
fun! s:Choose(patterns, string, comma, branch, prefix, suffix, ...)
  let tail = (a:patterns =~ a:comma."$" ? a:patterns : a:patterns . a:comma)
  let i = matchend(tail, s:notslash . a:comma)
  if a:0
    let alttail = (a:1 =~ a:comma."$" ? a:1 : a:1 . a:comma)
    let j = matchend(alttail, s:notslash . a:comma)
  endif
  let current = strpart(tail, 0, i-1)
  if a:branch == ""
    let currpat = current
  else
    let currpat = substitute(current, s:notslash . a:branch, '\\|', 'g')
  endif
  while a:string !~ a:prefix . currpat . a:suffix
    let tail = strpart(tail, i)
    let i = matchend(tail, s:notslash . a:comma)
    if i == -1
      return -1
    endif
    let current = strpart(tail, 0, i-1)
    if a:branch == ""
      let currpat = current
    else
      let currpat = substitute(current, s:notslash . a:branch, '\\|', 'g')
    endif
    if a:0
      let alttail = strpart(alttail, j)
      let j = matchend(alttail, s:notslash . a:comma)
    endif
  endwhile
  if a:0
    let current = current . a:comma . strpart(alttail, 0, j-1)
  endif
  return current
endfun

" Call this function to turn on debugging information.  Every time the main
" script is run, buffer variables will be saved.  These can be used directly
" or viewed using the menu items below.
if !exists(":MatchDebug")
  command! -nargs=0 MatchDebug call s:Match_debug()
endif

fun! s:Match_debug()
  let b:match_debug = 1	" Save debugging information.
  " pat = all of b:match_words with backrefs parsed
  amenu &Matchit.&pat	:echo b:match_pat<CR>
  " match = bit of text that is recognized as a match
  amenu &Matchit.&match	:echo b:match_match<CR>
  " curcol = cursor column of the start of the matching text
  amenu &Matchit.&curcol	:echo b:match_col<CR>
  " wholeBR = matching group, original version
  amenu &Matchit.wh&oleBR	:echo b:match_wholeBR<CR>
  " iniBR = 'if' piece, original version
  amenu &Matchit.ini&BR	:echo b:match_iniBR<CR>
  " ini = 'if' piece, with all backrefs resolved from match
  amenu &Matchit.&ini	:echo b:match_ini<CR>
  " tail = 'else\|endif' piece, with all backrefs resolved from match
  amenu &Matchit.&tail	:echo b:match_tail<CR>
  " fin = 'endif' piece, with all backrefs resolved from match
  amenu &Matchit.&word	:echo b:match_word<CR>
  " '\'.d in ini refers to the same thing as '\'.table[d] in word.
  amenu &Matchit.t&able	:echo '0:' . b:match_table . ':9'<CR>
endfun

" Jump to the nearest unmatched "(" or "if" or "<tag>" if a:spflag == "bW"
" or the nearest unmatched "</tag>" or "endif" or ")" if a:spflag == "W".
" Return a "mark" for the original position, so that
"   let m = MultiMatch("bW", "n") ... execute m
" will return to the original position.  If there is a problem, do not
" move the cursor and return "", unless a count is given, in which case
" go up or down as many levels as possible and again return "".
" TODO This relies on the same patterns as % matching.  It might be a good
" idea to give it its own matching patterns.
fun! s:MultiMatch(spflag, mode)
  if !exists("b:match_words") || b:match_words == ""
    return ""
  end
  let restore_options = (&ic ? "" : "no") . "ignorecase"
  if exists("b:match_ignorecase")
    let &ignorecase = b:match_ignorecase
  endif
  let startline = line(".")
  let startcol = col(".")

  " First step:  if not already done, set the script variables
  "   s:do_BR	flag for whether there are backrefs
  "   s:pat	parsed version of b:match_words
  "   s:all	regexp based on s:pat and the default groups
  " This part is copied and slightly modified from s:Match_wrapper().
  let default = escape(&mps, '[$^.*~\\/?]') . (strlen(&mps) ? "," : "") .
    \ '\/\*:\*\/,#if\%(def\)\=:$else\>:#elif\>:#endif\>'
  " Allow b:match_words = "GetVimMatchWords()" .
  if b:match_words =~ ":"
    let match_words = b:match_words
  else
    execute "let match_words =" b:match_words
  endif
  if (match_words != s:last_words) || (&mps != s:last_mps) ||
    \ exists("b:match_debug")
    let s:last_words = match_words
    let s:last_mps = &mps
    if match_words !~ s:notslash . '\\\d'
      let s:do_BR = 0
      let s:pat = match_words
    else
      let s:do_BR = 1
      let s:pat = s:ParseWords(match_words)
    endif
    let s:all = '\%(' . substitute(s:pat . (strlen(s:pat)?",":"") . default,
      \	'[,:]\+','\\|','g') . '\)'
    if exists("b:match_debug")
      let b:match_pat = s:pat
    endif
  endif

  " Second step:  figure out the patterns for searchpair()
  " and save the screen, cursor position, and 'ignorecase'.
  " - TODO:  A lot of this is copied from s:Match_wrapper().
  " - maybe even more functionality should be split off
  " - into separate functions!
  let cdefault = (s:pat =~ '[^,]$' ? "," : "") . default
  let open =  substitute(s:pat . cdefault, ':[^,]*,', '\\),\\(', 'g')
  let open =  '\(' . substitute(open, ':[^,]*$', '\\)', '')
  let close = substitute(s:pat . cdefault, ',[^,]*:', '\\),\\(', 'g')
  let close = substitute(close, '[^,]*:', '\\(', '') . '\)'
  if exists("b:match_skip")
    let skip = b:match_skip
  elseif exists("b:match_comment") " backwards compatibility and testing!
    let skip = "r:" . b:match_comment
  else
    let skip = 's:comment\|string'
  endif
  let skip = s:ParseSkip(skip)
  " let restore_cursor = line(".") . "G" . virtcol(".") . "|"
  " normal! H
  " let restore_cursor = "normal!" . line(".") . "Gzt" . restore_cursor
  let restore_cursor = virtcol(".") . "|"
  normal! g0
  let restore_cursor = line(".") . "G" .  virtcol(".") . "|zs" . restore_cursor
  normal! H
  let restore_cursor = "normal!" . line(".") . "Gzt" . restore_cursor
  execute restore_cursor

  " Third step: call searchpair().
  " Replace '\('--but not '\\('--with '\%(' and ',' with '\|'.
  let openpat =  substitute(open, '\(\\\@<!\(\\\\\)*\)\@<=\\(', '\\%(', 'g')
  let openpat = substitute(openpat, ',', '\\|', 'g')
  let closepat = substitute(close, '\(\\\@<!\(\\\\\)*\)\@<=\\(', '\\%(', 'g')
  let closepat = substitute(closepat, ',', '\\|', 'g')
  if skip =~ 'synID' && !(has('syntax') && exists('g:syntax_on'))
    let skip = '0'
  else
    execute "if " . skip . "| let skip = '0' | endif"
  endif
  mark '
  let level = v:count1
  while level
    if searchpair(openpat, '', closepat, a:spflag, skip) < 1
      call s:CleanUp(restore_options, a:mode, startline, startcol)
      return ""
    endif
    let level = level - 1
  endwhile

  " Restore options and return a string to restore the original position.
  call s:CleanUp(restore_options, a:mode, startline, startcol)
  return restore_cursor
endfun

" Search backwards for "if" or "while" or "<tag>" or ...
" and return "endif" or "endwhile" or "</tag>" or ... .
" For now, this uses b:match_words and the same script variables
" as s:Match_wrapper() .  Later, it may get its own patterns,
" either from a buffer variable or passed as arguments.
" fun! s:Autocomplete()
"   echo "autocomplete not yet implemented :-("
"   if !exists("b:match_words") || b:match_words == ""
"     return ""
"   end
"   let startpos = s:MultiMatch("bW")
"
"   if startpos == ""
"     return ""
"   endif
"   " - TODO:  figure out whether 'if' or '<tag>' matched, and construct
"   " - the appropriate closing.
"   let matchline = getline(".")
"   let curcol = col(".") - 1
"   " - TODO:  Change the s:all argument if there is a new set of match pats.
"   let regexp = s:Wholematch(matchline, s:all, curcol)
"   let suf = strlen(matchline) - matchend(matchline, regexp)
"   let prefix = (curcol ? '^.\{'  . curcol . '}\%(' : '^\%(')
"   let suffix = (suf ? '\).\{' . suf . '}$'  : '\)$')
"   " Reconstruct the version with unresolved backrefs.
"   let patBR = substitute(b:match_words.',', '[,:]*,[,:]*', ',', 'g')
"   let patBR = substitute(patBR, ':\{2,}', ':', "g")
"   " Now, set group and groupBR to the matching group: 'if:endif' or
"   " 'while:endwhile' or whatever.
"   let group = s:Choose(s:pat, matchline, ",", ":", prefix, suffix, patBR)
"   let i = matchend(group, s:notslash . ",")
"   let groupBR = strpart(group, i)
"   let group = strpart(group, 0, i-1)
"   " Now, matchline =~ prefix . substitute(group,':','\|','g') . suffix
"   if s:do_BR
"     let group = s:InsertRefs(groupBR, prefix, group, suffix, matchline)
"   endif
" " let g:group = group
"
"   " - TODO:  Construct the closing from group.
"   let fake = "end" . expand("<cword>")
"   execute startpos
"   return fake
" endfun

" Close all open structures.  "Get the heck out of here!"
" fun! s:Gthhoh()
"   let close = s:Autocomplete()
"   while strlen(close)
"     put=close
"     let close = s:Autocomplete()
"   endwhile
" endfun

" Parse special strings as typical skip arguments for searchpair():
"   s:foo becomes (current syntax item) =~ foo
"   S:foo becomes (current syntax item) !~ foo
"   r:foo becomes (line before cursor) =~ foo
"   R:foo becomes (line before cursor) !~ foo
fun! s:ParseSkip(str)
  let skip = a:str
  if skip[1] == ":"
    if skip[0] == "s"
      let skip = "synIDattr(synID(line('.'),col('.'),1),'name') =~? '" .
	\ strpart(skip,2) . "'"
    elseif skip[0] == "S"
      let skip = "synIDattr(synID(line('.'),col('.'),1),'name') !~? '" .
	\ strpart(skip,2) . "'"
    elseif skip[0] == "r"
      let skip = "strpart(getline('.'),0,col('.'))=~'" . strpart(skip,2). "'"
    elseif skip[0] == "R"
      let skip = "strpart(getline('.'),0,col('.'))!~'" . strpart(skip,2). "'"
    endif
  endif
  return skip
endfun  " /*}}}*/

" 2017-03-07 inlined Commentary {{{
" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || &cp || v:version < 700
  finish
endif
let g:loaded_commentary = 1

function! s:surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(
        \ &commentstring, '\S\zs%s',' %s','') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! s:strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0 && a:line[strlen(a:line)-strlen(r[1:]):-1] == r[1:]
    return [l[0:-2], r[1:]]
  endif
  return [l, r]
endfunction

function! s:go(type,...) abort
  if a:0
    let [lnum1, lnum2] = [a:type, a:1]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l_, r_] = s:surroundings()
  let uncomment = 2
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = s:strip_white_space(l_,r_,line)
    if line != '' && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M'.r[0:-2].'\zs\d\*\ze'.r[-1:-1].'\|'.l[0].'\zs\d\*\ze'.l[1:-1],
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),'^\s*').'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call setline(lnum,line)
  endfor
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
endfunction

function! s:textobject(inner) abort
  let [l_, r_] = s:surroundings()
  let [l, r] = [l_, r_]
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = s:strip_white_space(l_,r_,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

xnoremap <silent> <Plug>Commentary     :<C-U>call <SID>go(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>Commentary     :<C-U>set opfunc=<SID>go<CR>g@
nnoremap <silent> <Plug>CommentaryLine :<C-U>set opfunc=<SID>go<Bar>exe 'norm! 'v:count1.'g@_'<CR>
onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(0)<CR>
nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
nmap <silent> <Plug>CommentaryUndo <Plug>Commentary<Plug>Commentary
command! -range -bar Commentary call s:go(<line1>,<line2>)

if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  nmap cgc <Plug>ChangeCommentary
  nmap gcu <Plug>Commentary<Plug>Commentary
endif

" Add as needed
autocmd FileType sh,perl,crontab,conf setlocal commentstring=#\ %s
autocmd FileType vim setlocal commentstring=\"\ %s

" TODO deprecate my code in favor of this
"}}}

" 2018-11-16 inlined FontSize {{{
let g:fnt_types = ['Consolas', 'Arial', 'Cousine' ]
let g:fnt_sizes = [ 8, 9, 10, 11, 12, 13, 14, 15, 16 ]

let g:fnt_index = 0
let g:fnt_size  = g:fnt_sizes[g:fnt_index]

function! CycleFont()
  let g:fnt_index = (g:fnt_index + 1) % len(g:fnt_types)
  let g:fnt_size  = g:fnt_sizes[g:fnt_index]
  call ResetFont()
endfunction

function! ResetFont ()
  if has('gui_running')
    exe ':set guifont=' . g:fnt_types[g:fnt_index] . ':h' . string(g:fnt_size)
  endif
endfunction

" if ! has('gui_gtk3')
"   call ResetFont()
" endif

function! FontSizePlus ()
  let g:fnt_size = g:fnt_size + 1
  call ResetFont()
endfunction

function! FontSizeMinus ()
  let g:fnt_size = g:fnt_size - 1
  call ResetFont()
endfunction
" nnoremap cot :call CycleFont()<cr>

if has('gui_running')
  " Don't need this pair for mintty because CONTROL+MOUSEWHEEL works properly
  " Fails on Win10 16-Nov-18 
  " nnoremap <C-ScrollWheelUp> :call FontSizePlus()<CR>
  " nnoremap <C-ScrollWheelDown> :call FontSizeMinus()<CR>
  nnoremap <F1> :call FontSizeMinus()<cr>
  nnoremap <F2> :call FontSizePlus()<cr>
endif
"}}}

" end Inlined Plugins-
"--------------------------------------------------------------------------

" Machine/Security Settings: {{{1
if filereadable(glob("$HOME/.vimrc.project"))
  " echon 'sourcing $HOME/.vimrc.project'
  source $HOME/.vimrc.project
elseif filereadable("c:/cygwin64/home/boheck/.vimrc.project") 
  " echon 'sourcing c:/cygwin64/home/boheck/.vimrc.project'
  source c:/cygwin64/home/boheck/.vimrc.project
endif  "}}}
