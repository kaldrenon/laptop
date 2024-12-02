Laptop
======

Laptop is a script to set up a laptop for web and mobile development.

Adapted from Thoughtbot's Laptop repo, I have customized it for my own needs, including
a script for linux installs, which I use for Ubuntu on WSL 2

**Please note:** This repo is public, but I make no promises about it serving anyone's needs
but my own. You are more than welcome to use or adapt any part of it for you own needs, in
keeping with typical open source philosophy, but it is not intended as a general purpose solution.

Install
-------

Download the script for the environment in question:

```sh
curl --remote-name https://raw.githubusercontent.com/kaldrenon/laptop/main/linux
```

or

```sh
curl --remote-name https://raw.githubusercontent.com/kaldrenon/laptop/main/mac
```

Execute the downloaded script:

```sh
sh linux 2>&1 | tee ~/laptop.log
```

Optionally, review the log:

```sh
less ~/laptop.log
```


License
-------

The code in this repo is © 2024 Andrew Fallows (kaldrenon)

The original version of Laptop is © 2011-2020 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE
