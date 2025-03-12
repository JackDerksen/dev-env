# dev-env
## The tools and configuration I use for programming, all in one place!

Some old repositories of mine, [JackDerksen/tmux](https://github.com/JackDerksen/tmux) and [JackDerksen/viis-lazyvim](https://github.com/JackDerksen/viis-lazyvim), are basically deprecated at this point and no longer used by me. This repo should be more updated! Currently, I'm using the [Sonokai](https://github.com/sainnhe/sonokai) theme throughout my terminal environment. 

# Table of Contents:
- [My Typical Workflow](#Workflow-Example)
- [Windows Terminal with Arch running in WSL2](#Windows-Terminal-Settings)
- [NeoVim](#NeoVim-Configuration)
- [Tmux](#Tmux-Configuration)
- [FD and FZF](#FD/FZF-Configuration)
- [Installation Instructions](#Installation)


---

# Workflow Example

## If I want to work in a directory

1. `$ dff` to fuzzy-find my way to the directory I want to work in
2. `$ tn dev` to start a new Tmux instance rooted in that directory
3. Make new Tmux windows depening on what I'm doing
  - **Example:** (*note that `<Ctrl+Space>` is my 'leader key' for Tmux*) If I'm working on a programming project, I might `<Ctrl+Space> ,` to edit the title of the currently-focused Tmux window to 'nvim' if that will be my dedicated programming window, then `Ctrl+c` to make a new window and `<Ctrl+Space>` again and rename that one 'testing'. I can then split the testing window vertically (`<Ctrl+Space> |`) or horizontally (`<Ctrl+Space> -`) depending on how I want to test my code.

4. If you want to save the state of this Tmux session to return to later, you can hit `<Ctrl+Space> Ctrl+s` to save the state. You can then quit the Tmux or terminal session safely, and reload it later with `<Ctrl+Space> Ctrl+r` from within a new Tmux session (the session name will be reloaded from the previously-saved session). 

## If I just need to work on a specific file

Type `$ ff` to open up an fzf finder, then fuzzy-find my way to that specific file and automatically open it in NeoVim.


---


# Windows Terminal Settings
[settings.json](https://github.com/JackDerksen/dev-env/blob/main/terminal/settings.json)

I do almost all of my programming in Arch WSL through the Windows Terminal, so I've spent quite a bit of time fine-tuning it to my needs and preferences. These are the general settings I use for my Windows Terminal environment. Note that some sort of [nerd font](https://www.nerdfonts.com/) is necessary for this NeoVim config to work properly.


## Arch WSL2 Dotfiles
[dotfiles/](https://github.com/JackDerksen/dev-env/tree/main/dotfiles)

My dotfiles for Arch Linux in WSL2. These aliases are obviously according to my personal use cases and preferences. My Sonokai FZF configuration is located in the `.bashrc` file.

![image](https://github.com/user-attachments/assets/23a63cd0-799f-484b-bd9d-e98493033194)
Main terminal colour scheme and bash prompt

![image](https://github.com/user-attachments/assets/f7b107e2-9673-487a-9fee-3da91225bdef)
Fastfetch menu display (yes yes, orange Arch logo)


# NeoVim Configuration
[nvim/](https://github.com/JackDerksen/dev-env/tree/main/nvim)

![image](https://github.com/user-attachments/assets/971c5934-9473-4a6e-8e60-14ee59f73676)

My fully-custom NeoVim configuration with the following key plugins:
- Lazy plugin manager
- Mason and LSP-config for LSP integration
- Nvim-CMP suite for code completion and snippets
- Conform for code formatting
- Gitsigns for git change UI in the sign column
- Harpoon2 for fast file switching
- Heirline for a very fast and nice-looking statusline
- Indent-Blankline for indent scope highlighting
- None-LS for linting
- Noice for nicer command line, popup, and message UIs
- Oil for file navigation and management
- Snacks Dashboard for a nice startup dashboard
- Telescope for fuzzy-finding functionality
- Treesitter for all the wonderful Treesitter things
- Trouble of code error management
- Undotree for better undo-ing
- Vim-Tmux-Navigator for easier usage with Tmux
- Whichkey for keymap help

![image](https://github.com/user-attachments/assets/a59b1b8f-f80d-418c-b966-1876bcacd6ff)
!Emacs Startup dashboard

![image](https://github.com/user-attachments/assets/34d910fa-3167-417d-94b6-b747207566e5)
Rust programming demo of the Sonokai theme and customized Lualine

![image](https://github.com/user-attachments/assets/f2424058-9857-46c0-a657-d9ddd03f507d)
Oil is my preferred file explorer, allowing you to modify the file structure like a vim buffer

![image](https://github.com/user-attachments/assets/85daf283-1fac-449c-8db8-cd9521a1d521)
Telescope fuzzy finding


# Tmux Configuration
[tmux.conf](https://github.com/JackDerksen/dev-env/tree/main/nvim)

My minimal Sonokai themed Tmux configuration. A few sensible plugins, these are all I personally need. Tmux-resurrect in particular is a lifesaver!

![image](https://github.com/user-attachments/assets/4eb2b147-bf6e-424a-97e0-14f8a8a1a878)


# FD/FZF Configuration
[Located in .bashrc](https://github.com/JackDerksen/dev-env/blob/main/dotfiles/.bashrc)

Pretty basic, aliases set up for both file fuzzy-finding (opened directly into NeoVim) and directory fuzzy-find navigation. Will open in a centered window if used inside of a Tmux session.

![image](https://github.com/user-attachments/assets/fb428486-e349-4a54-8ffd-0e9c09bbc4c5)

---

# Installation

## First make sure you have these dependencies installed:
- Git
- Curl
- [NeoVim (version >= 0.9.0)](https://github.com/NeoVim/NeoVim/releases)
- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [Ripgrep](https://https://github.com/BurntSushi/ripgrep)
- [Tmux](https://github.com/tmux/tmux/wiki/Installing)
- [TPM](https://github.com/tmux-plugins/tpm)
- Some [nerd font](https://www.nerdfonts.com/) for your terminal, just so it can display all the icons correctly. I like Caskaydia Mono, personally.

## After that...
1. Clone this repository onto your machine, ideally at the `~/` directory.
2. `cd` into the new `dev-env/` directory and change the permissions of the install script with `$ chmod +x install.sh`
3. Run the install script with `$ ./install.sh`. That should:
  - Back up your existing files, if they already exist
  - Automatically install my NeoVim and Tmux configurations in `~/.config/nvim` and `~./config/tmux` respectively
  - Automatically append the contents of my `.bashrc` and `.bash_aliases` files to your respective files
  - Provide clear status feedback along the way
4. Restart your terminal and/or run `$ source ~/.bashrc` to refresh your terminal with the changes
5. To source the Tmux changes:
  - Start a new session with `$ tmux`
  - Source the configuration file and load the TPM packages with `$ tmux source ~/.config/tmux/tmux.conf`
  - Install the TPM packages with `Ctrl + Space, I`
  - All the new keybinds and plugins should work now, and you should be able to re-source Tmux simply by using `Ctrl + Space, r` from now on.

**Note**: This install script will leave the `settings.json` file for the Windows Terminal settings in the cloned repo directory for you to apply on your own in the terminal settings.
