# My dotfiles

I'm using [stow](https://www.gnu.org/software/stow/) now. Watch [this video](https://www.youtube.com/watch?v=y6XCebnB9gs) for a nice intro.

## Quick how-to

To add new files to `~/dotfiles`, move them from `~/` to `~/dotfiles` keeping the same tree structure, then run `stow --adopt .` from the `~/dotfiles` directory, which will symlink them back to where they used to be.

## License

MIT
