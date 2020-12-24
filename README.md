> See the [original README](#old-readme) for general usage.

# Table of Contents
<!-- vim-markdown-toc GFM -->

* [Improvements from the original mimi](#improvements-from-the-original-mimi)
    * [Xdg-email](#xdg-email)
    * [Example configuration](#example-configuration)
    * [Tips and tricks](#tips-and-tricks)
* [Installation](#installation)
    * [From git](#from-git)
    * [From the AUR](#from-the-aur)
* [Old README](#old-readme)
    * [What is this?](#what-is-this)
        * [usage](#usage)
        * [search order](#search-order)
        * [customize](#customize)

<!-- vim-markdown-toc -->

# Improvements from the original mimi

I've collected commits from some forks which fix bugs, allow shell interactive usage and handling of HTML urls' `#section` suffixes.

In addition, I have added the following:
- support for custom `menu` programs in alternative to `dmenu`, by setting the `MENU` and `MENUARGS` configuration variable. `MENU` has to be an executable, and also compatible with `dmenu`'s `-p` flag; i.e. for `rofi` use `MENU: rofi -dmenu`. If `MENU` is not set AND `dmenu` is not available, a notification is sent to the user.
- custom handling of `mailto`, `spotify` and `tg`(telegram) URI protocols via the `x-scheme-handler` mimetype(!)
- support for multiple arguments in `Exec` field of `.desktop` files
- apps in your `$PATH` are now correctly listed when choosing an opener from `${MENU:-dmenu}`
- fixed running in background for non-interactive mode
- prioritized the user's configuration for .desktop files

If you think of something (protocol, mimetypes) that mimi should be able to handle, feel free to open an issue!

## Xdg-email

I have also added a drop-in replacement for the `xdg-email` script, part of the common `xdg-utils` package, because some applications (such as `chromium`) use it to handle the
`mailto` protocol.
This script simply calls `xdg-open` (aka `mimi`) instead.

## Example configuration

``` sh

TERM: st

# This is the default
MENU: dmenu

audio/: mpv
video/: mpv
image/: sxiv
pdf: zathura
application/xhtml_xml: chromium
text/html: chromium
text/xml: chromium
x-scheme-handler/http: chromium
x-scheme-handler/https: chromium
x-scheme-handler/ftp: chromium
x-scheme-handler/about=chromium
x-scheme-handler/unknown=chromium

# vim: ft=xdefaults
```

## Tips and tricks

- If your $TERM variable is not executable (i.e. something st-256color), you might want to set `TERM: yourterminal` in your mimi.conf.
- You can set MENU and MENUARGS to use a dmenu alternative. For instance, to use rofi:
```
MENU: rofi
MENUARGS: -dmenu
```

# Installation

## From git

- Clone the repository: `git clone https://github.com/BachoSeven/mimi.git`
- To replace the system's `xdg-open` and `xdg-email`, just do `sudo make install`.

## From the AUR

You can find a handy `xdg-utils`-conflicting package [here](https://aur.archlinux.org/packages/mimi-bachoseven-git/).

# Old README

## What is this?
mimi is an improved verision of xdg-open.
The original xdg-open works horribly without DE environment.

### usage
1. you can define a list of 'how-to-open' in '~/.config/mimi/mimi.conf' (read below for format)
2. or you are lazy, mimi will search a best-fit app using .desktop file. Best fit is defined as
the first option sorted by mime order and then , if they have the same mime order, reverse sorted by generality

for example, the best-fit app says it can open 'text/html' in the very beginning of its mime definition.
if two or more apps have the same priority, then we choose the app that can open the most number of file types.

### search order
for example, I want to define how to open 'text/html'. mimi will search in order like this

1. 'txt' in your config
2. <protocol> in your config (i.e. http, ftp, magnet) ...etc.
3. 'text/html' in your config
4. 'text/' in your config
5. 'text/html' in .desktop
6. 'text/' in .desktop
7. if mimi still cannot find anything, it will open dmenu and bug you.

note:

1. sometimes, mimi is smart enough to figure out protocol based on mime-type when it searches for .desktop.
2. sometimes, if an app requires a terminal to run (ncurses programs), mimi is able to find one terminal app in .desktop.

### customize
this is my own stuff

    text/: xterm -e vim
    application/pdf: zathura
    video/: vlc
    image/: feh
    audio/: vlc
    application/x-tar: xterm -e 2a
    application/x-gzip: xterm -e 2a
    application/x-bzip2: xterm -e 2a
    application/x-rar: xterm -e 2a
    application/x-xz: xterm -e 2a
    application/zip: xterm -e 2a
    inode/directory: xterm -e ranger

it can be simplified by using:

    rar: xterm -e 2a

but if you have time, using mime-type is more precise
