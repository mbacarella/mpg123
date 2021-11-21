(lang dune 3.0)

(using ctypes 0.1)

(use_standard_c_and_cxx_flags false)

(name mpg123)

(generate_opam_files true)

(license "LGPL-2.1-or-later WITH OCaml-LGPL-linking-exception")

(authors "Michael Bacarella <m@bacarella.com>")

(maintainers "Michael Bacarella <m@bacarella.com>")

(homepage "https://github.com/mbacarella/mpg123")

(source
 (github mbacarella/mpg123))

(package
 (name mpg123)
 (synopsis "MP3 decoding library")
 (description "OCaml bindings to libmpg123")
 (depends
  (ocaml
   (>= 4.03))
  (ctypes
   (>= 0.13.0))
  ctypes-foreign))
