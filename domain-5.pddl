(define (domain mine-world)
    (:requirements :adl)

    (:types 
        tile mineBot lift item estation - object
        hammer ore fstopper - item 
    )

    (:predicates
        (Linked ?s - tile ?t - tile)
        (Blocked ?i - item)
        (Holding ?b - mineBot ?i - item)
        (FullInv ?m - mineBot)
        (On ?b - object ?t - tile)
        (ItemOn ?i - item ?t - tile)
        (LiftActive ?l - lift)
        (Mined ?o - ore)
        (OnFire ?t - tile)
        (Heavy ?o - item)
        (Different ?x ?y - object)
    )

    (:functions
    (energy ?r - mineBot)
    (durability ?h - hammer)
    )

    (:action MOVE
        :parameters (?s ?t - tile ?m - mineBot)
        :precondition (and
            (On ?m ?s) 
            (Linked ?s ?t)
            (> (energy ?m) 0)
            (not (FullInv ?m))
            (not (OnFire ?t))
        )
        :effect (and
            (not (On ?m ?s))
            (On ?m ?t) 
            (decrease (energy ?m) 1)
        )
    )

    (:action MOVE-WHILE-HOLDING
        :parameters (?s ?t - tile ?m - mineBot ?i - item)
        :precondition (and
            (On ?m ?s)
            (Linked ?s ?t)
            (> (energy ?m) 2)
            (Holding ?m ?i)
            (not (OnFire ?t))
            (not (Heavy ?i))
        )
        :effect (and 
            (not (On ?m ?s))
            (On ?m ?t)
            (decrease (energy ?m) 3)
        )
    )

    (:action CARRY-TOGETHER
        :parameters (?s ?t - tile ?m ?n - mineBot ?i - item)
        :precondition (and
            (Different ?m ?n)
            (On ?m ?s)
            (On ?n ?s)
            (Linked ?s ?t)
            (> (energy ?m) 2)
            (> (energy ?n) 2)
            (Holding ?m ?i)
            (Holding ?n ?i)
            (Heavy ?i)
        )
        :effect (and 
            (not (On ?m ?s))
            (not (On ?n ?s))
            (On ?m ?t)
            (On ?n ?t)
            (decrease (energy ?m) 3)
            (decrease (energy ?n) 3)
        )
    )

    (:action PICKUP
        :parameters (?i - item ?t - tile ?m - mineBot)
        :precondition (and
            (not (FullInv ?m)) 
            (not (Blocked ?i)) 
            (not (Heavy ?i))
            (On ?m ?t) 
            (ItemOn ?i ?t)
            )
        :effect (and
            (not (ItemOn ?i ?t)) 
            (Holding ?m ?i)
            (FullInv ?m)
        )
    )

    (:action PICKUP-TOGETHER
        :parameters (?o - ore ?t - tile ?m ?n - mineBot)
        :precondition (and
            (Different ?m ?n)
            (not (FullInv ?m))
            (not (FullInv ?n))
            (not (Blocked ?o))
            (Heavy ?o)
            (On ?m ?t)
            (On ?n ?t)
            (ItemOn ?o ?t)
            )
        :effect (and
            (not (ItemOn ?o ?t))
            (Holding ?m ?o)
            (Holding ?n ?o)
            (FullInv ?m)
            (FullInv ?n)
        )
    )

    (:action DROP
        :parameters (?i - item ?t - tile ?m - mineBot)
        :precondition (and 
            (Holding ?m ?i)
            (On ?m ?t)
        )
        :effect (and
            (not (Holding ?m ?i))
            (ItemOn ?i ?t)
            (not (FullInv ?m))
        )
    )
    
    (:action BREAK
        :parameters (?o - ore ?t - tile ?h - hammer ?m - mineBot)
        :precondition (and
            (Holding ?m ?h)
            (> (durability ?h) 0)
            (Blocked ?o)
            (On ?m ?t)
            (ItemOn ?o ?t)
        )
        :effect (and
            (not (Blocked ?o))
            (decrease (durability ?h) 1)
        )
    )

    (:action ACTIVATE_LIFT
        :parameters (?t - tile ?l - lift ?m - mineBot)
        :precondition (and
            (not (LiftActive ?l))
            (On ?m ?t)
            (On ?l ?t)
            )
        :effect (LiftActive ?l)
    )
    
    (:action MINE
        :parameters (?t - tile ?o - ore ?m - mineBot ?l - lift)
        :precondition (and
            (Holding ?m ?o)
            (LiftActive ?l)
            (On ?m ?t)
            (On ?l ?t)
            (not (Mined ?o))
        )
        :effect (and 
            (not(Holding ?m ?o))
            (Mined ?o)
            (not (FullInv ?m))
        )
    )

    (:action RECHARGE
        :parameters (?t - tile ?e - estation ?m - minebot)
        :precondition (and
            (On ?m ?t)
            (On ?e ?t)
            )
        :effect (assign (energy ?m) 40)
    )

    (:action REPAIR
        :parameters (?t - tile ?e - estation ?h - hammer ?m - minebot)
        :precondition (and
            (On ?m ?t)
            (On ?e ?t)
            (Holding ?m ?h)
            )
        :effect (assign (durability ?h) 2)
    )

    (:action STOP-FIRE
        :parameters (?s ?t - tile ?f - fstopper ?m - minebot)
        :precondition (and
            (On ?m ?s)
            (Holding ?m ?f)
            (OnFire ?t)
            (Linked ?s ?t)
        )
        :effect (and 
            (not (OnFire ?t))
        )
    )
)