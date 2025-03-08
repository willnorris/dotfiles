# pure

<https://github.com/sindresorhus/pure>

## Local changes

My local changes add support for making the pure prompt responsive to the window size.
If the window height is smaller than 20 rows, the prompt is displayed on a single line.
Otherwise, it is displayed in two rows like the normal pure prompt.

The directory name included in the prompt is truncated to fit the available width.
When the prompt is displayed in two lines, it uses the full window width,
since the main part of the prompt is on its own line.
On smaller windows with the prompt displayed on a single line,
the directory name is truncated so that the entire prompt takes up no more than 1/4 to 1/3 of the available width.
Additional portions of the prompt like git information are taken into account when calculating width.

To see the local changes, run the following locally
(GitHub doesn't support comparing a specific directory between commits):

```
git diff origin/pure-upstream..origin/main -- vendor/pure
```

A demo of the responsive resizing can be seen here:

[![asciicast](https://asciinema.org/a/Idvij1uennRHVZI5h0vEsQDv5.svg)](https://asciinema.org/a/Idvij1uennRHVZI5h0vEsQDv5)
