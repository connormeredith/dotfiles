if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " Ansible.
  au! BufRead,BufNewFile main.yml setfiletype yaml.ansible
  au! BufRead,BufNewFile */tasks/*.yml setfiletype yaml.ansible
augroup END
