;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname div-by-3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;A Nat3 is 0, 1, and 2 are natural numbers any number which is three greater than a
;;natural number is a natural number.
;;nat3-template: 3n Nat3->Bool
;;Requires 3n to begin at 0
(define (nat3-template Nat3)
  (cond [(...) ...]
        [(...) ...]
        [else (nat3-template (... Nat3 ...))]))

;;(div-by-3? Nat3) takes a natural number and checks if it is divisable by 3
;;Examples
(check-expect (div-by-3? 1404) true)
(check-expect (div-by-3? 7) false)
;;div-by-3? Nat3->Bool

(define (div-by-3?  Nat3)
  (cond  [(= Nat3 3) true]
         [(< Nat3 3) false]
         [else (div-by-3?  (- Nat3 3))]))

(check-expect (div-by-3? 6) true)
(check-expect (div-by-3? 2923) false)
