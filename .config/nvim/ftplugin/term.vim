setlocal norelativenumber
setlocal nonumber

setlocal scrolloff=0

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
