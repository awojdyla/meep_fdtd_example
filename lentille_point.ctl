(define-param rayon 15.0)
(define-param tkns 1.0)
(define-param indice 2.0)

(define-param w (/ (sqrt (* tkns (-(* 2 rayon) tkns))) 1.5 ) )

(set! geometry-lattice (make lattice (size 32 16  no-size)))

(set! geometry (list
	(make sphere (center (+ (- rayon tkns ) 8)  8) (radius rayon)
		(material (make dielectric (epsilon (sqr indice) )))
	)
	(make block (center 0 0) (size 32 infinity infinity)
		(e1 1 0 0)(e2 0 1 0)(e3 0 0 1)
		(material (make dielectric (epsilon 1)))
	)
))


(set! sources (list
	(make source
		(src (make gaussian-src (frequency 2) (fwidth 1)))
		(component Ez)
                (center -15 0)
	)
))

(set! pml-layers (list (make pml (thickness 1.0))))

(set! resolution 25)

(run-until 10 
	(at-beginning output-epsilon)
	(at-every 0.2 (output-png Ez "-Zc dkbluered -A $EPS -a gray:0.3"))
)
