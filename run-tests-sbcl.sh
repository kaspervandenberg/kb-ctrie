#!/bin/bash
sbcl --eval "\
     (progn
          (ql:quickload :kb-ctrie)\
     	  (ql:quickload :kb-ctrie-test)\
	  (asdf:test-system :kb-ctrie))"\
    --quit	  
