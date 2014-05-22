"--------------------------------------------------------------------------
"#¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤¤º°`°º¤ø,¸¸,ø¤º°`°º¤ø
"
"     Name: $HOME/.vimrc
"  Summary: Platform-independent, overly ambitious, Vim config file
"                                                                         {{{1
"          'In pursuit of the dubious goal of producing idiot-proof,
"           zero-learning-curve programs, even programs intended for
"           heavy-duty use such as editors--arguably the most important 
"           piece of software you'll use--have been turned into children's 
"           toys, effectively expert-proofed' -- Tom Christiansen
"
"          'Efficiency is intelligent laziness' -- David Dunham
"
"           bheckel@daeb$ time vim -c :q
"           real    0m0.095s
"           user    0m0.070s
"           sys     0m0.020s
"           bheckel@daeb$ time emacs -kill
"           real    0m0.553s
"           user    0m0.030s
"           sys     0m0.010s
"                                                                          }}}
"  Created: Wed 06 Jun 1998 08:54:34 (Bob Heckel)
" Modified: Mon 12 May 2014 14:44:57 (Bob Heckel)
"
"#¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤ø,¸¸,ø¤º°`°º¤øø¤º°`°º¤¤º°`°º¤ø,¸¸,ø¤º°`°º¤ø
"--------------------------------------------------------------------------
"   Initialization  	{{{1
"--------------------------------------------------------------------------
" DEBUG toggle -- watch initialization, etc.  Or use $ vim -V
"""set verbose=1
" DEBUG toggle -- watch changes to text happen slowly (default is 0)
"""set writedelay=5

let THISBOX = hostname()
let WORKBOXARRAY = [ 'ZEBWL06A16349', 'ZEBWD08D26987', 'ZEBWL10D43164', 'ZEBWL12H29961', 'ZEBWL12H26564', 'ZEBWD12H01067' ]

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
"""let g:netrw_sort_by="time"
"""let g:netrw_sort_by="reverse"
"""let g:netrw_list_cmd = "\ls -l"
"""let g:netrw_list_cmd = "/cygdrive/c/windows/System32/WindowsPowerShell/v1.0/powershell -Command dir"

" Setup Vim tempspace that Cygwin and gVim can share:
if matchstr(WORKBOXARRAY, THISBOX) == THISBOX  " at work
  if has('gui')
    let VTMP = 'c:/temp'
    let VTMPU = 'u:/temp'
  elseif has('win32unix')
    let VTMP = '/cygdrive/c/temp'
    let VTMPU = '/cygdrive/u/temp'
  endif
else  " at home
  if !has('unix') && has('gui')
    let VTMP = 'c:/temp'
  elseif has('win32unix')  " Cygwin so that vim & gvim play well together
    let VTMP = '/cygdrive/c/temp'
    let VTMPU = '/cygdrive/u/temp'
  else " probably Linux
    let VTMP = '~/tmp'
  endif
endif

" Fix leftward movement problem on mainframe z/OS:
if has('ebcdic')
  set t_le=
endif

