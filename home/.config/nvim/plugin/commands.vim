command! -nargs=1 Notes split ~/Dropbox/Notes.d/<args>.md

command! NotesPreview !open http://localhost:8080

command! TerraformFmt !terraform fmt
