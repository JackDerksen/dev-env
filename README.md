# viis-dev-kit
## The tools and configuration I use for programming, all in one place!

Some old repositories of mine, [JackDerksen/tmux](https://github.com/JackDerksen/tmux) and [JackDerksen/viis-nvim](https://github.com/JackDerksen/viis-nvim), are basically deprecated at this point and no longer used by me. This repo should be more updated! Currently, I'm using the [Sonokai](https://github.com/sainnhe/sonokai) theme throughout my terminal environment. 

## Table of Contents:
- [Windows Terminal with Arch running in WSL2](#Windows-Terminal-Settings)
- [NeoVim](#NeoVim-Configuration)
    - More specifically, a slightly tweaked version of Lazyvim
- [Tmux](#Tmux-Configuration)
- [FD and FZF](#FD/FZF-Configuration)


---


## Windows Terminal Settings
[settings.json](https://github.com/JackDerksen/viis-dev-kit/blob/main/terminal/settings.json)

These are the general settings I use for my Windows Terminal environment. Some sort of nerd font is necessary for this NeoVim config to work properly.


## Arch WSL2 Dotfiles
[dotfiles/](https://github.com/JackDerksen/viis-dev-kit/tree/main/dotfiles)

My dotfiles for Arch Linux in WSL2. These aliases are obviously according to my personal use cases and preferences. My Sonokai FZF configuration is located in the `.bashrc` file.

![image](https://github.com/user-attachments/assets/f888dc21-1885-49f1-a50b-513712162edf)
Main terminal colour scheme and bash prompt

![image](https://github.com/user-attachments/assets/7aa775e7-914e-46db-b164-9525026ebce8)
Fastfetch menu display (yes, I know my Arch logo is orange!)


## NeoVim Configuration
[nvim/](https://github.com/JackDerksen/viis-dev-kit/tree/main/nvim)

Many settings left as defaults from LazyVim, but with some extra plugins I find helpful and some that I don't like disabled.

![image](https://github.com/user-attachments/assets/6d6fa022-cff2-40e5-abf5-5675b554268d)
Startup dashboard

![image](https://github.com/user-attachments/assets/5b27a8ed-794f-4ce5-9328-fc1f2348b701)
Python programming demo of the Sonokai theme and customized lualine

![image](https://github.com/user-attachments/assets/1a19cd1c-40b3-4812-b73d-569a21f355a9)
Oil.nvim

![image](https://github.com/user-attachments/assets/93701f51-d824-494c-b6ce-30c5410b3442)
Telescope.nvim

![image](https://github.com/user-attachments/assets/9cf8de6b-2ad9-44e1-a70e-db970b41e478)
Automaton (make it rain!)


## Tmux Configuration
[tmux.conf](https://github.com/JackDerksen/viis-dev-kit/tree/main/nvim)

My minimal, sort of Sonokai themed Tmux configuration. A few sensible plugins, these are all I personally need. Tmux-resurrect is a lifesaver!

![image](https://github.com/user-attachments/assets/34add692-d939-4b23-80f7-edeceee81679)


## FD/FZF Configuration
[Located in .bashrc](https://github.com/JackDerksen/viis-dev-kit/blob/main/dotfiles/.bashrc)

Pretty basic, aliases set up for both file fuzzy-finding (opened directly into NeoVim) and directory fuzzy-find navigation.

![image](https://github.com/user-attachments/assets/2c74d0d0-8262-4150-8b61-34f171fbc45a)

