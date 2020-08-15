# Improvements from original mimi

I've tried to collect commits from a couple forks which fix a few bugs, allow shell interactive usage allow handling of html `#section` suffixes.

In addition, I have added the following:
- handling of `mailto` and `tg`(telegram) protocols via the `x-scheme-handler` mimetype
- support for multiple arguments in `Exec` field of `.desktop` files
- fixed running in background for non-interactive mode
- prioritized the user's configuration for .desktop files

If you think of something (protocol, mimetypes) that mimi should be able to handle, feel free to open an issue!

### Tips and tricks
- If your $TERM variable is not executable (i.e. something st-256color), you might want to set `TERM: $executableterm` in your mimi.conf.

## Example configuration

``` sh
TERM: st

audio/: mpv
video/: mpv
image/: sxiv-open
pdf: zathura
application/x-shockwave-flash: flashplayer
application/xhtml_xml: chromium
text/html: chromium
text/xml: chromium
x-scheme-handler/http: chromium
x-scheme-handler/https: chromium
x-scheme-handler/ftp: chromium
x-scheme-handler/about=chromium
x-scheme-handler/unknown=chromium
# TODO check whether this works
x-scheme-handler/tg: telegram-desktop --
# TODO is this necessary ? (.desktop should do it)
x-scheme-handler/mailto: st -e neomutt
```

## Original README:

#What is this?
mimi is an improved verision of xdg-open.
The original xdg-open works horribly without DE environment.

#usage
1. you can define a list of 'how-to-open' in '~/.config/mimi/mimi.conf' (read below for format)
2. or you are lazy, mimi will search a best-fit app using .desktop file. Best fit is defined as
	the first option sorted by mime order and then , if they have the same mime order, reverse sorted by generality

	For example, the best-fit app says it can open 'text/html' in the very beginning of its mime definition.
	if two or more apps have the same priority, then we choose the app that can open the most number of file types.

#search order
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

#customize
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
