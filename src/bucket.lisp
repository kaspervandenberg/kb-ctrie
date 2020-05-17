(in-package :kb-ctrie)

(defmacro defstruct-bucket (size)
  "Define a `BUCKET' that can hold upto `SIZE' elements."
  (defvar *bucket-size* size
    "The number of elements that `BUCKET' can store.")
  `(defstruct bucket
    "Efficiently hold upto `*BUCKET-SIZE*' indexed elements.
         The size of `BUCKET' is the number of elements it contains;
         empty indexes do not take space."
    (filled-indexes-bitmap 0
     :type ,(if (<= size (integer-length most-positive-fixnum))
		'fixnum
		'integer)
     :read-only t)
    (elements nil
     :type simple-vector
     :read-only t)))
