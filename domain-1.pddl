(define (domain mine-world)
    (:requirements :adl)

    (:types 
        tile mineBot lift item - object
        hammer ore - item 
    )

    (:predicates
        (Linked ?s - tile ?t - tile)
        (Blocked ?i - item)
        (Holding ?b - mineBot ?i - item)
        (FullInv ?m - mineBot)
        (On ?b - object ?t - tile)
        (ItemOn ?i - item ?t - tile)
        (LiftActive ?l - lift)
        (Mined ?o)
    )

    (:action MOVE
        :parameters (?s ?t - tile ?m - mineBot)
        :precondition (and
            (On ?m ?s) 
            (Linked ?s ?t)
        )
        :effect (and
            (not (On ?m ?s))
            (On ?m ?t) 
        )
    )

    (:action PICKUP
        :parameters (?i - item ?t - tile ?m - mineBot)
        :precondition (and
            (not (FullInv ?m)) 
            (not (Blocked ?i)) 
            (On ?m ?t) 
            (ItemOn ?i ?t)
            )
        :effect (and
            (not (ItemOn ?i ?t)) 
            (Holding ?m ?i)
            (FullInv ?m)
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
            (Blocked ?o)
            (On ?m ?t)
            (ItemOn ?o ?t)
        )
        :effect (and
            (not (Blocked ?o))
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
)