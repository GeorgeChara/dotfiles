" File: remote-ls.vim

function! RemoteLS()
  let server = "your-server-name"
  let output = system("ssh " . server . " ls")
  echo output
endfunction

command! RemoteLS call RemoteLS()

