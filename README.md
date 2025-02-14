# dev-env
## The tools and configuration I use for programming, all in one place!

Some old repositories of mine, [JackDerksen/tmux](https://github.com/JackDerksen/tmux) and [JackDerksen/viis-nvim](https://github.com/JackDerksen/viis-nvim), are basically deprecated at this point and no longer used by me. This repo should be more updated! Currently, I'm using the [Sonokai](https://github.com/sainnhe/sonokai) theme throughout my terminal environment. 

## Table of Contents:
- [Windows Terminal with Arch running in WSL2](#Windows-Terminal-Settings)
- [NeoVim](#NeoVim-Configuration)
- [Tmux](#Tmux-Configuration)
- [FD and FZF](#FD/FZF-Configuration)


---


## Windows Terminal Settings
[settings.json](https://github.com/JackDerksen/dev-env/blob/main/terminal/settings.json)

These are the general settings I use for my Windows Terminal environment. Some sort of nerd font is necessary for this NeoVim config to work properly.


## Arch WSL2 Dotfiles
[dotfiles/](https://github.com/JackDerksen/dev-env/tree/main/dotfiles)

My dotfiles for Arch Linux in WSL2. These aliases are obviously according to my personal use cases and preferences. My Sonokai FZF configuration is located in the `.bashrc` file.

![image](https://github.com/user-attachments/assets/164ca45e-8721-4981-a2ae-15959ef7e8c9)
Main terminal colour scheme and bash prompt

![image](https://github.com/user-attachments/assets/7aa775e7-914e-46db-b164-9525026ebce8)
Fastfetch menu display (yes, I know my Arch logo is orange!)


## NeoVim Configuration
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


## Tmux Configuration
[tmux.conf](https://github.com/JackDerksen/dev-env/tree/main/nvim)

My minimal Sonokai themed Tmux configuration. A few sensible plugins, these are all I personally need. Tmux-resurrect in particular is a lifesaver!

![image](https://github.com/user-attachments/assets/34add692-d939-4b23-80f7-edeceee81679)


## FD/FZF Configuration
[Located in .bashrc](https://github.com/JackDerksen/dev-env/blob/main/dotfiles/.bashrc)

Pretty basic, aliases set up for both file fuzzy-finding (opened directly into NeoVim) and directory fuzzy-find navigation. Will open in a centered window if used inside of a Tmux session.

![image](https://github.com/user-attachments/assets/2c74d0d0-8262-4150-8b61-34f171fbc45a)

