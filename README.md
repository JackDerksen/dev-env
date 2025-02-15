# dev-env
## The tools and configuration I use for programming, all in one place!

Some old repositories of mine, [JackDerksen/tmux](https://github.com/JackDerksen/tmux) and [JackDerksen/viis-lazyvim](https://github.com/JackDerksen/viis-lazyvim), are basically deprecated at this point and no longer used by me. This repo should be more updated! Currently, I'm using the [Sonokai](https://github.com/sainnhe/sonokai) theme throughout my terminal environment. 

# Table of Contents:
- [My Typical Workflow](#Workflow-Example)
- [Windows Terminal with Arch running in WSL2](#Windows-Terminal-Settings)
- [Neovim](#Neovim-Configuration)
- [Tmux](#Tmux-Configuration)
- [FD and FZF](#FD/FZF-Configuration)
- [Installation Instructions](#Installation)


---

# Workflow Example

## If I want to work in a directory

1. `$ dff` to fuzzy-find my way to the directory I want to work in
2. `$ tn dev` to start a new Tmux instance rooted in that directory
3. Make new Tmux windows depening on what I'm doing
  - Example: If I'm working on a programming project, I might `Ctrl+Space` to edit the title of the currently-focused Tmux window to 'nvim' if that will be my dedicated programming window, then `Ctrl+c` to make a new window and `Ctrl+Space` again and rename that one 'testing'. I can then split the testing window vertically (`Ctrl+Space`, `|`) or horizontally (`Ctrl+Space`, `-`) depending on how I want to test my code.

4. If you want to save the state of this Tmux session to return to later, you can hit `Ctrl+Space`, `Ctrl+s` to save the state. You can then quit the Tmux or terminal session safely, and reload it later with `Ctrl+Space`, `Ctrl+r` from within a new Tmux session (the session name will be reloaded from the previously-saved session). 

## If I just need to work on a specific file

Type `$ ff` to open up an fzf finder, then fuzzy-find my way to that specific file and automatically open it in Neovim.


---


# Windows Terminal Settings
[settings.json](https://github.com/JackDerksen/dev-env/blob/main/terminal/settings.json)

I do almost all of my programming in Arch WSL through the Windows Terminal, so I've spent quite a bit of time fine-tuning it to my needs and preferences. These are the general settings I use for my Windows Terminal environment. Note that some sort of [nerd font](https://www.nerdfonts.com/) is necessary for this Neovim config to work properly.


## Arch WSL2 Dotfiles
[dotfiles/](https://github.com/JackDerksen/dev-env/tree/main/dotfiles)

My dotfiles for Arch Linux in WSL2. These aliases are obviously according to my personal use cases and preferences. My Sonokai FZF configuration is located in the `.bashrc` file.

![image](https://github.com/user-attachments/assets/94f8d428-cbcc-4f81-9881-cf0436c99a90)
Main terminal colour scheme and bash prompt

![image](https://github.com/user-attachments/assets/46074455-74e5-4912-9056-2eed97571610)
Fastfetch menu display (yes yes, orange Arch logo)


# NeoVim Configuration
[nvim/](https://github.com/JackDerksen/dev-env/tree/main/nvim)

![image](https://github.com/user-attachments/assets/f0722f22-749c-41fe-a09a-75e16ea95f17)

Basically just a slightly tweaked LazyVim, since I've found I really enjoy most of it's defaults. Some extra plugins I find helpful, with some defaults that I don't like disabled.

![image](https://github.com/user-attachments/assets/3f729d32-1a58-4696-bec8-d744373dfa6b)
Startup dashboard

![image](https://github.com/user-attachments/assets/37024130-dde1-4103-ba7f-ba1d4e97b324)
Rust programming demo of the Sonokai theme and customized lualine

![image](https://github.com/user-attachments/assets/e2455833-fe65-40e2-a504-f949e3ae48ee)
Oil.nvim is my preferred file explorer

![image](https://github.com/user-attachments/assets/4f3ba028-7a03-4111-b196-2d093141d5b1)


# Tmux Configuration
[tmux.conf](https://github.com/JackDerksen/dev-env/tree/main/nvim)

My minimal Sonokai themed Tmux configuration. A few sensible plugins, these are all I personally need. Tmux-resurrect in particular is a lifesaver!

![image](https://github.com/user-attachments/assets/ab69d499-7a05-4413-b5cd-7861f26be04c)


# FD/FZF Configuration
[Located in .bashrc](https://github.com/JackDerksen/dev-env/blob/main/dotfiles/.bashrc)

Pretty basic, aliases set up for both file fuzzy-finding (opened directly into Neovim) and directory fuzzy-find navigation. Will open in a centered window if used inside of a Tmux session.

![image](https://github.com/user-attachments/assets/d3a3227a-d9eb-435a-8c61-3e3a44d84133)

---

# Installation

## First make sure you have these dependencies installed:
- Git
- Curl
- [Neovim (version >= 0.9.0)](https://github.com/neovim/neovim/releases)
- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [Ripgrep](https://https://github.com/BurntSushi/ripgrep)
- [Tmux](https://github.com/tmux/tmux/wiki/Installing)
- Some [nerd font](https://www.nerdfonts.com/) for your terminal, just so it can display all the icons correctly. I like Caskaydia Mono.

## After that...
1. Clone this repository onto your machine, ideally at the `~/` directory.
2. `cd` into the new `dev-env/` directory and change the permissions of the install script with `$ chmod +x install.sh`
3. Run the install script with `$ ./install.sh`. That should:
  - Back up your existing files, if they already exist
  - Automatically install my Neovim and Tmux configurations in `~/.config/nvim` and `~./config/tmux` respectively
  - Automatically append the contents of my `.bashrc` and `.bash_aliases` files to your respective files
  - Provide clear status feedback along the way
4. Restart your terminal and/or run `$ source ~/.bashrc` to refresh your terminal with the changes

Note: This will leave the `settings.json` file for the Windows Terminal settings in the cloned repo directory for you to apply on your own in the terminal settings.
