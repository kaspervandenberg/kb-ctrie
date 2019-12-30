#!/bin/bash
sbcl --noinform \
     --eval "\
     (progn
          (ql:quickload :kb-ctrie)\
     	  (ql:quickload :kb-ctrie-test)\
	  (asdf:test-system :kb-ctrie))"\
     --quit \
| sed -e 's/\x1b\[90m/\x1b\[92m/g'
