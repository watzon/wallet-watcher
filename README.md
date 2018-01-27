# Garlic Wallet Watcher

Watches the garlicoind daemon and waits for the balance to change, then notifies you using libnotify if there are any changes.

## Installation

You will need the crystal compiler installed to build this. You can find directions on installing it from [here](https://crystal-lang.org/docs/installation/)

Clone this repo with `git clone https://github.com/watzon/wallet-watcher.git` and cd into the wallet-watcher directory.
Build the client with `shards build` or with `crystal build ./src/wallet-watcher.cr`.
Move the binary wherever you want and run it with `./wallet-watcher` or if it's in your path `wallet-watcher`. If you want to run it in the background do `wallet-watcher &`.

If it's not working make sure `garlicoind` is running.

## Contributing

1. Fork it ( https://github.com/watzon/grlc-wallet-watcher/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [watzon](https://github.com/watzon) Chris Watson - creator, maintainer
