(lang dune 2.0)
(name mpg123)

(generate_opam_files true)
(license "LGPL-2.1-or-later with OCaml-LGPL-linking-exception")
(authors "Michael Bacarella")
(maintainers "m@bacarella.com")
(package
  (name mpg123)
  (synopsis "MP3 decoding library")
  (description "OCaml bindings to libmpg123")
  (depends ctypes))
