(* This is a very thin wrapper over the functions in mpg123.h.

   In general you should reference that for the particulars of how to call
   these functions. *)
type error_code = int
type flags = int

val api_version : int
val ok : error_code
val done_ : error_code
val flag_id3 : flags
val flag_new_id3 : flags
val flag_icy : flags
val flag_new_icy : flags

type enc = int

val enc_signed16 : int
val enc_float32 : int
val init : unit -> (unit, error_code) result
val exit : unit -> unit

type handle

val new_ : ?decoder:string -> unit -> (handle, error_code) result
val delete : handle -> unit
val plain_strerror : error_code -> string
val strerror : handle -> string
val errcode : handle -> error_code
val decoders : unit -> string list
val supported_decoders : unit -> string list
val decoder : handle -> decoder_name:string -> (unit, error_code) result
val current_decoder : handle -> string
val open_ : handle -> path:string -> (unit, error_code) result
val open_fixed : handle -> path:string -> channels:int -> encoding:int -> (unit, error_code) result
val close : handle -> (unit, error_code) result

(* [read_ba handle bigarray len] reads len number of bytes into your bigarray.

   It's up to you to manage the translation between the size of the elements in
   your array and the bytes you request. Additionally, this can fail badly if you
   pass a float bigarray but opened the mp3 with a different encoding.

   A safe example of calling read_ba is:
   ```
     let bufsize = 32768 in
     let bytes_per_sample = 4 in (* size of float32 *)
     let num_channels = 2 in (* stereo *)
     let buf = Bigarray.Array1.create Bigarray.Float32 Bigarray.c_layout bufsize in
     match Mpg123.read_ba handle ~buf ~len_in_bytes:(bufsize * bytes_per_sample) with
     | Error errcode -> failwithf "Mpg123.read_ba: %s" (strerror errcode) ()
     | Ok bytes_read ->
       assert (bytes_read >= 0);
       let samples_read = bytes_read / bytes_per_sample in
       let frames_read = samples_read / num_channels in
       ...
   ```
 *)
val read_ba
  :  handle ->
  buf:('a, 'b, Bigarray.c_layout) Bigarray.Array1.t ->
  len_in_bytes:int ->
  (int, error_code) result

val scan : handle -> (unit, error_code) result
val length : handle -> (int, error_code) result
val meta_check : handle -> flags
val meta_free : handle -> unit

type id3_v1 =
  { tag : string;
    title : string;
    artist : string;
    album : string;
    year : string;
    comment : string;
    genre : char
  }

type id3_v2_text =
  { lang : string;
    id : string;
    description : string;
    text : string
  }

type id3_v2_picture =
  { type_ : char;
    description : string;
    mime_type : string;
    size : int;
    data : string
  }

type id3_v2 =
  { version : char;
    title : string;
    artist : string;
    album : string;
    year : string;
    genre : string;
    comment : string;
    comment_list : id3_v2_text list;
    text : id3_v2_text list;
    extra : id3_v2_text list;
    picture : id3_v2_picture list
  }

type output_format =
  { rate : int;
    channels : int;
    encoding : int
  }

val getformat : handle -> (output_format, error_code) result
val format_none : handle -> (unit, error_code) result
val format_ : handle -> rate:int -> channels:int -> encodings:int -> (unit, error_code) result
val id3 : handle -> (id3_v1 option * id3_v2 option, error_code) result
