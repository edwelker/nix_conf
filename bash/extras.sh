. ${DOTDOT}/misc_submodules/fzf-git.sh/fzf-git.sh;

# Keystrokes
# also, ctrl-g + f/b/t/r will work
#     CTRL-G CTRL-F for Files
#     CTRL-G CTRL-B for Branches
#     CTRL-G CTRL-T for Tags
#     CTRL-G CTRL-R for Remotes
#     CTRL-G CTRL-H for commit Hashes
#     CTRL-G CTRL-S for Stashes
#     CTRL-G CTRL-E for Each ref (git for-each-ref)

# Inside fzf
#     TAB or SHIFT-TAB to select multiple objects
#     CTRL-/ to change preview window layout
#     CTRL-O to open the object in the web browser (in GitHub URL scheme)

gcb() {
  local selected=$(_fzf_git_branches)
  [ -n "$selected" ] && git checkout "$selected"
}
