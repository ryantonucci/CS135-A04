;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname examples-a04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;2a
(check-expect (count-vowels "Rick ate an apple") 6)
(check-expect (count-vowels "Every easy problem was solved") 9)
(check-expect (count-vowels "N vwls") 0)

;;2b
(check-expect (sorted? (cons "Amazing" (cons "zebra" empty))) true)
(check-expect (sorted? (cons "Case" (cons "Base" empty))) false)
(check-expect (sorted? (cons "Zebra" (cons "zebra" empty))) true)
(check-expect (sorted? (cons "a lion is a cat" (cons "A lion is a cat" empty))) false)
(check-expect (sorted? (cons "Amazing" (cons "Crazy" (cons "Baseball" empty)))) false)
(check-expect (sorted? empty) true)
(check-expect (sorted? (cons "Lunch" empty)) true)

;;2c
(check-expect (replace-word "good" "bad" (cons "My" (cons "exam" (cons "went" (cons "bad" empty)))))
              (cons "My" (cons "exam" (cons "went" (cons "good" empty)))))
(check-expect (replace-word "UW" "UofT" (cons "UofT" empty)) (cons "UW"))
(check-expect (replace-word "amazing" "poorly" (cons "poorly" (cons "amazing" (cons "poorly" empty))))
              (cons "amazing" (cons "amazing" (cons "amazing" empty))))

;;2d
(check-expect (remove-duplicates (cons 2 (cons 3 (cons 2 empty)))) (cons 3 (cons 2 empty)))
(check-expect (remove-duplicates (cons 5 (cons 4 (cons 3 (cons 2 empty)))))
              (cons 5 (cons 4 (cons 3 (cons 2 empty)))))
(check-expect (remove-duplicates (cons 2 (cons 2 (cons 2 (cons 2 empty))))) (cons 2 empty))

;;3a
(check-expect (card? 'wwwww) false)
(check-expect (card? 'king) false)
(check-expect (card? 1) false)
(check-expect (card? 6) true)
(check-expect (card? 'Queen) true)

(check-expect (card=? 4 7) false)
(check-expect (card=? 7 7) true)
(check-expect (card=? 'King 5) false)
(check-expect (card=? 'King 'Ace) false)
(check-expect (card=? 'Jack 'Jack) true)

;;3b
(check-expect (sort-cards (list 3 'King 6 7 'Queen 3 Ace 2)) (list 3 3 6 7 'Queen 'King 'Ace 2))
(check-expect (sort-cards (list 2 2 3 'Ace 'Red 'Black 'Jack)) (list 3 'Jack 'Ace '2 2 'Black 'Red))
(check-expect (sort-cards (list 3 4 5 6 7)) (list 3 4 5 6 7))

;;3c
(check-expect (remove-one-of-each (list 3 3 4 6 9 'Jack 'Ace)) (list 3))
(check-expect (remove-one-of-each (list 3 3 4 6 9 'Jack 'Jack 'Jack 'Ace 'Ace)) (list 3 'Jack 'Jack 'Ace))
(check-expect (remove-one-of-each (list 3 3 3 3 3 4 6 9 'Jack 'Jack 'Jack 'Ace 'Ace)) (list 3 3 3 3 'Jack 'Jack 'Ace))
(check-expect (remove-one-of-each (list 3  4 6 9 'Jack 'Ace)) (list))

;;3d
(check-expect (find-kind 2 (list 4 4 7 8 'Jack 'Jack)) (list 4 'Jack))
(check-expect (find-kind 5 (list 4 4 4 4 4 7 8 'Jack 'Jack)) (list 4))
(check-expect (find-kind 1 (list 4 4 7 8 'Jack 'Jack)) (list 4 7 8 'Jack))
(check-expect (find-kind 2 (list 5 5 6 7 8 8 'Ace 'Ace 'Black)) (list 5 8 'Ace))

;;4b
(check-expect (div-by-3? 6) true)
(check-expect (div-by-3? 1404) true)
(check-expect (div-by-3? 7) false)
(check-expect (div-by-3? 2923) false)



