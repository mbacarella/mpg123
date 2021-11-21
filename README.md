![main workflow](https://github.com/mbacarella/curses/actions/workflows/workflow.yml/badge.svg)

This is an OCaml package that provides bindings to the mpg123 library.

It uses the excellent ctypes library to generate the C-stubs which should help
minimize the bugspace.

Installing
===

`opam install mpg123`

System vs. vendored libmpg123
===

Versions of this OCaml library through 0.4 used to probe for your system's
libmpg123 package using `pkg-config`.

Newer versions of this library use a vendored mpg123 for stability and to gain
access to latest features (yes, reading MP3s is still an area of active
development).

Status
===

There's just enough here to open an mp3, query some metadata, and read audio.

See the changelog at [CHANGES.md](CHANGES.md).

Contributions welcome.
