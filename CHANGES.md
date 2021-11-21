1.0
===
* Major release
* Use dune ctypes feature to delete a ton of boilerplate (requires dune 3.0)
* Now vendoring libmpg123 instead of using pkg-config because we want
  - a more stable build environment
  - access to latest features (mpg123_open_fixed), built-in conversion to float32
  - changed `read` to `read_ba` (bigarray) for additional performance wins
  - get static linking
* Fix bug where only the first id3 comment/extra/pic was loaded
* Set up GitHub Action to do build tests