" For syntax and rxvt.  Make sure this comes before the syntax area of this file.
"""if has('win32unix') && has('terminfo')
  set t_Co=256
  """set t_Sb=[4%p1%dm
  """set t_Sf=[3%p1%dm
"""else
"""  " telnet, etc.
"""  set t_Co=8
"""endif

" Force vim to clear itself when exiting:
"""set t_ti=7[r[?47h
"""set t_te=[?47l8

" Change cursor in insert mode (mintty at least):
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set encoding=utf-8

" end Initialization-

"--------------------------------------------------------------------------
"   Color Syntax 	{{{1
"
"  View current highlighting: :hi (optionally :set verbose=1 first for more info) or :so $VIMRUNTIME/syntax/hitest.vim
" 
"  To override built-in syntax: e.g. ln -s ~/code/sas/sas.vim ~/.vim/syntax/
"
"  To test :runtime syntax/colortest.vim
"--------------------------------------------------------------------------

if has ('syntax') && &t_Co > 1
  syntax enable
endif

" Override .Xdefaults
"""hi Cursor ctermfg=Red ctermbg=Red

" Avoid reading text presented like it was written on a light bulb.  We're
" sometimes relying on .Xdefaults to do wheat-on-black so this is only for gvim.
hi Normal guifg=#F5DEB3 guibg=Black

hi Comment ctermfg=DarkGray guifg=DarkGray guibg=Black

hi Conditional ctermfg=LightGreen guifg=LightGreen

hi DiffAdd ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
hi DiffChange ctermfg=Black ctermbg=LightYellow guifg=Black guibg=LightYellow
hi DiffDelete ctermbg=DarkGreen guibg=DarkGreen
hi DiffText ctermfg=Black guifg=Black

hi Directory ctermfg=Magenta guifg=Magenta guibg=Black cterm=bold gui=bold
" Highlight tabs other than at start of line for indenting
"""match ErrorMsg /[^\t]\zs\t\+/
hi ErrorMsg ctermfg=Black ctermbg=Red guifg=Black guibg=Red

hi Folded ctermfg=LightGray ctermbg=Black guifg=LightGray guibg=Black cterm=bold gui=bold
hi Function ctermfg=Yellow guifg=LightYellow guibg=Black
hi Identifier ctermfg=LightCyan guifg=LightCyan
hi IncSearch ctermfg=White ctermbg=LightBlue guifg=White guibg=LightBlue

" :se rnu gutter
hi LineNr ctermfg=Black ctermbg=DarkGray guifg=Black guibg=DarkGray
hi CursorLineNr ctermfg=White ctermbg=DarkGray guifg=White guibg=DarkGray cterm=bold gui=bold

hi MatchParen ctermfg=White ctermbg=Blue guifg=Cyan guibg=Magenta
hi ModeMsg ctermfg=Black ctermbg=Yellow guifg=Black guibg=Yellow
hi MoreMsg ctermfg=Blue ctermbg=Black guifg=Blue
hi Number ctermfg=Magenta ctermbg=Black guifg=Magenta guibg=Black

" Tab completion dropdown
hi Pmenu ctermfg=Black ctermbg=Gray guifg=White guibg=Gray 
hi PmenuSbar ctermfg=Black ctermbg=Gray guifg=White guibg=Black 

hi PmenuSel ctermfg=Blue ctermbg=Yellow guifg=Blue guibg=Yellow 

hi PreProc ctermfg=LightMagenta guifg=LightMagenta guibg=Black

"""hi Search  ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
hi Search  ctermfg=White ctermbg=DarkGray guifg=White guibg=DarkGray 

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
  hi StatusLine ctermfg=Blue ctermbg=White guifg=Blue guibg=White
  " Inactive status line
  hi StatusLineNC ctermfg=Blue ctermbg=Gray guifg=Blue guibg=Gray
endif

hi TabLine ctermfg=Gray ctermbg=DarkGray
hi TabLineSel ctermfg=White ctermbg=DarkGray
hi TabLineFill cterm=underline ctermbg=Gray
hi Title ctermfg=White ctermbg=Magenta guifg=White guibg=Purple
hi Todo cterm=undercurl gui=undercurl 

hi Visual ctermfg=Black ctermbg=LightMagenta guifg=Black guibg=LightMagenta

hi WarningMsg ctermfg=Magenta ctermbg=Yellow guifg=Magenta guibg=Yellow
" :match WhitespaceEOL /\s\+$/
hi WhitespaceEOL ctermbg=red guibg=red

" end Color Syntax-

"--------------------------------------------------------------------------
"   Settings 	{{{1
"    ordered by :option convention
"--------------------------------------------------------------------------
"                                1 important {{{2
" Unleash the beast VIVIVI
set nocompatible

" Show '$' on C and s actions, i.e. emulate vi.  Must have 
" 'let &cpo = s:save_cpo' below in 3rd party plugin section or this is ignored.
" 07-Jul-13 breaks Terminal IDE
"""set cpoptions=s$


"                                2 moving around, searching and pattern {{{2
" H, M, L, gg, etc commands move cursor to first blank in line.
" Must use b/c ,h mapping fails if not used.
set startofline

" For gf - search pwd and subdirs
set path=.,**/*

set wrapscan

" Fast terminals only.
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

set sidescroll=5

set nowrap

" Overriden later depending on file type.  gvim window coordinates.
if has('gui_running')
  winpos 295 295
  set columns=85
  " Most of the time we're just doing clipboard storage so make it small.
  set lines=30
endif

if version > 702
  set relativenumber
  " :se rnu gutter at 7pt font should rarely go > 100
  set numberwidth=3
endif

set lazyredraw

set nolinebreak

set showbreak=^

set scrollopt=hor,ver


"                                5 syntax, highlighting and spelling {{{2

" Adjusted by filetype below
set hlsearch
" turn off highlighted results (set nohlsearch) when pressing enter.
" just pressing n or N will turn the highlight back again
"""autocmd CmdwinEnter * map <buffer> <F5> <CR>q:
"""nnoremap <CR> :nohlsearch <CR>
" Don't interfere with normal q: use of CR TODO not working
"""autocmd CmdwinEnter * unmap <CR>


"                                6 multiple windows {{{2

" Mandatory for displaying a status line
set laststatus=2

" Depends on this being set above:
" hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red guifg=red
" And $VIMSTATUSL being set in .bashrc 
" E.g. ~/code/misccode/_vimrc [+,VIM,unix,b1] rsh868@ZEBWL12H99999   485/4494L,1C(10%)
set statusline=%<%f%h\ [%1*%M%*%R%H%Y,%{&ff},b%n]\ %{$VIMSTATUSL}\ %=\ %l/%LL,%cC%V(%P)

" Use <C-W>= to force equal
set noequalalways

set helpheight=999

" To prevent losing undo on buffer switch (but does create trouble with marks).
" Allows you to switch from an unsaved buffer without saving it first. 
set hidden

set splitbelow


"                                7 multiple tab pages {{{2


"                                8 terminal {{{2

" 'Ctrl-r "' pastes while in insert mode
set esckeys

set title

set titlelen=90


"                                9 using the mouse {{{2

" Not working under Cygwin rxvt
set mousehide

" For spellchecking
set mousemodel=popup

" 16-Mar-14 trying to get vim to mouse scroll - not working
map <M-Esc>[62~ <ScrollWheelUp>
map! <M-Esc>[62~ <ScrollWheelUp>
map <M-Esc>[63~ <ScrollWheelDown>
map! <M-Esc>[63~ <ScrollWheelDown>
map <M-Esc>[64~ <S-ScrollWheelUp>
map! <M-Esc>[64~ <S-ScrollWheelUp>
map <M-Esc>[65~ <S-ScrollWheelDown>
map! <M-Esc>[65~ <S-ScrollWheelDown>

"                               10 printing {{{2

" Left margin is too wide by default
set printoptions=wrap:y,left:5pc


"                               11 messages and info {{{2

set shortmess=xfilmwrItn

" E.g. 111L, 15C in bottom right status bar.  I am controlling the display via
" set statusline instead of set rulerformat
set ruler

" Shhhhhhhhhhhhhhhhhhhh people are trying to work!
set visualbell

" Number of lines changed
set report=0

set showcmd

set showmode


"                               12 selecting text {{{2

" Emulate xterm mouse.  Same as :behave xterm
set selectmode=
set keymodel=
set selection=inclusive


"                               13 editing text {{{2

set dictionary=/usr/share/dict/words

" Toggle to stop undo on massive actions (prevent memory overload)
" set undolevels=-1
set undolevels=5000

" When using C-X + C-P, look in current file and buffers.  See inoremap <TAB>.
set complete=.,w,b

" Add angle brackets to the % functionality
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

" :retab to convert tabs to 2 spaces
set tabstop=2

set shiftwidth=2

" Tabs expanded to spaces.  Replaces the tabs you create when pressing <tab>
" with spaces (to the count of your tabstop).  Alternatively use :retab to
" replace tabs with spaces.
" Without this, doing an 'o' on an indented line, or a '>>' anywhere, inserts a
" new line that starts with one or more tabs.
set expandtab

set cinwords=if,elsif,else,while,do,for,switch,unless,until,when,otherwise,BEGIN,END

set smartindent

set autoindent

"                               15 folding {{{2

set foldmethod=manual

set foldopen-=search


"                               16 diff mode {{{2

if version > 599
"""  set diffopt=filler,iwhite,vertical,icase
  set diffopt=filler,vertical
endif


"                               17 mapping {{{2

"""if ( unixbox == 'sverige' || unixbox == 'otaku' || unixbox == 'iceland' || unixbox == 'sdf' ) 
""""""  set ttimeoutlen=50
"""  set nottyfast
""""""else
""""""  set ttimeoutlen=10
"""endif

" Mapping delay.  E.g. ,m   Also need to change HelpPager() if change this.
set timeoutlen=300


"                               18 reading and writing files {{{2

" Allow backspacing in insert mode.  Make sure stty is set properly.
set backspace=start,indent

" TODO need an iscygwin var instead
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

" Just use my ;5 checkpoint map before starting important changes
set nobackup


"                               19 the swap file {{{2

" Write swap file to disk after 60 inactive seconds
set updatetime=60000


"                               20 command line editing {{{2

set history=5000

" Maximize window for q: history
if version > 599
  set cmdwinheight=999
endif

" Want to emulate bash(1) tab completion
set wildmode=list:longest

set wildchar=<Tab>

if exists("&wildignorecase")
  set wildignorecase
endif

set suffixes=.old,.old2,.OLD,OLD2,.o,.swp,.bak,.bak2,.BAK,.BAK2,~


"                               21 executing external commands {{{2

" We want the Unix version so make sure shell=/bin/sh, :se ep=  to restore
" indent default (gg=G)
set equalprg=sort

" Default.  K to activate.  See au BufNewFile, etc. below (.vimrc, .pl .pm treated specially).
set keywordprg=man


"                               22 running make and jumping to errors {{{2

" Quickfix.  :mak[e]  jumps to errors (use :cn :cN to navigate).  See au
" commands for C++ files.  Warning: can't undo after make returns (may not be
" worth using).
"""set makeprg=make
set makeprg=gcc\ -Wall\ %
"""set makeprg=gcc\ -mno-cygwin\ -Wall\ %
"""set makeprg=gcc\ -Wall\ %\ -lmenu\ -lncurses


"                               23 language specific {{{2

" Eliminated default '%' to enable SAS macro gf functionality
set isfname=@,48-57,/,.,-,_,+,,,#,$,~,=

"                               24 multi-byte characters {{{2


"                               25 various {{{2

" Comments default to:  sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set comments=sr:/*,mb:*,el:*/,://,b:#,b:\',b:\"

" For :au BufWinLeave * mkview
set viewoptions=folds

" For :mksession
set sessionoptions=curdir,folds,slash,unix,winsize,winpos,buffers

" 5000 files of marks. 
" 750 lines of registers.
" See 'history' above
" Using the '%' switch is very subtle - if you open vim w/o a filename
" it'll silently put the MRU filelist into the buffer.  So don't use '%'
" because it's confusing as hell with BufExplorer.
" TODO how to resolve VTMP in a SET statement?
" Make sure _viminfo file is ff=unix
"""if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
"""  if has('gui')
"""    set viminfo='5000,\"750,nC:/temp/_viminfo
    "TODO permission error
"""  else
"""    set viminfo='5000,\"750,n/cygdrive/c/temp/_viminfo
"""  endif
"""endif
set viminfo='5000,\"750,:5000

" For :mkview & :loadview.  Force gvim to Cygwin's default.
set viewdir=~/.vim/view


"                               ?? other {{{2
if has('gui')
  set guioptions+=a
  set guioptions+=b
  " scrollbar right
  set guioptions+=r
  set guioptions-=T
  set guioptions-=m
endif

" Use  :set guifont=*  to browse
if hostname() == 'ubuntu'
  """set guifont=Andale\ Mono\ 9
  set guifont=Consolas\ 9
elseif hostname() == 'yoniso'
  """set guifont=Andale\ Mono\ 9
  set guifont=Consolas\ 10
else
  set guifont=Consolas:h8,Andale_Mono:h8,Lucida_Console:h8,Terminal:h8,Courier_new:h8,Courier:h7
endif

" Win32 only.  Unix uses t_ti and t_te
set restorescreen

" Allow e.g. :bro e /todel/testing instead of :bro e \todel\testing
set shellslash


" end Settings-


"--------------------------------------------------------------------------
"   Abbreviations 	{{{1
"
" To get a literal (e.g. HtM) type CTRL-V *after* you finish typing the 
" abbreviation.  Do :ab to view your abbreviations.  Or e.g. view all HTML
" ab's with  :iab H  Do :abclear to remove all.
"--------------------------------------------------------------------------

"""""
" Personal
iab BoB Bob Heckel
iab RoB Robert S. Heckel Jr.
iab EmA b.heckel@gmail.com
iab PhO (919)816-2347

"""""
" Misc
iab AlP ABCDEFGHIJKLMNOPQRSTUVWXYZ
iab MoN January February March April May June July August September October November December
iab MoO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
iab NuM 1234567890123456789012345678901234567890123456789012345678901234567890
iab RuL ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
iab ShE #!/bin/sh

"""""
" Date/Time (see man strftime or date --help.  Some stolen from Sven Guckes):

" Default.  Overridden later in au commands.
" E.g. Created: Tue 02 Mar 1999 11:19:32 (Bob Heckel)
iab YdC Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)

" Default.  Overridden later in au commands.
" E.g. Modified: Tue 02 Mar 1999 11:19:32 (Bob Heckel)
" Can't simply use "%c" because gvim interprets it badly. 
iab YdM Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)

" Default.  Overridden later in au commands.
iab YdA  Adapted: <C-R>=strftime("%c")<CR> (Bob Heckel)

" Short.  ISO-8601 format.  E.g. 2002-07-05
iab YdS <C-R>=strftime("%Y-%m-%d")<CR>

" Glaxo GSK style
iab YdG <C-R>=strftime("%d-%b-%y")<CR>
"""cab YdG <C-R>=strftime("%d-%b-%y")<CR>

"""""
" C
"""iab CsW switch ( c ) {<CR>case 'a':<CR>  puts("it is a");<CR>break;<CR><Left><Left>case 'b'<CR>  puts("it is b");<CR>break;<CR><Left><Left>default:<CR>  puts("neither");<CR><Left><Left><Left><Left>}

"""""
" HTML (also see :TOhtml)
" 'It takes more time working around the annoying pathologies of web authoring
" tools than it takes to just write the thing in html source to begin with.'
" -Anonymous
iab CoN Content-type: text/html
iab HtA <a href="http://example.com">example link</a>
iab HtM <html><CR>  <head><title></title></head><CR><body></body><CR><Left><Left></html>
iab HtJ <script language="JavaScript"><CR><CR></script>
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

"""""
" Mutt
"""iab MuX X-message-flag: Magic 8Ball says "Outlook not so good."  Let me ask about MS Exchange Server...

"""""
" Perl
iab PeC sub new {<CR>  my $class = shift;<CR><CR>my $self = {};<CR>bless($self, $class);<CR><CR>return $self;<CR><BS><BS>}
iab PeD require Data::Dumper; print STDERR "DEBUG: ", Data::Dumper::Dumper( %h ),"\n";
iab PeE open F, '>junk' or die;use Data::Dumper;print F Dumper  ;<Left>
" Use PeD for hash dumping, this for everything else on symbol table
iab PeF open F, '>junkdumpmain'; for $s(sort keys %main::) { local *sym=$main::{$s}; print F "\\$$s is $$s\\n" if defined $sym; print F "\\@$s is @$s\\n" if defined @sym;}
"""iab PeO open FH, 'foo' or die "Error: $0: $!";<CR><CR>while ( <FH> ){<CR>}<Up>
iab PeH foreach my $k ( sort keys %h ) { print "$k=$h{$k}\n"; }
iab PeO open my $read, '<', $file or die "Error: $0: $!";<CR><CR>while ( <$read> ){<CR>}<Up>
iab PeR #!/usr/bin/perl -w<CR><CR>use v5.10;<CR>
iab PeS #!/usr/bin/perl -wT<CR><CR>use strict qw(refs subs vars);<CR># DEBUG<CR>use CGI::Carp qw(fatalsToBrowser);
iab PeW while ( (my $k, my $v) = each %h ) { print "$k=$v\\n"; }

"""""
" SAS
" Date is used as a weak random number generator to avoid collisions
iab SaB %macro bobh<C-R>=strftime("%d%m%y%M%S")<Esc>; /* {{{ */<CR>%mend bobh<C-R>=strftime("%d%m%y%M%S")<Esc>; /* }}} */<Esc>dd
" SAS/(C)onnect
"""iab SaC options ls=max;<CR>%include "&HOME/code/sas/connect_setup.sas";<CR>signon cdcjes2;<CR>%global CHICKENPARM;<CR>%syslput CHICKENPARM=&SYSPARM;<CR>rsubmit;<CR><CR><CR><CR><CR><CR>endrsubmit;<CR>signoff cdcjes2;
iab SaD libname LDEBUG '.';data LDEBUG.t;set _LAST_;if _N_ eq 1 then put 10 * '!!!DEBUG';run;
" (E)lapsed
iab SaE %let START=%sysfunc(time());<CR>%put !!! (&SYSCC) Elapsed minutes: %sysevalf((%sysfunc(time())-&START)/60);
iab SaL options ls=180 ps=max; libname l '.';
iab SaO filename F 'junk'; data t(rename=(PRODDESC=nm APRCLASS=class)); infile F truncover; input PRODDESC= $100. APRCLASS= $100.; run;
iab SaP <Esc>0iproc print data=_LAST_(obs=max) width=minimum; run;
"""iab SaQ <Esc>0ititle '!!!wtf';proc print data=_LAST_(where=(mfg_batch=:'1')) width=minimum; run;
" Debug Log inline, best:
iab SaQ options ls=max;<Esc>0idata _NULL_; set _LAST_(obs=100 where=(mrp_batch_id in:('4XP'))); put '!!!wtf '(_all_)(=);run;
iab SaS select ( myvar );<CR><Space><Space>when ( 42 ) delete;<CR><Space><Space>otherwise;<CR><Left><Left>end;

"""""
" Visual Basic
"""iab VbF For i = LBound(myarray) To UBound(myarray)<CR>  <CR><BS><BS>Next i
"""iab VbI If i <> 0 Then<CR><CR>  <CR><BS><BS>End If
"""iab VbS Select Case iFoo<CR>  Case Is = 1<CR>    MsgBox "OK"<CR>  Case Else<CR>    MsgBox "Error"<CR>End Select

" Forced syntax:
" E.g. automation.bat is a Perl script wrapped in a .bat 
"""cab SyB syntax off \| source $VIMRUNTIME/syntax/dosbatch.vim
" E.g. session.cmd is a Perl script wrapped in a .cmd 
"""cab SyC syntax off \| source $VIMRUNTIME/syntax/cterm.vim
" config.dat
"""cab SyD syntax off \| source $VIMRUNTIME/syntax/dosini.vim
cab Sy0 source $VIMRUNTIME/syntax/nosyntax.vim
cab SyH source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/html.vim
cab SyJ source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/javascript.vim
cab SyL source $VIMRUNTIME/syntax/nosyntax.vim \| source $HOME/code/sas/saslog.vim
" Powershell
cab SyP source $HOME/code/misccode/ps1.vim
cab SyQ source $VIMRUNTIME/syntax/nosyntax.vim \| source $VIMRUNTIME/syntax/sql.vim 
cab SyS source $VIMRUNTIME/syntax/nosyntax.vim \| source $HOME/code/sas/sas.vim
" Mine is better.
cab SyV source $VIMRUNTIME/syntax/nosyntax.vim \| source $HOME/code/vb/vb.vim


" end Abbreviations-


"--------------------------------------------------------------------------
"   Mappings 	{{{1  
"
" Must come after Settings for <> notation.
"--------------------------------------------------------------------------

map <C-S> :w

" Highlight last paste.  Think [g]et [p]aste.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Open a window for the file under cursor.  Think [g]etfile [w]indow.
noremap gw <Esc>:sp<CR>gf

" Easily navigate wrapped '^...' long lines with arrow keys
noremap <Up> gk
noremap <Down> gj

" Quickfix output navigation
noremap <F1> :cnext<CR>
noremap <F2> :cprevious<CR>

noremap <F3> :silent 1,$!xmllint --format --recover - 2>/dev/null

" Widen gvim to max column width
if has('gui')
  map <F4> :call SetOpt('columns', MaxLineLen(0))<CR>
  map <F4><F4> :call SetOpt('columns', 80)<CR>
endif

map <F6> :se guifont=Consolas:h6<CR>z.
map <F7> :se guifont=Consolas:h7<CR>z.
map <F8> :se guifont=Consolas:h8<CR>z.
" normal size
map <F9> :se guifont=Consolas:h9<CR>z.
map <F10> :se guifont=Consolas:h10<CR>z.
" TODO for win32 gui
"""noremap <C-ScrollWheelUp> :set guifont=Consolas:h15

if has('win32')
  " Minimize gvim (like alt-spacebar-n) to taskbar
  """map <F2> :simalt ~n<CR>
  " Maximize gvim
  map <F11> :simalt ~x<CR>
  " Restore gvim
  map <F11><F11> :simalt ~r<CR>
endif

map <F12> :q<CR>  

" Filter SAS Log for error-like lines (and lines that should be errors) only
noremap <silent> <F8> :g!/^ERROR: \\|^ERROR\\s\\+\\d\\+-\\d\\+:\\|^WARNING: [^Compression]\\|stopped processing this step because\\|lines were truncated\\|NOTE: Invalid data for\\|NOTE: Variable\\|NOTE\\s\\+\\d\\+-\\d\\+:\\|WARNING: Apparent/d<CR> 

if has('win32')
  " Avoid mswin.vim forcing Ctrl-v act as paste, etc.
  noremap <C-V> <C-Q>
  noremap <C-A> <C-A>
endif

""""""""""""""""""""""""""
" Begin ',' comma mapping
""""""""""""""""""""""""""

" Greenbar highlight every other line.  Also see HighlightCurrentLine()
noremap ,<Tab> :set hls<CR>/\\n.*\\n/<CR>

" Pad current line's parameters with spaces e.g if(foo) { ...   to  if ( foo ) { ...      
noremap ,0 :s# \*(\\([^ ].*[^ ]\\))# ( \\1 )#<CR>

" Mnemonic remove '3 stars':
noremap ,3 :s:\\/\\*\\*\\*\\\|\\*\\*\\*\\/::g<CR>:se nohls<CR>

" Single quote a word
noremap ,, :let @z=substitute(expand("<cword>"),".*","'&'","g")<CR>ciw<C-R>z<ESC>

" Double quote a word
noremap ,. :let @z=substitute(expand('<cword>'),'.*','\"&\"','g')<CR>ciw<C-R>z<ESC>

" Must keep space between a and <ESC>
noremap ,a a <ESC>

" Use for simple window jumping & maximizing (think [b]ig [b]uffer and my ;b
" z66-like map).  Works to cycle through horizontal AND vertical split
" windows.  Also see noremap zz to cycle windows without maximizing.
noremap ,b <C-W>w<C-W>_

" Quick (c)o(p)y entire file to clipboard and exit:
"""if has('win32unix')
"""	noremap ,cp :%!putclip<CR><CR>u<CR>:q
"""elseif has('unix')
"""	noremap ,cp :%!xclip<CR>:q<CR>
"""elseif has('gui_running')
"""  noremap ,cp mzggVG<Esc>`z
"""endif

" Edit another file in the same directory as the current file that you navigated to (without having to change pwd via cd %:h):
if has('unix')
  map ,d :e <C-R>=expand("%:p:h") . "/" <CR>
else
  map ,d :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Toggle between two buffers (e fails if 2+ files are opened together and have never used :n)
noremap ,e :e#<CR>
  
" Re(f)low paragraph to current textwidth.  See ;f to go the opposite way - reformat to tw=0
noremap ,f vipgq

" Split window and open file under cursor.  Usually used to view query results
" within b(g)rep (which is why it also jumps to the last search register '/' as
" defined by bgrep)
noremap ,g <C-W>f :set winheight=9999<CR>/<C-R>/<CR>

" Copy w(h)ole buffer to Clipboard
if has('win32unix')
  map ,h :%!putclip<CR><Esc>u
elseif has('unix')
  map ,h :%!xclip<CR>
elseif has('gui_running')
  map ,h mz<ESC>ggvG"*Y`z
endif

" Quickly insert a space.  Must keep space between i and <ESC>.
noremap ,i i <ESC>

" (L)owercase a word
noremap ,l mzviwu\|:echon '.vimrc: word lowercased'<CR>`z

" Comment out and yank/paste current line.  Default (may be overridden below, see au commands).  TODO use FileType instead of *.foo in au commands below
noremap ,m yy0I***<ESC>p

" Deprecated, see gn:
noremap ,n :bn<CR>

" ,p is an autocmd

noremap ,qq :q!<CR>

" Quick search template:
noremap ,s :%s::g<Left><Left>

" (T)oggle this prior to pasting:
noremap ,t :set invpaste<CR>\|:se paste?<CR>

" Uppercase a word (see also ;u) and stay on the same character
noremap ,u mzviwU\|:echon '.vimrc: word uppercased'<CR>`z

noremap ,w :call WrapToggle()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin ';' semicolon mapping 
" (RSI warning: don't use uppercase, leave those contortions for emacs)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO how to do > 1 line in file?
"""noremap ;<Tab> :syn match BoldWholeLine /.*\\%#.*/<CR>
" TODO doesn't unset
"""noremap ;<Tab><Tab> :syn match BoldWholeLine "NONE"<CR>

" Comment out (using the most common comment style '###' for suffix-less files).
" This default may be overridden by au commands below.
noremap ;; :call setline('.', Commentout(getline('.'), 'default'))<CR>

" Uncomment, de-comment out my current line triplet convention (where Commentout function isn't aware of comment type)
"""noremap ;/ my^3x<ESC>`yhhh

" Very useful with Vimium
if has('unix')
  map ;0 <ESC>:!/usr/bin/google-chrome 'https://google.com/search?q=<C-R>=Websearch()<CR>'<CR><CR>
endif

" Quick save as /cygdrive/c/temp/1 etc.
noremap ;1 :%call WriteToFile(VTMP, 1, 0)<CR>
noremap ;2 :%call WriteToFile(VTMP, 2, 0)<CR>
noremap ;3 :%call WriteToFile(VTMP, 3, 0)<CR>
noremap ;4 :%call WriteToFile(VTMP, 4, 0)<CR>

" Checkpoint current file
noremap ;5 :call BkupFile(VTMP)<CR>

" Maximize window.  Alternative to z99.  <C-W>_ makes my hands hurt just
" looking at the chording.  Same as map ,b without the jumping.  Mnemoic [b]ig
" buffer.  Also see noremap zz for cycling windows.
noremap ;b <C-W>_

noremap ;c 0Di#  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>

" Change (d)irectory to where the open file resides
noremap ;d :call CDtoThisFilesLoc()<CR>

" Check for SAS Log errors (SAS' .log only so might want to au command it if
" we run out of free semicolon maps)
"""noremap ;e :set hls<CR> /\\C^ERROR:\\\|NOTE: SYSCC: [123456789]\\\|stopped processing this step because/<CR>
noremap ;e /\\C^ERROR:\\|NOTE: SYSCC: [123456789]\\|stopped processing this step because/<CR>

" (F)latten paragraph to single line - prepare text for paste into an input
" box, etc.  See ,f to wrap to current tw.  Overridden for SAS Log
noremap ;f mfvipJ`f
" For (F)irefox add-on (f)ormatting.  Uses ,w map.
noremap ;ff mfvipJ`f<Esc>,w

" (G)et Clipboard
if has('win32')
  :map ;g "*p<ESC> 
elseif has('win32unix')
  map ;g :r!/bin/getclip<CR>
else
  map ;g :r!xclip -o<CR>
endif

" Jump to leftside window without chording
noremap ;h <C-W>h

" Jump to rightside window without chording.  Non-intutitive but ';l' is
" already taken.
noremap ;i <C-W>l

" Jump to lower window without chording
noremap ;j <C-W>j

" Jump to upper window without chording
noremap ;k <C-W>k

" Just use this for now since the problemspace is so messy
noremap ;l :ls<CR>:e#

" Same as  'ab YdM' but replaces existing Modified line first.
noremap ;m 0Di# Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0

" Simplify navigating the output of :makeprg (use :cN to reverse) when using
" Vim as an IDE.
noremap ;n :cn<CR>

if has('win32')
  " TODO how to remove DOS window (even w/shellcmdflag /c)??
  map ;o :silent !explorer /e, . <CR>
elseif has('win32unix')
  " Cygwin
  map ;o :silent !cygstart %:p:h <CR>
endif

" Swap exchange flip two comma-separated items (foo, bar)
noremap ;q viw"zxllciwhhpll"zp

" Transfer/read and write one block of text between vim sessions/terminals:
" This is part 1.  See ;w (or ;a) for part 2.
if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
  nmap ;r :call ReadFromFile(VTMPU, '.vimxfer')<CR>
"""echon VTMPU THISBOX
  " Temporary ugly hack for XP vs. Win7 Cygwin permission battle
"""  nmap ;rx :!chmod 755 $u/temp/.vimxfer
else
  nmap ;r :call ReadFromFile(VTMP, '.vimxfer')<CR>
endif

" Quick 'comment out' for visualized area.  Default, see au commands:
noremap ;s :s/^/###<CR>

" (T)oggle syntax
"""map ;t :if exists("syntax_on") \| syntax off \| else \| syntax on \| endif<CR>

noremap ;t mz<Esc>:se tw=99999<CR>\|:echon '.vimrc: tw set to 99999'<CR>'z
noremap ;tt mz<Esc>:se tw=78<CR>\|:echon '.vimrc: tw set to 78'<CR>'z

" Upload file to mainframe (basename without extension):
"""map ;u :!bfp % 'bqh0.pgm.lib(%:t:r)'<CR>

" Display gvim text as if it were presented on a lightbulb:
noremap ;v :highlight Normal guibg=white guifg=black

" Transfer/read and write one block of text between vim sessions:
"""if BOX==WORKBOX1 || BOX==WORKBOX2 || BOX==WORKBOX3
if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
  nmap ;a :call WriteToFile(VTMPU, '.vimxfer', 1)<CR>
  vmap ;a :call WriteToFile(VTMPU, '.vimxfer', 1)<CR>
  nmap ;w :call WriteToFile(VTMPU, '.vimxfer', 0)<CR>
  vmap ;w :call WriteToFile(VTMPU, '.vimxfer', 0)<CR>
else
  nmap ;a :call WriteToFile(VTMP, '.vimxfer', 1)<CR>
  vmap ;a :call WriteToFile(VTMP, '.vimxfer', 1)<CR>
  nmap ;w :call WriteToFile(VTMP, '.vimxfer', 0)<CR>
  vmap ;w :call WriteToFile(VTMP, '.vimxfer', 0)<CR>
endif

" Typo protection
nmap :W :w

" Toggle ROT13 boss key - scramble entire file against inquiring minds that want to know.
noremap ;x mzggVGg?`z
imap ;x <Esc>mzggVGg?`z

" Default
noremap ;z :echon ";z 'compile' map not implemented for this filetype"<CR>

"                                Pseudo maps 
" (weaknesses - won't accept <CR>, can be accidentally overwritten):
" Mutt on sdf
" Treo pssh width
"""let @t=':se tw=53'
" For mutt mail editing
"""let @6=':se tw=68'
"""let @9=':se tw=0'
" Mostly for Mutt after a region has been highlighted.
"""let @p='!par'
" Strip trailing spaces.
"""let @s=":%:s:\\s*$::g|''"
" For SAS mf code.
"""let @t=':se tw=72'
" Upload.
"""if ( box == 'IPO1')
  """let @u=':!cpsub % '
"""else
  """let @u=":!bfp % 'bqh0.pgm.lib(%:t:r)'"
"""endif

" Resize window with number keypad
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif


"--------------------------------------------------------------------------
"                                noremaps
"
" Often used to redefine a command. Can also be thought of as exchanging 
" the meaning of two keys.
"
" TODO how to write a wrapper? e.g. override :hardcopy to turn off syntax 
" highlighting before printing?
"--------------------------------------------------------------------------
" Jump to the exact position where you left, not to beginning of line
noremap ' `
"""noremap ' `z.

" Hack to fix the stray pixel problem with monospaced fonts under Cygwin rxvt
noremap <Esc><Esc> <C-L>

" End of word fast append
noremap E ea

" Useful for visualize to the very end
noremap G G$

" Don't accidently drop in ex mode
noremap Q :q

" Yank until end of line is orthogonal with with D and C, otherwise it's a yy
noremap Y y$

" The command {number}CTRL-G show the current buffer number.  Prevent a loop in
" the mapping by using "noremap".
noremap <C-G> 2<C-G>

" Like Firefox...
noremap <C-T> :tabnew<CR>
" ...except
au FileType help,HELP :noremap <C-T> <C-T>

noremap <Space> <C-F>

" Speed things up a bit
noremap <C-E> 2<C-E>
noremap <C-Y> 2<C-Y>

" gn is unused in v7.2.  Orthogonal with gt for tab windows
"""noremap gn :bn<CR>

" Use for simple window jumping.  Use C-W for complex jumps.  Normal zz is the
" same as z. so override it here since z. is better.  Also see map ,b and map ;b
noremap zz <C-W>w

" Reformat current paragraph to gq while in insert mode.  HELP still applies
" in command mode (if I haven't remapped it already).
inoremap <F1> <C-L><ESC>gqap{/<C-L><CR>xi

" Normal action, while in insert mode, CTR-E inserts the character below the
" cursor.  This remap prevents that but allows the more useful scrolling up (or
" down).
inoremap  
inoremap  

" Required for using C-I to get a tab (when 'tab as word completion' is in effect)
inoremap <C-I> <C-X><C-I>

" Line completion.  Hides <C-L> so to clear the screen use our <Esc><Esc> mapping
inoremap <C-L> <C-X><C-L>

" Filesystem completion.  Hides an unused <C-F>.
inoremap <C-F> <C-X><C-F>

" Dictionary completion
inoremap <C-K> <C-X><C-K>

" Remap <TAB> for smart completion on various characters
"""inoremap <silent> <TAB> <C-R>=SmartComplete()<CR>

" Tab completion.  Find (p)revious completions.  See set complete.
inoremap <silent> <TAB> <C-P>

" Without the spaces, other macros get fsckd
inoremap (<Space><Space> ()<Left>
inoremap [<Space><Space> []<Left>
inoremap {<Space><Space> {}<Left>

"""cmap vvv noautocmd vimgrep // **/*.*<Left><Left><Left><Left><Left><Left><Left><Left>
"""cmap vvv vimgrep // **/*.*<Left><Left><Left><Left><Left><Left><Left><Left>
cmap vvv vimgrep // **/*.*<C-F>$Bhhi
"""cmap vvs vimgrep // **/*.sas<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
cmap vvs vimgrep //g **/*.sas<C-F>$Bhhhi
" Hacked up bufgrep since vimgrep searches all files and no builtin exists as of 2010-01-20 
cmap bbb exe 'vimgrep // '.join(BuffersList(),' ')<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Increment / sequence / (a)dd a visualized column.  Cursor on number to 
" start from.  C-V C-A.  To do more complicated things like increase by 100 use
" :'<,'>Inc(100)
vnoremap <C-A> :Inc<CR>

" Sum a column of digits.  Think (p)lus.  Assumes bc(1) exists.
vnoremap <C-P> "ey:call CalcBC()<CR>

" gvim - don't use, need right click for Paste on Linux (where there are multiple clipboards).
"""nnoremap <RightMouse> <Insert>
"""inoremap <RightMouse> <ESC>

" end Mappings-

"--------------------------------------------------------------------------
"   Commands 	{{{1  
"--------------------------------------------------------------------------

" Normal spawn of elinks will kill `blink` so we do this instead.
"""command Html :!lynx -dump "%" | less
command! Html :!w3m "%"

" Speed quickfixing.
command! W :write|make

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  From vimrc_example.vim.
" Use :diffupdate to see the diffs made since you ran DiffOrig.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
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

fu! FixStatusLine()  " {{{2
  " Allow status line separators to work in telnet, etc.
  highlight StatusLine term=bold,reverse  cterm=bold,reverse  gui=bold,reverse
  highlight StatusLineNC term=reverse  cterm=reverse  gui=reverse
endfu
" :call FixStatusLine() or  :Fix 
command! -nargs=0 Fix call FixStatusLine()  " }}}


fu! CalcBC()   " {{{2
  " Highlight a calculation that has a trailing '=' and this will fill in the
  " answer or echo the result if no '='.  Requires that bc(1) is available on
  " the box.  See vnoremap ;B or vnoremap <C-B> to call.
  "
  " NOTE: This fn assumes that buffer 'e' holds the numbers to be summed!! (see <C-b>
  " mapping).
  "
  " NOTE: This fn assumes bc(1) is on your path - may have to add ~/bin depending 
  " on which version of Cygwin is running.
  let has_equal = 0

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


fu! HelpPager(onoff)  " {{{2
  " Use pager-like behavior on the Vim Help files.  See au commands.
  " Check if app has already been loaded or "compatible" mode is set.
  if exists("loaded_HelpPager") || &cp
    finish
  endif

  echohl WarningMsg 
  echon $HOME"/.vimrc's HelpPager is " . a:onoff

  if a:onoff == 'on'
    nmap <unique> b <C-B>
    set timeoutlen=0
    nmap <unique> g 1G
    nmap <unique> j <C-E>
    nmap <unique> k <C-Y>
    nmap <unique> q :q<CR>
    set tw=78
    set wrap
  elseif a:onoff == 'off'
    nunmap b
    set timeoutlen=300
    nunmap g
    nunmap j
    nunmap k
    nunmap q
    set nowrap
  endif
endfu  " }}}


fu! CDtoThisFilesLoc()  " {{{2
  " This changes Vim to the pwd (not the OS to the pwd)
  " TODO how to keep spaces in name from freaking this out?
  let _dir = expand("%:p:h")
  exec "cd " . _dir
  unlet _dir
endfu  " }}}


fu! Foldsearch(search)  " {{{2
  " TODO describe wtf this does
  " E.g. :Fs ^sub                            to get all Perl subs folded
  " E.g. :Fs public\|protected\|private      to get API info in Java
  normal zE          " erase all folds to begin with TODO how to avoid??
  normal G$          " move to the end of the file
	let folded = 0     " flag to set when a fold is found
  let flags = "w"    " allow wrapping in the search
  let line1 =  0     " set marker for beginning of fold
  while search(a:search, flags) > 0
    let  line2 = line(".")
		" echo "pattern found at line # " line2
    if (line2 -1 > line1)
      " echo line1 . ":" . (line2-1)
      " echo "A fold goes here."
      execute ":" . line1 . "," . (line2-1) . "fold"
			let folded = 1       " at least one fold has been found
    endif
    let line1 = line2     " update marker
    let flags = "W"       " turn off wrapping
  endwhile
	" Now create the last fold which goes to the end of the file.
  normal $G
  let  line2 = line(".")
	" echo "end of file found at line # " line2
  if (line2  > line1 && folded == 1)
    " echo line1 . ":" . line2
    " echo "A fold goes here."
    execute ":". line1 . "," . line2 . "fold"
  endif
endfu
" View the methods and variables in a java source file:
"""command! Japi Fs public\|protected\|private
command! -nargs=+ -complete=command Fs call Foldsearch(<q-args>)  " }}}


fu! MaxLineLen(printmaxlen)  " {{{2
  " This may be simpler:
  " echo max(map(range(1, line('$')), "virtcol([v:val, '$'])")
  "
  " Determine the longest line of a file
  " E.g. :call MaxLineLen(1) 
  "      :Maxl
  let s:n=a:printmaxlen
  let s:m=0

  " Don't count all lines in case of huge files
  """for s:l in readfile('externalfile.txt', '', 5000)
  for s:l in getline(1, 50000)
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


fu! SetOpt(opt, val)  " {{{2
  let s:opt = a:opt
  let s:val = a:val

  execute("set " . s:opt . "=" . s:val)
endfu  " }}}


fu! BkupFile(vtpth)  " {{{2
  " Quickly timestamp a backup copy.  Inserts stamp before the rightmost
  " extension.  Usually mapped to ;5
  " TODO elim e.g. x:/ etc if remote file
  " No path and no extension info.  See :h cmdline-special
  let s:head = expand("%:t:r")
  """echo 'head ' . s:head
  let s:tail = expand("%:e")
  """echo 'tail ' . s:tail
  " Make it unique by the second
  let s:stamp = strftime("__%d%b%y_%H.%M.%S__")

  if len(s:tail) > 0
    let s:all = s:head .'.'  . s:stamp . '.' . s:tail
    """echo 'all ' . s:all
  else
    " Suffix-less file
    let s:all = s:head .'.'  . s:stamp 
  endif

  exec("write! " . a:vtpth . "/" . s:all)
endfu  " }}}


fu! Commadelim()   " {{{2
  " Assumes we'll highlight rows to be modified:
  " :'<,'>call Commadelim()
   
  " Automatically loops lines
  let e = a:lastline
  let l = getline('.')
  let m = substitute(l, "^", "'", "g")
  let curr = line('.')

  if curr == e
    " Don't do anything on the last line
    let n = substitute(m, "$", "'", "g")
  else
    let n = substitute(m, "$", "',", "g")
  endif

  call setline('.', n)
endfu  " }}}


fu! DiffWithFileFromDisk()  " {{{2
  let fnm = expand('%')
  let diffnm = fnm . '.fileFromBuffer'
  exec 'saveas! ' . diffnm
  diffthis
  vsplit
  exec 'edit ' . fnm
  diffthis
  " TODO delete foo.fileFromBuffer
endfu  " }}}


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


fu! BuffersList()  " {{{2
  " From StackOverflow
  let all = range(0, bufnr('$'))
  let res = []
  for b in all
    if buflisted(b)
      call add(res, bufname(b))
    endif
  endfor
  return res
endfunction
" See bbb map or run manually e.g.:
""":exe 'vimgrep/pattern/ '.join(BuffersList(),' ')
" }}}


fu! ReadFromFile(vtpth, fnm)  " {{{2
  let fqfn = a:vtpth . '/' . a:fnm
  exec("read " . fqfn)
endfu
" }}}


fu! WriteToFile(vtpth, fnm, append, ...) range  " {{{2
  let lfirst = a:firstline
  let llast = a:lastline

  if (a:append == 1)
    " ;a map
    exec(lfirst . ',' . llast . " write! >> " . a:vtpth . "/" . a:fnm)
  else
    " ;w map
    exec(lfirst . ',' . llast . " write! " . a:vtpth . "/" . a:fnm)
  endif

  " Variable args processing for message to be cut 'n' pasted
  let i = 1
  while i <= a:0
    echo a:{i}
    let i = i+1
  endwhile
endfu
" }}}


fu! Commentout(line, lang)  " {{{2
"                                                   ___ not necessarily vim filetype, refers to my tags below!
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
    if !match(line, '^<')
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
    if lang == 'default'
      echon '.vimrc: unknown language: (' lang ') so using default Commentout style'
    endif
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
"""echo oldline
    let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
"""echo newline
    call setline(linenum, newline)
  endfor
endfu
"""nmap <silent>  ;=  :call AlignAssignments()<CR>
" }}}


" Table of completion specifications (a list of lists)...   {{{2
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
  " Adapted from http://hartley.io
  " Depends on noremap to determine browser and search engine
  call inputsave()
  let searchterm = input('search: ')
  call inputrestore()
  return searchterm
endfu
" }}}


fu! WrapToggle()  " {{{2
  if &textwidth == 0
    setlocal textwidth=78
    setlocal linebreak
    setlocal wrap
    map j gj
    map k gk
  else
    setlocal textwidth=0
    setlocal nolinebreak
    setlocal nowrap
    unmap j
    unmap k
  endif
endfu
" }}}

" end Functions-


"   Autocommands  {{{1  
"  Begin aucommands 	
"
"  Chain commands with '|'
"  No spaces between comma-delimited file lists!
"--------------------------------------------------------------------------

" Avoid double sourcing
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
 
	" Start a returning session at the line and column of last edited position
	autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

  if has('gui')
    " Maximize SAS Logs upon opening
    au GUIEnter *.log simalt ~x
    " Run SAS on current .sas file:
    " TODO figure out how to use :makeprg (set makeprg=file://c:/Program\ Files/SAS\ Institute/SAS/V8/sas.exe\ -sysin\ % doesnt work 2008-09-04)
    " gvim knows nothing about SAS
    au BufNewFile,BufRead,BufEnter *.sas nmap ;z :!c:/Progra~1/SASIns~1/SAS/V8/sas.exe -sysin %<CR>:args %:r.lst %:r.log<CR>
  else
"""    au BufReadPre,FileReadPre *.log set noswapfile | set hlsearch | source $HOME/code/sas/saslog.vim 
    " Run my exec SAS shell script on Cygwin
    au BufNewFile,BufRead,BufEnter *.sas nmap ;z :!~/code/sas/sasrun %<CR>
  endif

  " Handle my ~/bin/sasrun script files
  au BufRead tmpsas.*.log,tmpsas.*.lst map <F12> :qa<CR>
  au BufRead tmpsas.*.log,tmpsas.*.lst map q :qa<CR>
  au BufRead tmpsas.*.log,tmpsas.*.lst echo '.vimrc: q or <F12> to exit all'
  au BufRead tmpsas.*.log,tmpsas.*.lst source $HOME/code/sas/saslog.vim | set noswapfile

  au BufNewFile,BufRead,BufEnter *.sas map ;; :call setline('.', Commentout(getline('.'), 'sas'))<CR>
  au BufNewFile,BufRead,BufEnter *.sas map ;c 0Di  *  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.sas map ;m 0Di  * Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.sas map ,m yy0I***<ESC>p
  " Define pairs to allow the 'bounce on %' plugin to work.  Case insensitive.
  au BufNewFile,BufRead,BufEnter *.sas let s:SASnotend = '\%(\<end\s\+\)\@<!'
  " No spaces between pairs!
  au BufNewFile,BufRead,BufEnter *.sas let b:match_words = s:SASnotend . '\<do\>:\<end\>,\<data\s\+\w\+:\<run\;,%macro.*\;:\<mend\>.*\;,\<proc sql:\<quit;'

  " TOGGLE. Delete the yearly warning lines that appear when SAS License is about to expire
  """au BufRead *.log :g/^WARNING: The Base Product\|installation repres/d
  """au BufRead *.log :g/^WARNING: Your system is scheduled to expire on/d
  """au BufRead *.log :g/Please contact your SAS/d
  """au BufRead *.log :g/information.  The SAS System will no longer function on or after that/d
  """au BufRead *.log :g/representative to have it renewed/d

  " Perl
  au BufNewFile,BufRead,BufEnter *.pl nmap ,p :!perl -c %<CR>
  au BufNewFile,BufRead,BufEnter *.pl nmap ;z :!echo && echo && perl %<CR>
  " Alternate help files via 'K'.  Default s/b set above as keywordprg=man
  au BufNewFile,BufRead,BufEnter *.p[lm] set keywordprg=perldoc\ -f

  au BufNewFile,BufRead,BufEnter *.pl map ,3 :s:^###::g<CR>:se nohls<CR>
  if has ('unix') && version > 599
    au BufWritePost *.pl silent !chmod a+x <afile>
  endif
  au BufNewFile,BufRead,BufEnter *.pl,*.pm map ;; :call setline('.', Commentout(getline('.'), 'perl'))<CR>
  " end Perl


  au BufNewFile,BufRead,BufEnter *.bas syntax off|source ~/code/vb/vb.vim
  au BufLeave *.bas syntax on  " prevent others syntax colored files from remaining with syntax off
  au BufLeave *.ps1 syntax on  " prevent others syntax colored files from remaining with syntax off
  au BufNewFile,BufRead,BufEnter *.sh set fileformat=unix
  " Comment-out a line
  au FileType basic map ;; :call setline('.', Commentout(getline('.'), 'vb'))<CR>
  au FileType basic map ;c 0Di'  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au FileType basic map ;m 0Di' Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au FileType basic map ,m yy0I'''<ESC>p
  au FileType basic map ;s :s:^:''':<CR>
  au FileType aspvbs map ;; mz0I'''<ESC>`zlll
  au FileType dosbatch map ;; mz0I:::<ESC>`zlll
  au FileType dosbatch map ;c 0Di::  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.bat map ;m 0Di:: Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.bat map ,m yy0I:::<ESC>p
  au BufNewFile,BufRead,BufEnter *.bat map ;s /s/^/:::/<CR>
  au BufNewFile,BufRead,BufEnter *.bat  map ;; :call setline('.', Commentout(getline('.'), 'bat'))<CR>
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ;; :call setline('.', Commentout(getline('.'), 'cpp'))<CR>
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ;c 0Di//  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ;m 0Di// Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.h map ,m yy0I///<ESC>p
  au FileType sh map ;; mz0I###<ESC>`zlll
  " Default Vim make is for C, this handles C++
  au BufNewFile,BufRead,BufEnter *.cpp set makeprg=g++\ -Wall\ %
  au BufNewFile,BufRead,BufEnter *.c nmap ;z :!gcc %<CR>\|:echon 'compiled a.exe via ;z map'<CR>
  au FileType javascript map ;; :call setline('.', Commentout(getline('.'), 'cpp'))<CR>
  au BufNewFile,BufRead,BufEnter *.htm* map ;c 0Di//  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.htm* map ;m 0Di// Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter *.htm* map ,m yy0I///<ESC>p
  au BufNewFile,BufRead,BufEnter *.htm* map ;z  :!w3m %<CR>
  au BufNewFile,BufRead,BufEnter *.asp,*.bas let s:VBnotend = '\%(\<end\s\+\)\@<!'
  au BufNewFile,BufRead,BufEnter *.asp,*.bas let b:match_words = s:VBnotend . '\<if\>:\<end\s\+if\>'
  " Automatically flow text (good for composing email)
  au BufReadPre,FileReadPre      *.email set formatoptions=a
  if has ('unix') && version > 599
    au BufWritePost *.sh silent !chmod a+x <afile>
  endif

  " If stock syntax file doesn't exist or we don't have custom in ~/.vim/syntax:
  au BufNewFile,BufRead,BufEnter *vimperatorrc* source ~/code/misccode/vimperator.vim

	" My ~/code/perl/bgrep searching code
  au BufNewFile,BufEnter */tmp/*.grep source ~/code/misccode/bgrep.vim
  au BufNewFile,BufEnter */tmp/*.grep map <CR> <C-W>f :set winheight=9999<CR>/<C-R>/<CR>
  au BufNewFile,BufEnter */tmp/*.grep map q :q<CR>
  au BufNewFile,BufEnter */tmp/*.grep echon '.vimrc: <CR> to select file, q to quit'
  au BufEnter */tmp/*.grep set hlsearch 

  " Don't wrap these                           bash fc temp files
  au BufRead,BufEnter *.htm*,*.asp,*.cgi,*.sql,*/tmp/bash*,afiedt.buf set tw=0 wm=0

  " See  set cinwords  above.
"""  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.pl,*.pm,*.sas set smartindent
  " Fix not-so-smartindent comment outdenting:  TODO ignored, can't use
  " >> to shift lines starting with '#'
"""  au BufNewFile,BufRead,BufEnter *.c,*.cpp,*.pl,*.pm,*.sas inoremap # X#
  " Remove trailing blank lines so they don't get '>' quoted.
  " TODO need to remove blank > lines instead of blank lines
  """autocmd BufRead mutt-*[0-9],.followup,.article,.letter :1,$!sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba'
  " end ~/bin/bgrep

  " Vim
  " We don't edit files so simplify exit
  au BufEnter $VIMRUNTIME/doc/*.txt noremap q :q<CR>
  au BufLeave $VIMRUNTIME/doc/*.txt unmap q

  " Empty to default to Vim's :h help.
  au BufNewFile,BufRead,BufEnter *.vim,.vimrc,*.htm,*.html,*_vimrc set keywordprg=
  au FileType HELP set keywordprg=

  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;; :call setline('.', Commentout(getline('.'), 'vim'))<CR>
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;c 0Di"  Created: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ;m 0Di" Modified: <C-R>=strftime("%a %d %b %Y %H:%M:%S")<CR> (Bob Heckel)<ESC>0
  au BufNewFile,BufRead,BufEnter .vimrc,_vimrc*,*.vim,_vimperatorrc map ,m yy0I"""<ESC>p
  au BufNewFile,BufRead,BufEnter .bashrc,_bashrc* map ;; :call setline('.', Commentout(getline('.'), 'bash'))<CR>
  au BufNewFile,BufRead,BufEnter *.vim nmap ;z :source %<CR>

  " MS Office
  au BufReadPre *.doc set ro
  au BufReadPre *.doc set hlsearch!
  au BufReadPre *.doc noremap q :q!<CR>
  au BufReadPost *.doc echon '.vimrc: q mapped to :q!'
  " TODO check for existence of antiword, otherwise use cygstart
  au BufReadPost *.doc %!antiword "%"

  " View binaries using xxd
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

  augroup encrypted
    au!
    " TODO have to force this even if orig pre-encrypted file is ff=unix
    " not sure how to handle actual dos fmtd files
    autocmd BufReadPre,FileReadPre      *.gpg set ff=unix
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    au BufReadPre,FileReadPre      *.gpg set viminfo=
    au BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    au BufReadPre,FileReadPre      *.gpg set bin
    au BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    au BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    au BufReadPost,FileReadPost    *.gpg set nobin
    au BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    au BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    au BufWritePre,FileWritePre    *.gpg '[,']!gpg -ca 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    au BufWritePost,FileWritePost    *.gpg u
  augroup END

  " This block must be placed near end of au commands for syntax coloring to
  " be disabled.
  if &diff
    " Don't interfere with diff's syntax
    au BufNewFile,BufRead,BufEnter * syntax off
    " Always maximize gvim when using vimdiff
    au GUIEnter * simalt ~x
    """set guifont=Andale_Mono:h7
    set guifont=Consolas:h7
  endif

  " Quickfix
  """ TODO need something like this to keep q from flowing to existing buffers after leaving QF: au BufLeave QF unmap q
  """au FileType QF map q :q!<CR>
  """au FileType QF echon '.vimrc: q to :q! this :cw'

  """au BufRead *.xml set foldmethod=indent | set list
"""  au BufRead *.xml map <F3> :silent 1,$!xmllint --format --recover - 2>/dev/null

  au BufEnter oneliners,.vimrc,_vimrc,.bashrc,_bashrc set foldmethod=marker
  au BufEnter .vimrc echo ".vimrc: $MYVIMRC:" $MYVIMRC

  au BufNewFile,BufRead,BufEnter *.html,*.htm map ;; :call setline('.', Commentout(getline('.'), 'html'))<CR>

  " We'll probably never need to edit a tarball:
  au FileType TAR map q :q<CR>

  " Act like gvim when a file was changed behind your back:
  au WinEnter * checktime

  " Always edit git commit messages at 1L,1C
  au FileType GITCOMMIT :1

  " Without this, NetRW loses its place when returning to the tree (use buffer n because mz is taken by netrw):
	au BufLeave NetrwTreeListing mn
	au BufEnter NetrwTreeListing `n
	" I'm usually only browsing with netrw:
	"""	au FileType NETRW map q :q<CR>
	" Use these to avoid timeouts on lowercase m calls
	"""au FileType NETRW noremap mmf call <SNR>18_NetrwMarkFile(1,<SNR>18_NetrwGetWord())<CR>
	"""au FileType NETRW noremap mmu call <SNR>18_NetrwUnMarkFile(1)<CR>
	"""au FileType NETRW noremap mmt call <SNR>18_NetrwMarkFileTgt(1)<CR>
	"""au FileType NETRW noremap mmc call <SNR>18_NetrwMarkFileCopy(1)<CR>

  "_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
  "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
  "
	" TODO move to ~/.vimrc.project
  " Temporary project-specific hacks to normalize messy problem-spaces:

  if matchstr(WORKBOXARRAY, THISBOX) == THISBOX
    au BufRead LimsGistTableCount.txt :se list
    au GUIEnter oracle_queries.sql,update.sql winpos 37 55 | se lines=20 | se columns=170 | se wrap | map j gj
    " SQL*Plus hack to get table/field name completion
    au BufRead afiedt.buf winpos 37 55 | se lines=20 | se columns=170 | se tw=999999 | :new | silent :args $HOME/code/misccode/spool/links/*.LST | :hide | map :wq :wq! | noremap ZZ :wq!<CR>
    """au VimLeavePre afiedt.buf execute "w ~/tmp/afiedt.buf." . strftime("%m_%d-%H_%M_%S")

    "Activate via <C-X><C-O>
    """autocmd FileType * set omnifunc=syntaxcomplete#Complete
    au BufRead DataPost_Configuration.xml set foldmethod=indent | set foldlevel=1

    " Platform warning indicators:
    " Gvim
    au BufRead,BufWinEnter X:/*             hi StatusLine   guifg=Green guibg=Black gui=inverse,bold
    au BufRead,BufWinLeave X:/*             hi StatusLineNC guifg=Green guibg=Gray gui=inverse,bold
    au BufRead,BufWinEnter Y:/*             hi StatusLine   guifg=Yellow guibg=Black gui=inverse,bold
    au BufRead,BufWinLeave Y:/*             hi StatusLineNC guifg=Yellow guibg=Gray gui=inverse,bold
    au BufRead,BufWinEnter Z:/*             hi StatusLine   guifg=Red guibg=Black gui=inverse,bold
    au BufRead,BufWinLeave Z:/*             hi StatusLineNC guifg=Red guibg=Gray gui=inverse,bold
    " Cygwin
    au BufRead,BufWinEnter /cygdrive/c/*    hi StatusLine   ctermfg=Blue ctermbg=White
    au BufRead,BufWinLeave /cygdrive/c/*    hi StatusLineNC ctermfg=Blue ctermbg=Gray gui=inverse,bold
    au BufRead,BufWinEnter /cygdrive/x/*    hi StatusLine   ctermfg=Green ctermbg=Black 
    au BufRead,BufWinLeave /cygdrive/x/*    hi StatusLineNC ctermfg=Green ctermbg=Gray gui=inverse,bold
    au BufRead,BufWinEnter /cygdrive/y/*    hi StatusLine   ctermfg=Yellow ctermbg=Black
    au BufRead,BufWinLeave /cygdrive/y/*    hi StatusLineNC ctermfg=Yellow ctermbg=Gray gui=inverse,bold
    au BufRead,BufWinEnter /cygdrive/z/*    hi StatusLine   ctermfg=Red ctermbg=Black
    au BufRead,BufWinLeave /cygdrive/z/*    hi StatusLineNC ctermfg=Red ctermbg=Gray gui=inverse,bold

    " 1-Avoid frightening people who don't know what swapfiles are
    " or
    " 2-Creating undeletable files on boxes built by frightened people
    au BufReadPre,FileReadPre [WXYZ]:/* set noswapfile
    au BufReadPre,FileReadPre /cygdrive/[wxyz]/* set noswapfile

    " Do not use The Force on Test & Production
    au BufEnter [YZ]:/DataPost* set readonly
    au BufEnter /cygdrive/[yz]/DataPost* set readonly

    au BufEnter gsk,gsk_check.sh set foldmethod=marker
		au BufNewFile,BufRead,BufEnter DataPost*.log set noswapfile | set hlsearch | source u:/code/sas/saslog.vim 
		au BufRead,BufNewFile *.map set filetype=xslt
  endif

  " end Temporary project-specific
  "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

endif  " ! autocommands_loaded


" end Autocommands-

"--------------------------------------------------------------------------}}}
"  Inlined Plugins  {{{1
" Simple plugins that are easier to store here than ~/.vim/plugin/
" Improve portability (e.g. Cygwin vs gvim problems).  But vimballs are
" probably easier to just install: vi Align.vba.gz then :so %
"
" Has to be located after Autocommands.
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
vmap [% <Esc>[%m'gv``
vmap ]% <Esc>]%m'gv``
" vnoremap <silent> [% :<C-U>call <SID>MultiMatch("bW", "v") <CR>m'gv``
" vnoremap <silent> ]% :<C-U>call <SID>MultiMatch("W",  "v") <CR>m'gv``
onoremap <silent> [% v:<C-U>call <SID>MultiMatch("bW", "o") <CR>
onoremap <silent> ]% v:<C-U>call <SID>MultiMatch("W",  "o") <CR>

" text object:
vmap a% <Esc>[%v]%

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

" 2010-03-04 inlined DirDiff {{{
" LAST MODIFICATION: "Wed, 22 Feb 2006 22:31:59 Central Standard Time"
" VERSION: 1.1.0 (C) 2001-2006 by William Lee, <wl1012@yahoo.com>
"
" TODO how to turn off file's syntax highlight to avoid masking vimdiff's?
" My version is essentially the same as William's 1.1.2 but has my preferred
" syntax and navigation features
" Modified: Mon 15 Jul 2013 12:34:19 (Bob Heckel)

" PURPOSE:
"   - Diffing a directory recursively and enable easy merging, copying and
"   deleting of files and directories.
"
" REQUIREMENTS:
"   - Make sure you have GNU diff in your path on Unix and Windows. I only
"     tested this on cygwin's version on Windows.  If you have a diff that
"     doesn't support -x or -I flag, do not set variable g:DirDiffExcludes and
"     g:DirDiffIgnore to "".  It should still work.
"   - On Windows, you need to have "xcopy", "copy", "del", and "rd" in your
"     path.
"   - On Unix, you need to have "rm" and "cp" in your path.
"
" USAGE:
"   Put this file in your ~/.vim/plugin
" 
"   Doing the following will generate a diff window.
"
"       :DirDiff <A:Src Directory> <B:Src Directory>
"   e.g.
"       :DirDiff ../something/dir1 /usr/bin/somethingelse/dir2
"
"   The following commands can be used inside the diff window:
"   'Enter','o' - Diff open: open the diff file(s) where your cursor is at
"   's' - Synchronize the current diff.  You can also select
"         a range (through visual) and press 's' to synchronize differences
"         across a range.
"
"         - There are 6 Options you can choose when you hit 's':
"           1. A -> B
"              Copy A to overwrite B
"              If A's file actually points to a directory, it'll copy it to B
"              recursively.
"           2. B -> A
"              Copy B to overwrite A
"              If B's file actually points to a directory, it'll copy it to A
"              recursively.
"           3. Always A
"              For the rest of the items that you've selected,
"              synchronize like (1).
"           4. Always B
"              For the rest of the items that you've selected,
"              synchronize like (2).
"           5. Skip
"              Skip this diff entry.
"           6. Cancel
"              Quit the loop and exit.
"
"   'u' - Diff update: update the diff window
"   'x' - Sets the exclude pattern, separated by ','
"   'i' - Sets the ignore pattern, separated by ','
"   'a' - Sets additional arguments for diff, eg. -w to ignore white space,
"         etc.
"   'q' - Quit DirDiff
"    
"   The following comamnds can be used in the Vim diff mode
"   \dg - Diff get: maps to :diffget<CR>
"   \dp - Diff put: maps to :diffput<CR>
"   \dj - Diff next: (think j for down) 
"   \dk - Diff previous: (think k for up)
"
"   You can set the following DirDiff variables.  You can add the following
"   "let" lines in your .vimrc file.
"
"   Sets default exclude pattern:
"       let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp"
"
"   Sets default ignore pattern:
"       let g:DirDiffIgnore = "Id:,Revision:,Date:"
"
"   If DirDiffSort is set to 1, sorts the diff lines.
"       let g:DirDiffSort = 1
"
"   Sets the diff window (bottom window) height (rows)
"       let g:DirDiffWindowSize = 14
"
"   Ignore case during diff
"       let g:DirDiffIgnoreCase = 0
"
"   Dynamically figure out the diff text.  If you are using and i18n version
"   of diff, this will try to get the specific diff text during runtime.  It's
"   turned off by default.  If you are always targetting a specific version of
"   diff, you can turn this off and set the DirDiffText* variables
"   accordingly.
"       let g:DirDiffDynamicDiffText = 0
"
"   String used for the English equivalent "Files "
"       let g:DirDiffTextFiles = "Files "

"   String used for the English equivalent " and "
"       let g:DirDiffTextAnd = " and "
"
"   String used for the English equivalent " differ")
"       let g:DirDiffTextDiffer = " differ"
"
"   String used for the English equivalent "Only in ")
"       let g:DirDiffTextOnlyIn = "Only in "
"
" NOTES:
"   This script can copy and remove your files.  This can be powerful (or too
"   powerful) at times.  Please do not blame me if you use this and
"   disintegrate your hard work.  Be warned!
"
" CREDITS:
"
"   Please mail any comment/suggestion/patch to 
"   William Lee <wl1012@yahoo.com>
"
" LICENSE:
"   Copyright (c) 2001-2006 William Lee
"   All rights reserved.
"
"   Redistribution and use in source and binary forms, with or without
"   modification, are permitted provided that the following conditions are
"   met:
"
"     * Redistributions of source code must retain the above copyright
"       notice, this list of conditions and the following disclaimer.
"     * Redistributions in binary form must reproduce the above copyright
"       notice, this list of conditions and the following disclaimer in the
"       documentation and/or other materials provided with the distribution.
"     * Neither the name William Lee nor the names of its contributors may be
"       used to endorse or promote products derived from this software without
"       specific prior written permission.
"
let loaded_DirDiff = 1

" Public Interface:
command! -nargs=* -complete=dir DirDiff call <SID>DirDiff (<f-args>)
command! -nargs=0 DirDiffOpen call <SID>DirDiffOpen ()
command! -nargs=0 DirDiffNext call <SID>DirDiffNext ()
command! -nargs=0 DirDiffPrev call <SID>DirDiffPrev ()
command! -nargs=0 DirDiffUpdate call <SID>DirDiffUpdate ()
command! -nargs=0 DirDiffQuit call <SID>DirDiffQuit ()

if !hasmapto('<Plug>DirDiffGet')
  map <unique> <Leader>dg <Plug>DirDiffGet
endif
if !hasmapto('<Plug>DirDiffPut')
  map <unique> <Leader>dp <Plug>DirDiffPut
endif
if !hasmapto('<Plug>DirDiffNext')
  map <unique> <Leader>dj <Plug>DirDiffNext
endif
if !hasmapto('<Plug>DirDiffPrev')
  map <unique> <Leader>dk <Plug>DirDiffPrev
endif

" Global Maps:
map <unique> <script> <Plug>DirDiffGet    :diffget<CR>
map <unique> <script> <Plug>DirDiffPut    :diffput<CR>
map <unique> <script> <Plug>DirDiffNext    :call <SID>DirDiffNext()<CR>
map <unique> <script> <Plug>DirDiffPrev    :call <SID>DirDiffPrev()<CR>
map <unique> <script> <Plug>DirDiffQuit    :call <SID>DirDiffQuit()<CR>

" Default Variables.  You can override these in your global variables
" settings.
"
" For DirDiffExcludes and DirDiffIgnore, separate different patterns with a
" ',' (comma and no space!).
"
" eg. in your .vimrc file: let g:DirDiffExcludes = "CVS,*.class,*.o"
"                          let g:DirDiffIgnore = "Id:"
"                          " ignore white space in diff
"                          let g:DirDiffAddArgs = "-w" 
"
" You can set the pattern that diff excludes.  Defaults to the CVS directory
if !exists("g:DirDiffExcludes")
    let g:DirDiffExcludes = ""
endif
" This is the -I argument of the diff, ignore the lines of differences that
" matches the pattern
if !exists("g:DirDiffIgnore")
    let g:DirDiffIgnore = ""
endif
if !exists("g:DirDiffSort")
    let g:DirDiffSort = 1
endif
if !exists("g:DirDiffWindowSize")
    " 2008-09-30 min is 11
    let g:DirDiffWindowSize = 11
endif
if !exists("g:DirDiffInteractive")
    let g:DirDiffInteractive = 0
endif
if !exists("g:DirDiffIgnoreCase")
    let g:DirDiffIgnoreCase = 0
endif
" Additional arguments
if !exists("g:DirDiffAddArgs")
    let g:DirDiffAddArgs = ""
endif
" Support for i18n (dynamically figure out the diff text)
" Defaults to off
if !exists("g:DirDiffDynamicDiffText")
    let g:DirDiffDynamicDiffText = 0
endif

" String used for the English equivalent "Files "
if !exists("g:DirDiffTextFiles")
    let g:DirDiffTextFiles = "Files "
endif

" String used for the English equivalent " and "
if !exists("g:DirDiffTextAnd")
    let g:DirDiffTextAnd = " and "
endif

" String used for the English equivalent " differ")
if !exists("g:DirDiffTextDiffer")
    let g:DirDiffTextDiffer = " differ"
endif

" String used for the English equivalent "Only in ")
if !exists("g:DirDiffTextOnlyIn")
    let g:DirDiffTextOnlyIn = "Only in "
endif

" Set some script specific variables:
let s:DirDiffFirstDiffLine = 5
let s:DirDiffALine = 1
let s:DirDiffBLine = 2

" -- Variables used in various utilities
if has("unix")
    let s:DirDiffCopyCmd = "cp"
    let s:DirDiffCopyFlags = ""
    let s:DirDiffCopyDirCmd = "cp"
    let s:DirDiffCopyDirFlags = "-rf"
    let s:DirDiffCopyInteractiveFlag = "-i"

    let s:DirDiffDeleteCmd = "rm"
    let s:DirDiffDeleteFlags = ""
    let s:DirDiffDeleteInteractiveFlag = "-i"

    let s:DirDiffDeleteDirCmd = "rm"
    let s:DirDiffDeleteDirFlags = "-rf"

    let s:sep = "/"

    let s:DirDiffMakeDirCmd  = "!mkdir "

elseif has("win32")
    let s:DirDiffCopyCmd = "copy"
    let s:DirDiffCopyFlags = ""
    let s:DirDiffCopyDirCmd = "xcopy"
    let s:DirDiffCopyDirFlags = "/e /i /q"
    let s:DirDiffCopyInteractiveFlag = "/-y"

    let s:DirDiffDeleteCmd = "del"
    let s:DirDiffDeleteFlags = "/s /q"
    let s:DirDiffDeleteInteractiveFlag = "/p"
    " Windows is somewhat stupid since "del" can only remove the files, not
    " the directory.  The command "rd" would remove files recursively, but it
    " doesn't really work on a file (!).  where is the deltree command???
     
    let s:DirDiffDeleteDirCmd = "rd"
    " rd is by default prompting, we need to handle this in a different way
    let s:DirDiffDeleteDirFlags = "/s"
    let s:DirDiffDeleteDirQuietFlag = "/q"

    let s:sep = "\\"

    let s:DirDiffMakeDirCmd  = "!mkdir "
else
    " Platforms not supported
    let s:DirDiffCopyCmd = ""
    let s:DirDiffCopyFlags = ""
    let s:DirDiffDeleteCmd = ""
    let s:DirDiffDeleteFlags = ""
    let s:sep = ""
endif


function! <SID>DirDiff(srcA, srcB)
    " 2008-09-30 Bob Heckel ugly hack to minimize syntax and folding mess
    " 'syntax on' often makes diffs invisible
    """syntax off
    " 1st time we go up-up to turn off syntax (e.g. macro call is in red, so is
    " the bgcolor of the diff so it's invisible)
    " If /* vim: ...foldmethod=marker... */ then we have to unfold or fold will hide diffs
    """map <Up><Up> :syntax off<CR><C-W>k0zR<Right><Left>
    """map <Up><Up> :syntax off<CR><C-W>k
    map <Up><Up> :syntax off<CR><C-W>k
    map <Left><Left> :set fdm=diff<CR>
    map <Right><Right> :set fdm=diff<CR>
    map <Up> <C-W>k
    map <Down> <C-W>j
    map <Right> <C-W>l
    map <Left> <C-W>h
    " TODO not working
    """nnoremap <buffer> <F12> :call <SID>DirDiffQuit()<CR>
    map <F12> :qa<CR>  
    map <F1> :echon 's (sync) will prompt to copy file to other side'<CR>

    " Setup
    let DirDiffAbsSrcA = fnamemodify(expand(a:srcA, ":p"), ":p")
    let DirDiffAbsSrcB = fnamemodify(expand(a:srcB, ":p"), ":p")

    " Check for an internationalized version of diff ?
    call <SID>GetDiffStrings()

    " Remove the trailing \ or /
    let DirDiffAbsSrcA = substitute(DirDiffAbsSrcA, '\\$\|/$', '', '')
    let DirDiffAbsSrcB = substitute(DirDiffAbsSrcB, '\\$\|/$', '', '')

    let DiffBuffer = tempname()
    " We first write to that file
    " Constructs the command line
    let cmd = "!diff"
    let cmdarg = " -r --brief"

    " If variable is set, we ignore the case
    if (g:DirDiffIgnoreCase)
        let cmdarg = cmdarg." -i"
    endif
    if (g:DirDiffAddArgs != "")
        let cmdarg = cmdarg." ".g:DirDiffAddArgs." "
    endif
    if (g:DirDiffExcludes != "")
        let cmdarg = cmdarg.' -x"'.substitute(g:DirDiffExcludes, ',', '" -x"', 'g').'"'
    endif
    if (g:DirDiffIgnore != "")
        let cmdarg = cmdarg.' -I"'.substitute(g:DirDiffIgnore, ',', '" -I"', 'g').'"'
    endif
    " Prompt the user for additional arguments
"    let addarg = input("Additional diff args (current =". cmdarg. "): ")
    let addarg = ""
    let cmd = cmd.cmdarg." ".addarg." \"".DirDiffAbsSrcA."\" \"".DirDiffAbsSrcB."\""
    let cmd = cmd." > \"".DiffBuffer."\""

    echo "Diffing directories, it may take a while..."
    let error = <SID>DirDiffExec(cmd, 0)
    if (error == 0)
        echo "There is no diff here."
        return
    endif
    silent exe "edit ".DiffBuffer
    echo "Defining [A] and [B] ... "
    " We then do a substitution on the directory path
    " We need to do substitution of the the LONGER string first, otherwise
    " it'll mix up the A and B directory
    if (strlen(DirDiffAbsSrcA) > strlen(DirDiffAbsSrcB))
	    silent! exe "%s/".<SID>EscapeDirForRegex(DirDiffAbsSrcA)."/[A]/"
	    silent! exe "%s/".<SID>EscapeDirForRegex(DirDiffAbsSrcB)."/[B]/"
    else
	    silent! exe "%s/".<SID>EscapeDirForRegex(DirDiffAbsSrcB)."/[B]/"
	    silent! exe "%s/".<SID>EscapeDirForRegex(DirDiffAbsSrcA)."/[A]/"
    endif
    " In windows, diff behaves somewhat weirdly, for the appened path it'll
    " use "/" instead of "\".  Convert this to \
    if (has("win32"))
        silent! %s/\//\\/g
    endif

    echo "Sorting entries ..."
    " We then sort the lines if the option is set
    if (g:DirDiffSort == 1)
        1,$call <SID>Sort("s:Strcmp")
    endif

    " Put in spacer in front of each line
    silent! %s/^/    /

    " We then put the file [A] and [B] on top of the diff lines
    call append(0, "[A]=". DirDiffAbsSrcA)
    call append(1, "[B]=". DirDiffAbsSrcB)
    """call append(2, "Usage:   <Enter>/'o'=open,'s'=sync,'\\dj'=next,'\\dk'=prev, 'q'=quit")
  " 2008-09-29 use less screen real estate
    """call append(2, "Usage:   <Enter>=open, 's'=sync, 'q'=quit")
    call append(2, "")
    """call append(3, "Options: 'u'=update, 'x'=set excludes, 'i'=set ignore, 'a'=set args" )
    call append(3, "diff(1) args:" . cmdarg)
    call append(4, "")
    """call append(4, "Diff Args:" . cmdarg)
    """call append(5, "")
    " go to the beginning of the file
    0
    setlocal nomodified
    setlocal nomodifiable
    setlocal buftype=nowrite
    setlocal bufhidden=delete
    setlocal nowrap

    " Set up local key bindings
    " 'n' actually messes with the search next pattern, I think using \dj and
    " \dk is enough.  Otherwise, use j,k, and enter.
"    nnoremap <buffer> n :call <SID>DirDiffNext()<CR>
"    nnoremap <buffer> p :call <SID>DirDiffPrev()<CR>

    " 13-Dec-12 avoid messing up edits, only allow these in the bottom navigation window
    " 31-Jan-13 bottom window not always DIFF
    if (&filetype == 'DIFF') || (&filetype == '')
      nnoremap <buffer> s     :. call <SID>DirDiffSync()<CR>
      vnoremap <buffer> s     :call <SID>DirDiffSync()<CR>
      nnoremap <buffer> u     :call <SID>DirDiffUpdate()<CR>
      nnoremap <buffer> x     :call <SID>ChangeExcludes()<CR>
      nnoremap <buffer> a     :call <SID>ChangeArguments()<CR>
      nnoremap <buffer> i     :call <SID>ChangeIgnore()<CR>
      nnoremap <buffer> q     :call <SID>DirDiffQuit()<CR>
      nnoremap <buffer> o     :call <SID>DirDiffOpen()<CR>
      nnoremap <buffer> <CR>  :call <SID>DirDiffOpen()<CR>  
    endif
    " sets up highlight in the lower dirdiff window (only)
    call <SID>SetupSyntax()

    " Open the first diff
    call <SID>DirDiffNext()
    " 13-Dec-12 custom reminders
    echon " <CR>=open,'s'=sync,'u'=update,'x'=set excludes (or disable all current :let g:DirDiffExcludes='') 'a'=set diff(1) args"
endfunction

" Set up syntax highlighing for the diff window
function! <SID>SetupSyntax()
  if has("syntax") && exists("g:syntax_on") 
      "&& !has("syntax_items")
    syn match DirDiffSrcA               "\[A\]"
    syn match DirDiffSrcB               "\[B\]"
    syn match DirDiffUsage              "^Usage.*"
    syn match DirDiffOptions            "^Options.*"
    syn match DirDiffArgs               "^Diff Args.*"
    exec 'syn match DirDiffFiles              "' . s:DirDiffDifferLine .'"'
    exec 'syn match DirDiffOnly               "' . s:DirDiffDiffOnlyLine . '"'
    syn match DirDiffSelected           "^==>.*" contains=DirDiffSrcA,DirDiffSrcB
    hi def link DirDiffSrcA               PreProc
    hi def link DirDiffSrcB               Type
    hi def link DirDiffUsage              Special
    hi def link DirDiffOptions            Special
    hi def link DirDiffArgs               Special
    hi def link DirDiffFiles              String
    hi def link DirDiffOnly               ErrorMsg
    hi def link DirDiffSelected           DiffChange
  endif
endfunction

" You should call this within the diff window
function! <SID>DirDiffUpdate()
    let dirA = <SID>GetBaseDir("A")
    let dirB = <SID>GetBaseDir("B")
    call <SID>DirDiff(dirA, dirB)
endfun

" Quit the DirDiff mode
function! <SID>DirDiffQuit()
  " 2008-07-17  yes i'm sure
    """let in = confirm ("Are you sure you want to quit DirDiff?", "&Yes\n&No", 2)
    """if (in == 1)
        call <SID>CloseDiffWindows()
        bd!
    """endif
endfun

" Returns an escaped version of the path for regex uses
function! <SID>EscapeDirForRegex(path)
    " This list is probably not complete, modify later
    return escape(a:path, "/\\[]$^~")
endfunction

" Close the opened diff comparison windows if they exist
function! <SID>CloseDiffWindows()
    if (<SID>AreDiffWinsOpened())
        wincmd k
        " Ask the user to save if buffer is modified
        call <SID>AskIfModified()
        bd!
        " User may just have one window opened, we may not need to close
        " the second diff window
        if (&diff)
            call <SID>AskIfModified()
            bd!
        endif
    endif
endfunction


function! <SID>DirDiffOpen()
    " First dehighlight the last marked
    call <SID>DeHighlightLine()

    " Mark the current location of the line
    "mark n
    let b:currentDiff = line(".")

    " We first parse back the [A] and [B] directories from the top of the line
    let dirA = <SID>GetBaseDir("A")
    let dirB = <SID>GetBaseDir("B")

    call <SID>CloseDiffWindows()

    let line = getline(".")
    " Parse the line and see whether it's a "Only in" or "Files Differ"
    call <SID>HighlightLine()

    let fileA = <SID>GetFileNameFromLine("A", line)
    " 2008-06-30 Bob Heckel - for filenames with spaces
    let fileA = substitute(fileA, "\\s", "\\\\ ", "g")
    let fileB = <SID>GetFileNameFromLine("B", line)
    " 2008-06-30 Bob Heckel - for filenames with spaces
    let fileB = substitute(fileB, "\\s", "\\\\ ", "g")

    if <SID>IsOnly(line)
        " We open the file
        let fileSrc = <SID>ParseOnlySrc(line)
        if (fileSrc == "A")
            let fileToOpen = fileA
        elseif (fileSrc == "B")
            let fileToOpen = fileB
        endif
        split
        wincmd k
        silent exec "edit ".fileToOpen
        " Fool the window saying that this is diff
        diffthis
        wincmd j
        " Resize the window
        exe("resize " . g:DirDiffWindowSize)
        exe (b:currentDiff)
    elseif <SID>IsDiffer(line)
        "Open the diff windows
        split
        wincmd k
        silent exec "edit ".fileB
        silent exec "vert diffsplit ".fileA
        " Go back to the diff window
        wincmd j
        " Resize the window
        exe("resize " . g:DirDiffWindowSize)
        exe (b:currentDiff)
        " Center the line
        exe ("normal z.")
    else
        echo "There is no diff at the current line!"
    endif
endfunction

" Ask the user to save if the buffer is modified
"
function! <SID>AskIfModified()
    if (&modified)
        let input = confirm("File " . expand("%:p") . " has been modified.", "&Save\nCa&ncel", 1)
        if (input == 1)
            w!
        endif
    endif
endfunction

function! <SID>HighlightLine()
    let savedLine = line(".")
    exe (b:currentDiff)
    setlocal modifiable
    let line = getline(".")
    if (match(line, "^    ") == 0)
        s/^    /==> /
    endif
    setlocal nomodifiable
    setlocal nomodified
    exe (savedLine)
    redraw
endfunction

function! <SID>DeHighlightLine()
    let savedLine = line(".")
    exe (b:currentDiff)
    let line = getline(".")
    setlocal modifiable
    if (match(line, "^==> ") == 0)
        s/^==> /    /
    endif
    setlocal nomodifiable
    setlocal nomodified
    exe (savedLine)
    redraw
endfunction

" Returns the directory for buffer "A" or "B".  You need to be in the diff
" buffer though.
function! <SID>GetBaseDir(diffName)
    let currLine = line(".")
    if (a:diffName == "A")
        let baseLine = s:DirDiffALine
    else
        let baseLine = s:DirDiffBLine
    endif
    let regex = '\['.a:diffName.'\]=\(.*\)'
    let line = getline(baseLine)
    let rtn = substitute(line, regex , '\1', '')
    return rtn
endfunction

function! <SID>DirDiffNext()
    " If the current window is a diff, go down one
    if (&diff == 1)
        wincmd j
    endif
    " if the current line is <= 6, (within the header range), we go to the
    " first diff line open it
    if (line(".") < s:DirDiffFirstDiffLine)
        exe (s:DirDiffFirstDiffLine)
        let b:currentDiff = line(".")
    endif
    silent! exe (b:currentDiff + 1)
    call <SID>DirDiffOpen()
endfunction

function! <SID>DirDiffPrev()
    " If the current window is a diff, go down one
    if (&diff == 1)
        wincmd j
    endif
    silent! exe (b:currentDiff - 1)
    call <SID>DirDiffOpen()
endfunction

" For each line, we can perform a recursive copy or delete to sync up the
" difference. Returns non-zero if the operation is NOT successful, returns 0
" if everything is fine.
"
function! <SID>DirDiffSyncHelper(AB, line)
    let fileA = <SID>GetFileNameFromLine("A", a:line)
    let fileB = <SID>GetFileNameFromLine("B", a:line)
"    echo "Helper line is ". a:line. " fileA " . fileA . " fileB " . fileB
    if <SID>IsOnly(a:line)
        " If a:AB is "A" and the ParseOnlySrc returns "A", that means we need to
        " copy
        let fileSrc = <SID>ParseOnlySrc(a:line)
        let operation = ""
        if (a:AB == "A" && fileSrc == "A")
            let operation = "Copy"
            " Use A, and A has source, thus copy the file from A to B
            let fileFrom = fileA
            let fileTo = fileB
        elseif (a:AB == "A" && fileSrc == "B")
            let operation = "Delete"
            " Use A, but B has source, thus delete the file from B
            let fileFrom = fileB
            let fileTo = fileA
        elseif (a:AB == "B" && fileSrc == "A")
            let operation = "Delete"
            " Use B, but the source file is A, thus removing A
            let fileFrom = fileA
            let fileTo = fileB
        elseif (a:AB == "B" && fileSrc == "B")
            " Use B, and B has the source file, thus copy B to A
            let operation = "Copy"
            let fileFrom = fileB
            let fileTo = fileA
        endif
    elseif <SID>IsDiffer(a:line)
        " Copy no matter what
        let operation = "Copy"
        if (a:AB == "A")
            let fileFrom = fileA
            let fileTo = fileB
        elseif (a:AB == "B")
            let fileFrom = fileB
            let fileTo = fileA
        endif
    else 
        echo "There is no diff here!"
        " Error
        return 1
    endif
    if (operation == "Copy")
        let rtnCode = <SID>Copy(fileFrom, fileTo)
    elseif (operation == "Delete")
        let rtnCode = <SID>Delete(fileFrom)
    endif
    return rtnCode
endfunction

" Synchronize the range
function! <SID>DirDiffSync() range
    let answer = 1
    let silence = 0
    let syncMaster = "A"
    let currLine = a:firstline
    let lastLine = a:lastline
    let syncCount = 0

    while ((currLine <= lastLine))
        " Update the highlight
        call <SID>DeHighlightLine()
        let b:currentDiff = currLine
        call <SID>HighlightLine()
        let line = getline(currLine)
        if (!silence)
            let answer = confirm(substitute(line, "^....", '', ''). "\nSynchronization option:" , "&A -> B\n&B -> A\nA&lways A\nAl&ways B\n&Skip\nCa&ncel", 6)
            if (answer == 1 || answer == 3)
                let syncMaster = "A"
            endif
            if (answer == 2 || answer == 4)
                let syncMaster = "B"
            endif
            if (answer == 3 || answer == 4)
                let silence = 1
            endif
            if (answer == 5)
                let currLine = currLine + 1
                continue
            endif
            if (answer == 6)
                break
            endif
        endif

"        call <SID>DeHighlightLine()
        let rtnCode = <SID>DirDiffSyncHelper(syncMaster, line)
        if (rtnCode == 0)
            " Successful
            let syncCount = syncCount + 1
            " Assume that the line is synchronized, we delete the entry
            setlocal modifiable
            exe (currLine.",".currLine." delete")
            setlocal nomodifiable
            setlocal nomodified
            let lastLine = lastLine - 1
        else
            " Failed!
            let currLine = currLine + 1
        endif
    endwhile
    echo syncCount . " diff item(s) synchronized."
endfunction

" Return file "A" or "B" depending on the line given.  If it's a Only line,
" either A or B does not exist, but the according value would be returned.
function! <SID>GetFileNameFromLine(AB, line)
    " Determine where the source of the copy is.
    let dirA = <SID>GetBaseDir("A")
    let dirB = <SID>GetBaseDir("B")

    let fileToProcess = ""

    if <SID>IsOnly(a:line)
        let fileToProcess = <SID>ParseOnlyFile(a:line)
    elseif <SID>IsDiffer(a:line)
        let regex = '^.*' . s:DirDiffDifferLine . '\[A\]\(.*\)' . s:DirDiffDifferAndLine . '\[B\]\(.*\)' . s:DirDiffDifferEndLine . '.*$'
        let fileToProcess = substitute(a:line, regex, '\1', '')
    else
    endif

    "echo "line : " . a:line. "AB = " . a:AB . " File to Process " . fileToProcess
    if (a:AB == "A")
        return dirA . fileToProcess
    elseif (a:AB == "B")
        return dirB . fileToProcess
    else
        return ""
    endif
endfunction

"Returns the source (A or B) of the "Only" line
function! <SID>ParseOnlySrc(line)
    return substitute(a:line, '^.*' . s:DirDiffDiffOnlyLine . '\[\(.\)\].*:.*', '\1', '')
endfunction

function! <SID>ParseOnlyFile(line)
    let regex = '^.*' . s:DirDiffDiffOnlyLine . '\[.\]\(.*\): \(.*\)'
    let root = substitute(a:line, regex , '\1', '')
    let file = root . s:sep . substitute(a:line, regex , '\2', '')
    return file
endfunction

function! <SID>Copy(fileFromOrig, fileToOrig)
    let fileFrom = substitute(a:fileFromOrig, '/', s:sep, 'g')
    let fileTo = substitute(a:fileToOrig, '/', s:sep, 'g')
    echo "Copy from " . fileFrom . " to " . fileTo
    if (s:DirDiffCopyCmd == "")
        echo "Copy not supported on this platform"
        return 1
    endif

    " Constructs the copy command
    let copycmd = "!".s:DirDiffCopyCmd." ".s:DirDiffCopyFlags
    " Append the interactive flag
    if (g:DirDiffInteractive)
        let copycmd = copycmd . " " . s:DirDiffCopyInteractiveFlag
    endif
    let copycmd = copycmd . " \"".fileFrom."\" \"".fileTo."\""

    " Constructs the copy directory command
    let copydircmd = "!".s:DirDiffCopyDirCmd." ".s:DirDiffCopyDirFlags
    " Append the interactive flag
    if (g:DirDiffInteractive)
        let copydircmd = copydircmd . " " . s:DirDiffCopyInteractiveFlag
    endif
    let copydircmd = copydircmd . " \"".fileFrom."\" \"".fileTo."\""

    let error = 0
    if (isdirectory(fileFrom))
        let error = <SID>DirDiffExec(copydircmd, g:DirDiffInteractive)
    else
        let error = <SID>DirDiffExec(copycmd, g:DirDiffInteractive)
    endif
    if (error != 0)
        echo "Can't copy from " . fileFrom . " to " . fileTo
        return 1
    endif
    return 0
endfunction

" Would execute the command, either silent or not silent, by the
" interactive flag ([0|1]).  Returns the v:shell_error after
" executing the command.
function! <SID>DirDiffExec(cmd, interactive)
    let error = 0
    if (a:interactive)
        exe (a:cmd)
        let error = v:shell_error
    else
        silent exe (a:cmd)
        let error = v:shell_error
    endif
"    let d = input("DirDiffExec: " . a:cmd . " " . a:interactive . " returns " . v:shell_error)
    return error
endfunction

" Delete the file or directory.  Returns 0 if nothing goes wrong, error code
" otherwise.
function! <SID>Delete(fileFromOrig)
    let fileFrom = substitute(a:fileFromOrig, '/', s:sep, 'g')
    echo "Deleting from " . fileFrom
    if (s:DirDiffDeleteCmd == "")
        echo "Delete not supported on this platform"
        return 1
    endif

    let delcmd = ""

    if (isdirectory(fileFrom))
        let delcmd = "!".s:DirDiffDeleteDirCmd." ".s:DirDiffDeleteDirFlags
        if (g:DirDiffInteractive)
            " If running on Unix, and we're running in interactive mode, we
            " append the -i tag
            if (has("unix"))
                let delcmd = delcmd . " " . s:DirDiffDeleteInteractiveFlag
            endif
        else
            " If running on windows, and we're not running in interactive
            " mode, we append the quite flag to the "rd" command
            if (has("win32"))
                let delcmd = delcmd . " " . s:DirDiffDeleteDirQuietFlag
            endif
        endif
    else
        let delcmd = "!".s:DirDiffDeleteCmd." ".s:DirDiffDeleteFlags
        if (g:DirDiffInteractive)
            let delcmd = delcmd . " " . s:DirDiffDeleteInteractiveFlag
        endif
    endif

    let delcmd = delcmd ." \"".fileFrom."\""
    let error = <SID>DirDiffExec(delcmd, g:DirDiffInteractive)
    if (error != 0)
        echo "Can't delete " . fileFrom
    endif
    return error
endfunction

function! <SID>AreDiffWinsOpened()
    let currBuff = expand("%:p")
    let currLine = line(".")
    wincmd k
    let abovedBuff = expand("%:p")
    if (&diff)
        let abovedIsDiff = 1
    else
        let abovedIsDiff = 0
    endif
    " Go Back if the aboved buffer is not the same
    if (currBuff != abovedBuff)
        wincmd j
        " Go back to the same line
        exe (currLine)
        if (abovedIsDiff == 1)
            return 1
        else
            " Aboved is just a bogus buffer, not a diff buffer
            return 0
        endif
    else
        exe (currLine)
        return 0
    endif
endfunction

" The given line begins with the "Only in"
function! <SID>IsOnly(line)	
    return (match(a:line, "^ *" . s:DirDiffDiffOnlyLine . "\\|^==> " . s:DirDiffDiffOnlyLine ) == 0)
endfunction

" The given line begins with the "Files"
function! <SID>IsDiffer(line)
    return (match(a:line, "^ *" . s:DirDiffDifferLine . "\\|^==> " . s:DirDiffDifferLine  ) == 0)
endfunction

" Let you modify the Exclude patthern
function! <SID>ChangeExcludes()
    let g:DirDiffExcludes = input ("Exclude pattern (separate multiple patterns with ','): ", g:DirDiffExcludes)
    echo "\nPress update ('u') to refresh the diff."
endfunction

" Let you modify additional arguments for diff
function! <SID>ChangeArguments()
    let g:DirDiffAddArgs = input ("Additional diff args: ", g:DirDiffAddArgs)
    echo "\nPress update ('u') to refresh the diff."
endfunction

" Let you modify the Ignore patthern
function! <SID>ChangeIgnore()
    let g:DirDiffIgnore = input ("Ignore pattern (separate multiple patterns with ','): ", g:DirDiffIgnore)
    echo "\nPress update ('u') to refresh the diff."
endfunction

" Sorting functions from the Vim docs.  Use this instead of the sort binary.
"
" Function for use with Sort(), to compare two strings.
func! <SID>Strcmp(str1, str2)
  if (a:str1 < a:str2)
	return -1
  elseif (a:str1 > a:str2)
	return 1
  else
	return 0
  endif
endfunction

" Sort lines.  SortR() is called recursively.
func! <SID>SortR(start, end, cmp)
  if (a:start >= a:end)
	return
  endif
  let partition = a:start - 1
  let middle = partition
  let partStr = getline((a:start + a:end) / 2)
  let i = a:start
  while (i <= a:end)
	let str = getline(i)
	exec "let result = " . a:cmp . "(str, partStr)"
	if (result <= 0)
	    " Need to put it before the partition.  Swap lines i and partition.
	    let partition = partition + 1
	    if (result == 0)
		let middle = partition
	    endif
	    if (i != partition)
		let str2 = getline(partition)
		call setline(i, str2)
		call setline(partition, str)
	    endif
	endif
	let i = i + 1
  endwhile

  " Now we have a pointer to the "middle" element, as far as partitioning
  " goes, which could be anywhere before the partition.  Make sure it is at
  " the end of the partition.
  if (middle != partition)
	let str = getline(middle)
	let str2 = getline(partition)
	call setline(middle, str2)
	call setline(partition, str)
  endif
  call <SID>SortR(a:start, partition - 1, a:cmp)
  call <SID>SortR(partition + 1, a:end, a:cmp)
endfunc

" To Sort a range of lines, pass the range to Sort() along with the name of a
" function that will compare two lines.
func! <SID>Sort(cmp) range
  call <SID>SortR(a:firstline, a:lastline, a:cmp)
endfunc

" Added to deal with internationalized version of diff, which returns a
" different string than "Files ... differ" or "Only in ... "

function! <SID>GetDiffStrings()
    " Check if we have the dynamic text string turned on.  If not, just return
    " what's set in the global variables

    if (g:DirDiffDynamicDiffText == 0)
        let s:DirDiffDiffOnlyLine = g:DirDiffTextOnlyIn
        let s:DirDiffDifferLine = g:DirDiffTextFiles
        let s:DirDiffDifferAndLine = g:DirDiffTextAnd
        let s:DirDiffDifferEndLine = g:DirDiffTextDiffer
        return
    endif

	let tmp1 = tempname()
	let tmp2 = tempname()
	let tmpdiff = tempname()

    " We need to pad the backslashes in order to make it match
    let tmp1rx = <SID>EscapeDirForRegex(tmp1)
    let tmp2rx = <SID>EscapeDirForRegex(tmp2)
    let tmpdiffrx = <SID>EscapeDirForRegex(tmpdiff)

	silent exe s:DirDiffMakeDirCmd . "\"" . tmp1 . "\""
	silent exe s:DirDiffMakeDirCmd . "\"" . tmp2 . "\""
	silent exe "!echo test > \"" . tmp1 . s:sep . "test" . "\""
	silent exe "!diff -r --brief \"" . tmp1 . "\" \"" . tmp2 . "\" > \"" . tmpdiff . "\""

	" Now get the result of that diff cmd
	silent exe "split ". tmpdiff
    "echo "First line: " . getline(1)
    "echo "tmp1: " . tmp1
    "echo "tmp1rx: " . tmp1rx
	let s:DirDiffDiffOnlyLine = substitute( getline(1), tmp1rx . ".*$", "", '') 
    "echo "DirDiff Only: " . s:DirDiffDiffOnlyLine
	
	q

	" Now let's get the Differ string
    "echo "Getting the diff in GetDiffStrings"
	
	silent exe "!echo testdifferent > \"" . tmp2 . s:sep . "test" . "\""
	silent exe "!diff -r --brief \"" . tmp1 . "\" \"" . tmp2 . "\" > \"" . tmpdiff . "\""
	
	silent exe "split ". tmpdiff
	let s:DirDiffDifferLine = substitute( getline(1), tmp1rx . ".*$", "", '') 
    " Note that the diff on cygwin may output '/' instead of '\' for the
    " separator, so we need to accomodate for both cases
    let andrx = "^.*" . tmp1rx . "[\\\/]test\\(.*\\)" . tmp2rx . "[\\\/]test.*$"
    let endrx = "^.*" . tmp1rx . "[\\\/]test.*" . tmp2rx . "[\\\/]test\\(.*$\\)"
    "echo "andrx : " . andrx
    "echo "endrx : " . endrx
	let s:DirDiffDifferAndLine = substitute( getline(1), andrx , "\\1", '') 
    let s:DirDiffDifferEndLine = substitute( getline(1), endrx, "\\1", '') 

	"echo "s:DirDiffDifferLine = " . s:DirDiffDifferLine
	"echo "s:DirDiffDifferAndLine = " . s:DirDiffDifferAndLine
	"echo "s:DirDiffDifferEndLine = " . s:DirDiffDifferEndLine

	q

	" Delete tmp files
    "echo "Deleting tmp files."

	call <SID>Delete(tmp1)
	call <SID>Delete(tmp2)
	call <SID>Delete(tmpdiff)
endfunction

" My custom excludes 16-Feb-12.  Override via 'x' then 'u' while in DirDiff
let g:DirDiffExcludes = 'CVS,*.class,*.exe,.*.swp,*.sas7bdat,*.sas7bcat,*.lnk,*.bak,*.log,*.lst,*.xml,*.qry'

" Needed to avoid losing my cpoptions setting above
let &cpo = s:save_cpo  " /*}}}*/

" 2013-07-23 inlined Sbd {{{
" sbd.vim — Smart Buffer Delete
"
" :help sbd.txt
if exists('loaded_sbd')
    finish
endif
let loaded_sbd = 1

if !exists('g:sbd_delete_anyway')
    let g:sbd_delete_anyway = 0
endif

if !exists('g:sbd_close_special')
    let g:sbd_close_special = 1
endif

let s:modeNormal = 'n'
let s:modeCloseModified = 'm'

silent command! -nargs=0 Sbd call <SID>DeleteBuffer(s:modeNormal)
silent command! -nargs=0 Sbdm call <SID>DeleteBuffer(s:modeCloseModified)

function <SID>DeleteBuffer(mode)
    let s:sbdBuffer = bufnr("%")
    let s:sbdBufferCount = 0
    let s:sbdEmptyBuffer = 0
    let s:sbdWindow = winnr()

    if (a:mode != s:modeCloseModified
                \ && getbufvar(s:sbdBuffer, '&modified') == 1
                \ && g:sbd_delete_anyway == 0)
        echom "sbd: save your changes first."
        return
    endif

    for i in range(1, bufnr('$'))
        if (getbufvar(i, '&buflisted') == 1 && getbufvar(i, '&modifiable') == 1)
            let s:sbdBufferCount = s:sbdBufferCount + 1
        endif
    endfor

    windo call s:PreserveWindowLayout()

    if (getbufvar(s:sbdBuffer, '&buflisted') == 1)
        execute "bdelete! " . s:sbdBuffer. ""
    endif

" switch to original window
    execute "normal! " . s:sbdWindow . "\<C-w>\<C-w>"
endfunction

function s:PreserveWindowLayout()
    if (s:sbdBuffer == bufnr("%"))
        let prevBuffer = bufnr("#")

" we're dealing with a special buffer
        if (&buftype != "" && g:sbd_close_special == 1)
            close

" switch to a convenient buffer
        elseif (s:sbdBufferCount <= 1 && s:sbdEmptyBuffer != 0)
            execute "buffer! " . s:sbdEmptyBuffer
        elseif (s:sbdBufferCount <= 1 && s:sbdEmptyBuffer == 0)
            enew!
            let s:sbdEmptyBuffer = bufnr('%')
        elseif (prevBuffer > 0 && buflisted(prevBuffer) && prevBuffer != s:sbdBuffer)
            buffer! #
        else
            bprevious!
        endif
    endif
endfunction  " /*}}}*/


" end 3rd Party Plugins
"--------------------------------------------------------------------------

" Machine or security-sensitive settings
if filereadable(glob("~/.vimrc.local")) 
  source ~/.vimrc.local
endif
