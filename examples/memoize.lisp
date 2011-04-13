(in-package :cl-cache-example)
(use-syntax annot-syntax)

(defun tak (x y z)
  (if (<= x y)
      z
      (tak (tak (1- x) y z)
           (tak (1- y) z x)
           (tak (1- z) x y))))

(defun tak/with-cache (x y z)
  (with-cache ((list x y z))
    (if (<= x y)
        z
        (tak (tak (1- x) y z)
             (tak (1- y) z x)
             (tak (1- z) x y)))))

@cache ((x y z))
(defun tak/cache-annotation (x y z)
  (if (<= x y)
      z
      (tak (tak (1- x) y z)
           (tak (1- y) z x)
           (tak (1- z) x y))))

#|

Sample output:

    CL-CACHE-EXAMPLE> (time (tak 20 10 0))
    (TAK 20 10 0) took 1,345,999 microseconds (1.345999 seconds)
    CL-CACHE-EXAMPLE> (time (tak/with-cache 20 10 0))
    (TAK/WITH-CACHE 20 10 0) took 30 microseconds (0.000030 seconds)
    CL-CACHE-EXAMPLE> (time (tak/cache-annotation 20 10 0))
    (TAK/CACHE-ANNOTATION 20 10 0) took 32 microseconds (0.000032 seconds)

|#
