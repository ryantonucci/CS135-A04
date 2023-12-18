;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname cardgame) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;Q3a
;;(card? Any) produces true if the value is a valid card.
;;Examples
(check-expect (card? 5) true)
(check-expect (card? -3) false)
;;card?: Any->Bool

(define (card? Any)
  (cond 
    [(and (number? Any) (integer? Any) (>= Any 2) (<= Any 10)) true]
    [(and (symbol? Any) (or (symbol=? Any 'Jack) (symbol=? Any 'Queen)
                            (symbol=? Any 'King)(symbol=? Any 'Ace)
                            (symbol=? Any 'Black) (symbol=? Any 'Red))) true]
    [else false]))

(check-expect (card? 'Jack) true)
(check-expect (card? 'Rick) false)
(check-expect (card? 5.33) false)

;;(card=? card1 card2) checks if the two cards are the same
;;Examples
(check-expect (card=? 'Jack 'Jack) true)
(check-expect (card=? 4 7) false)
;;card=?: (Any Any)->Bool

(define (card=? card1 card2)
  (cond [(and (number? card1) (number? card2) (= card1 card2)) true]
        [(and (symbol? card1) (symbol? card2) (symbol=? card1 card2)) true]
        [else false]))

(check-expect (card=? 4 4) true)
(check-expect (card=? 'King 'Ace) false)

;;3b
;;(sort-cards list-of-cards) Consumes a list of card and sorts the cards
;;Examples
(check-expect (sort-cards(list 3 'King 6 7 'Jack 'Queen 2 7 3 7 3 'Ace 'Jack 2 3 4 5))
              (list 3 3 3 3 4 5 6 7 7 7 'Jack 'Jack 'Queen 'King 'Ace 2 2))
(check-expect (sort-cards (list 2 2 3 'Ace 'Red 'Black 'Jack))
              (list 3 'Jack 'Ace 2 2 'Black 'Red))
;;sort-cards: (listof Any)->(listof Any)

(define (sort-cards list-of-cards)
  (Num->Sym (sort-numbers (Sym->Num list-of-cards)))) 

(check-expect (sort-cards (list 9 7 2 3 'Queen 'Red))
              (list 3 7 9 'Queen 2 'Red))
(check-expect (sort-cards (list 'Red 'Black 'Queen 2 5 'Red))
              (list 5 'Queen 2 'Black 'Red 'Red))

                        
(define (Sym->Num list-of-cards)  ;Changes cards from symbols or numbers to number values.
  (cond [(empty? list-of-cards) empty]
        [else (cons (card->value (first list-of-cards))
                                     (Sym->Num (rest list-of-cards)))]))

(check-expect (Sym->Num (list 'Ace 'King 2 4)) (list 14 13 15 4))


(define (Num->Sym list-of-cards-as-num)  ;Changes cards from there number valuer to symbol
  (cond [(empty? list-of-cards-as-num) empty]
        [(cons? list-of-cards-as-num) (cons (value->card (first list-of-cards-as-num))
                                            (Num->Sym (rest list-of-cards-as-num)))]))

(check-expect (Sym->Num (list 4 'Jack 'Ace 7)) (list 4 11 14 7))
(check-expect (Sym->Num (list 'Red 'Jack 'Ace 2)) (list 17 11 14 15))
                        

(define (sort-numbers list-of-number-cards) ;As provided in slides
  (cond [(empty? list-of-number-cards) empty]
        [else (insert (first list-of-number-cards)
                      (sort-numbers (rest list-of-number-cards)))]))

(define (insert n slon)   ;As Provided in slides
  (cond [(empty? slon) (cons n empty)]
        [(<= n (first slon)) (cons n slon)]
        [else (cons (first slon) (insert n (rest slon)))]))
  
(define (card->value card)  ;Takes a card and gives it a value
  (cond [(and (number? card) (>= card 3) (<= card 10)) card]
        [(and (number? card) (= card 2)) 15]
        [(symbol=? card 'Jack) 11]
        [(symbol=? card 'Queen) 12]
        [(symbol=? card 'King) 13]
        [(symbol=? card 'Ace) 14]
        [(symbol=? card 'Black) 16] ;Note a space is left to insert 2 cards.
        [(symbol=? card 'Red) 17]))

(check-expect (card->value 2) 15)
(check-expect (card->value 6) 6)
(check-expect (card->value 'Jack) 11)

(define (value->card card-as-num)
  (cond [(and (>= card-as-num 3) (<= card-as-num 10)) card-as-num]
        [(= card-as-num 11) 'Jack]
        [(= card-as-num 12) 'Queen]
        [(= card-as-num 13) 'King]
        [(= card-as-num 14) 'Ace]
        [(= card-as-num 15) 2]
        [(= card-as-num 16) 'Black]
        [(= card-as-num 17) 'Red]))
        
;;Q3c
;;(remove-one-of-each list-of-cards) elimates one of each card
;;Examples
(check-expect (remove-one-of-each (list 3 3 4 6 9 'Jack 'Ace)) (list 3))
(check-expect (remove-one-of-each (list 3 3 4 6 9 'Jack 'Jack 'Jack 'Ace 'Ace)) (list 3 'Jack 'Jack 'Ace))
;;remove-one-of-each: listof Any->listof Any
;;Requires listof Any to a sorted deck according to game rules.

(define (remove-one-of-each list-of-cards)  
  (cond [(empty? list-of-cards) empty]
        [(member? (first list-of-cards) (rest list-of-cards))
         (cons (first list-of-cards) (remove-one-of-each (rest list-of-cards)))]
        [else (remove-one-of-each (rest list-of-cards))]))

(check-expect (remove-one-of-each (list 5 7 8)) (list))
(check-expect (remove-one-of-each (list 5 7 7 8)) (list 7))
(check-expect (remove-one-of-each (list 5 5 5 7 7 8 9 9)) (list 5 5 7 9))




;;3d
;;(find-kind n list-of-cards) finds cards which have n number of instances or more
;;Examples
(check-expect (find-kind 2 (list 4 4 7 8 'Jack 'Jack)) (list 4 'Jack))
(check-expect (find-kind 5 (list 4 4 4 4 4 4 7 8 'Jack 'Jack)) (list 4))
;;find-kind: (Num listof Any)->(listof Any)
;;Requires n>=1 and list-of-cards to be sorted according to game rules.

(define (find-kind n list-of-cards)
  (cond [(empty? list-of-cards) empty]
        [(= n 1) (one-instance list-of-cards)] ;should return one instance of each card
        [(<= n (length (count-instances (first list-of-cards) list-of-cards)))
         (one-instance (cons (first list-of-cards) (find-kind n (rest list-of-cards))))]
        [else (find-kind n (rest list-of-cards))]))
        
(check-expect (find-kind 1 (list 4 4 7 8 'Jack 'Jack)) (list 4 7 8 'Jack))
(check-expect (find-kind 2 (list 5 5 6 7 8 8 'Ace 'Ace 'Black)) (list 5 8 'Ace))
(check-expect (find-kind 3 (list 5 5 5 5 6 7 8 8 8 'Ace 'Ace 'Black 'Red)) (list 5 8))
(check-expect (find-kind 2 (list 5 5 6 7 8 8 'Ace 'Ace 2 2 2 'Black)) (list 5 8 'Ace 2))

(define (one-instance list-of-cards) ;Returns the list of cards without multiple instances of the same card
  (cond [(empty? list-of-cards) empty]
        [(member? (first list-of-cards) (rest list-of-cards)) (one-instance (rest list-of-cards))]
        [else (cons (first list-of-cards) (one-instance (rest list-of-cards)))]))

(check-expect (one-instance (list 4 4 5 9 9 'Jack 'Queen 'Queen)) (list 4 5 9 'Jack 'Queen))
(check-expect (one-instance (list 4 5 9 'Jack  'Queen)) (list 4 5 9 'Jack 'Queen))
(check-expect (one-instance (list 4 4 4 4 5 9 9 9 9 9 'Jack 'Queen 'Queen)) (list 4 5 9 'Jack 'Queen))


(define (count-instances element list-of-cards) ;Creates a list of element in list-of-cards
  (cond [(empty? list-of-cards) empty]
        [(cond [(and (number? element) (number? (first list-of-cards)))
                (= element (first list-of-cards))]
               [(and (symbol? element) (symbol? (first list-of-cards))) (symbol=? element (first list-of-cards))] 
               [else false])
         (cons element (count-instances element (rest list-of-cards)))]
        [(cons? list-of-cards) (count-instances element (rest list-of-cards))])) 
