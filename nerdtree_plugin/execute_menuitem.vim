" ============================================================================
" File:        NerdtreeExecute_ToggleMouse.vim
" ============================================================================
if exists("g:loaded_nerdtree_shell_exec_menuitem")
  finish
endif

let g:loaded_nerdtree_shell_exec_menuitem = 1

call NERDTreeAddMenuItem({
      \ 'text': 'e(x)ecute',
      \ 'shortcut': 'x',
      \ 'callback': 'NERDTreeExecute' })

function! NERDTreeExecute()
	"echomsg "fuck"
  let l:oldssl=&shellslash
  set noshellslash
  let treenode = g:NERDTreeFileNode.GetSelected()
  let path = treenode.path.str()

  if has("gui_running")
    let args = shellescape(path,1)." &"
  else
    let args = shellescape(path,1)." > /dev/null"
  end
	"echomsg matchend(args,'.png') == -1

	if(matchend(args,'.png') != -1 || matchend(args,'.jpg') != -1  || matchend(args,'.jpeg') != -1 || matchend(args,'.JPG') != -1 || matchend(args,'.PNG') != -1 || matchend(args,'.svg') != -1 || matchend(args,'.tif') != -1 || matchend(args,'.ico') != -1 )
		exe "silent !feh ".args
	elseif(matchend(args,'.pdf') != -1 )
		exe "silent !nohup mupdf ".args." 2>&1 &"
	elseif(matchend(args,'.doc') != -1 || matchend(args,'.docx') != -1)
		exe "silent !nohup wps ".args." 2>&1 &"
	elseif(matchend(args,'.ppt') != -1 || matchend(args,'.pptx') != -1)
		exe "silent !nohup wpp ".args." 2>&1 &"
	elseif(matchend(args,'.xls') != -1 || matchend(args,'.xlsx') != -1)
		exe "silent !nohup et ".args." 2>&1 &"
	elseif(matchend(args,'.mp4') != -1 || matchend(args,'.mkv') != -1 || matchend(args,'.mp44') != -1 || matchend(args,'.flv') != -1)
		exe "silent !nohup ffplay ".args." 2>&1 &"
	elseif(matchend(args,'.ui') != -1)
		exe "silent !nohup designer ".args." 2>&1 &"
	end
  let &shellslash=l:oldssl
  redraw!
endfunction
