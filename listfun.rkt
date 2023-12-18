;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname listfun) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Q2a
;; (count-vowels Str) takes a string and counts the number of vowels in it.
;;Examples
(check-expect (count-vowels "Rick ate an apple") 6)
(check-expect (count-vowels "the quick brown fox jumped over the lazy dog") 12)
;;count-vowels: Str->Nat

(define (count-vowels string)
  (length (list-of-vowels (string->list string))))

(check-expect (count-vowels "N vwls") 0)
(check-expect (count-vowels "Every easy problem was solved") 9)

(define (list-of-vowels loc)  ;Make a list of vowels in the sentence
  (cond [(empty? loc) empty]
        [(vowel? (first loc)) (cons (first loc) (list-of-vowels (rest loc)))]
        [else (list-of-vowels (rest loc))]))

(check-expect (list-of-vowels (list #\u #\I #\w #\a)) (cons #\u (cons #\I (cons #\a empty))))
(check-expect (list-of-vowels (list #\p #\y #\U #\E #\w #\i)) (cons #\U (cons #\E (cons #\i empty))))

(define (vowel? char) ;compares a char to see if it is a vowel
  (cond [(or (char=? char #\A) (char=? char #\E) (char=? char #\I)
             (char=? char #\O) (char=? char #\U) (char=? char #\a)
             (char=? char #\e) (char=? char #\i) (char=? char #\o)
             (char=? char #\u)) true]
        [else false]))
  
(check-expect (vowel? #\u) true)
(check-expect (vowel? #\z) false)
        
;;Q2b
;;(sorted? list-of-strings) checks to see if the list is sorted in lexicographic order
(check-expect (sorted? (cons "Amazing" (cons "zebra" empty))) true)
(check-expect (sorted? (cons "Case" (cons "Base" empty))) false)
;;sorted?: (listof Str)->Bool

(define (sorted? list-of-strings)
  (cond [(empty? list-of-strings) true]
        [(= (length list-of-strings) 1) true]
        [(not (string<? (first list-of-strings) (first (rest list-of-strings)))) false]
        [else (sorted? (rest list-of-strings))]))

(check-expect (sorted? (cons "Zebra" (cons "zebra" empty))) true)
(check-expect (sorted? (cons "a lion is a cat" (cons "A lion is a cat" empty))) false)
(check-expect (sorted? (cons "Amazing" (cons "Crazy" (cons "Baseball" empty)))) false)
(check-expect (sorted? empty) true)
(check-expect (sorted? (cons "Lunch" empty)) true)
(check-expect (sorted? (cons "lunch" (cons "Lunch" empty))) false)
(check-expect (sorted? (cons "hello" (cons "Hello" empty))) false)
(check-expect (sorted? (cons "Hi" (cons "hello"(cons "how are you" empty)))) true)
(check-expect (sorted? (cons "hello" (cons "hello" (cons "hey"(cons "hi" empty))))) false)
(check-expect (sorted? (cons "7" (cons "8" empty))) true)

;;Q2c
;;(replace-word string1 string2 list-of-strings) replaces the string1 with string2 when string1 
;;shows up in list-of-strings
;;Examples
(check-expect (replace-word "bad" "good" (cons "My" (cons "exam" (cons "went" (cons "bad" empty)))))
              (cons "My" (cons "exam" (cons "went" (cons "good" empty)))))
(check-expect (replace-word "poorly" "amazing" (cons "poorly" (cons "amazing" (cons "poorly" empty))))
              (cons "amazing" (cons "amazing" (cons "amazing" empty))))
;;replace-word (Str Str listof Str)->listof Str

(define (replace-word string1 string2 list-of-strings)
  (cond [(empty? list-of-strings) empty]
        [(string=? string1 (first list-of-strings))
         (cons string2 (replace-word string1 string2 (rest list-of-strings)))]
        [else (cons (first list-of-strings)
                    (replace-word string1 string2 (rest list-of-strings)))]))

(check-expect (replace-word "UofT" "UW" (cons "UofT" empty)) (cons "UW" empty))
(check-expect (replace-word "UofT" "UW" (cons "UofT" (cons "Western" empty))) (cons "UW" (cons "Western" empty)))

;;2d
;;(remove-duplicates list) only keeps the last instance of a element
;;Examples
(check-expect (remove-duplicates (cons 2 (cons 3 (cons 2 empty)))) (cons 3 (cons 2 empty)))
(check-expect (remove-duplicates (cons 5 (cons 4 (cons 3 (cons 2 empty)))))
              (cons 5 (cons 4 (cons 3 (cons 2 empty)))))
;;remove-duplicates: listof Any->listof Any

(define (remove-duplicates list)
  (cond [(empty? list) empty]
        [(member? (first list) (rest list)) (remove-duplicates (rest list))]
        [else (cons (first list) (remove-duplicates (rest list)))]))

(check-expect (remove-duplicates (cons 'Rick (cons 'Bob (cons 'Rick (cons 'John empty)))))
              (cons 'Bob (cons 'Rick (cons 'John empty))))
(check-expect (remove-duplicates (cons "Cool" (cons "Not cool" (cons "Cool" (cons "Cool" empty)))))
              (cons "Not cool" (cons "Cool" empty)))
