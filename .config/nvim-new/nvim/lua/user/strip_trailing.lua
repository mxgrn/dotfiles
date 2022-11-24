vim.cmd([[
  " Remove trailing whitespace from code files on save
  function! StripTrailingWhitespace()

    " store current cursor location
    silent exe "normal ma"

    " store the current search value
    let saved_search = @/

    " delete the whitespace (e means don't warn if pattern not found)
    %s/\s\+$//e

    silent exe 'retab'

    " restore old cursor location
    silent exe "normal 'a"

    " restore the search value
    let @/ = saved_search
  endfunction

  augroup strip_trailing
    autocmd!
    " Remove trailing whitespace from files that don't have auto-format
    autocmd BufWritePre,FileWritePre *.html,*.haml,*.rb,*.xml,*.erb,*.vimrc,*.js,*.coffee,*.md,*.markdown,*.eex,*.slim,*.css,*.yml,*.lua call StripTrailingWhitespace()
  augroup end
]])
