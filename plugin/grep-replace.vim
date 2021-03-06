" vim grep ':vimgrep'
function! VGrep(search, ...)
	exe 'silent vimgrep! '.a:search.' '.join(a:000) | copen
endfunction

function! VGrepF(search)
	call VGrep(a:search, expand('%'))
endfunction

function! VGrepC()
	call VGrepF(expand('<cword>'))
endfunction

command! -nargs=+ VGrep
			\ call VGrep(<f-args>)

command! -nargs=1 VGrepF
			\ call VGrepF(<f-args>)

command! -nargs=0 VGrepC
			\ call VGrepC()

nnoremap <Leader>vg          :VGrep<space>
nnoremap <Leader>vf          :VGrepF<space>
nnoremap <Leader>vc          :VGrepC<cr>

" git grep ':!git grep --line-number' to quickfix
function! GGrepQf(search, ...)
	let gitgrep_cmd = 'git grep --line-number --column '
	let gitgrep_cmd .= shellescape(a:search)
	let gitgrep_cmd .= ' -- '

	let pathspec = empty(a:000) ? '' : shellescape(join(a:000))
	let gitgrep_cmd .= pathspec

	echom "gitgrep_cmd: ".gitgrep_cmd
	cexpr system(gitgrep_cmd)
	copen
endfunction

function! GGrepQfC()
	call GGrepQf(expand('<cword>'))
endfunction

command! -nargs=+ GGrepQf
			\ call GGrepQf(<f-args>)

command! -nargs=0 GGrepQfC
			\ call GGrepQfC()

nnoremap <Leader>gg          :GGrepQf<space>
nnoremap <Leader>gc          :GGrepQfC<cr>

" TODO: Add replace functions, commands & keymaps
