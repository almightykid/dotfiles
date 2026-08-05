# dotfiles

Personal macOS setup: shell, terminal, tmux, prompt, and the Homebrew packages behind them.

## Structure

Each top-level directory is a [GNU Stow](https://www.gnu.org/software/stow/) package:

| Package    | Contents               | Symlinked to        |
|------------|-------------------------|----------------------|
| `zshrc`    | `.zshrc`                | `$HOME`               |
| `tmux`     | `tmux.conf`             | `~/.config/tmux`      |
| `starship` | `starship.toml`         | `~/.config`            |
| `ghostty`  | `config`                | `~/.config/ghostty`   |

`Brewfile` lists everything installed via Homebrew (formulae, casks, VS Code extensions, Go/npm/krew tools). `setup.sh` bootstraps a new machine end to end.

## Install

```sh
git clone <this-repo> ~/dotfiles
cd ~/dotfiles
./setup.sh
```

`setup.sh` will:

1. Install Homebrew if missing.
2. Run `brew bundle` against `Brewfile`.
3. Install Oh My Zsh if missing.
4. Clone `zsh-autosuggestions` and `zsh-syntax-highlighting` into `$ZSH_CUSTOM/plugins`.
5. Clone the tmux plugin manager (TPM).
6. Stow `zshrc` to `$HOME` and `tmux`/`starship`/`ghostty` to `~/.config`.

After it finishes: restart your shell, then open tmux and press `prefix + I` to install tmux plugins.

If a target file already exists as a real file (not a symlink), Stow will refuse rather than overwrite it — back it up or remove it first, then re-run `./setup.sh`.

## Notes

- Stow target defaults to `~/.config` (see `.stowrc`); `zshrc` is the one package stowed to `$HOME` instead, since zsh reads `~/.zshrc` by default.
- Keep `Brewfile` in sync with what's actually installed: `brew bundle dump --force --file=Brewfile` from a machine you trust as the source of truth.
