# Dotfiles

This repository contains dotfiles managed with
[chezmoi](https://github.com/twpayne/chezmoi).

## Setup

To apply these dotfiles on a new machine, install `chezmoi` and then:

```bash
# initialize
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
# assess changes ready to apply locally
chezmoi diff
# apply when ready
chezmoi -v apply
```

Update straight from remote repository:

```bash
chezmoi update
```

## Documentation

For more information, see the
[chezmoi documentation](https://www.chezmoi.io/user-guide/command-overview/).
