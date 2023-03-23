(define (problem mine-problem)
    (:domain mine-world)
    (:objects
        A B C D - ore
        Hammer - hammer
        Bot1 Bot2 - mineBot
        Lift - lift
        Energy-Station - estation
        Fstopper - fstopper
        t1 t2 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 - tile
    )

    (:init
        (ItemOn A t1)
        (ItemOn B t3)
        (ItemOn C t10)
        (ItemOn D t13)
        
        (Blocked B)
        (Blocked C)
        (Blocked D)

        (Heavy D)

        (On Bot1 t17)
        (On Bot2 t4)
        (Different Bot1 Bot2)

        (= (energy Bot1) 40)
        (= (energy Bot2) 40)

        (ItemOn Hammer t8)
        (= (durability Hammer) 2)
        (ItemOn Fstopper t14)

        (On Lift t23)
        (OnFire t7)
        (On Energy-Station t12)

        (Linked t1 t5) (Linked t5 t1)
        (Linked t5 t4) (Linked t4 t5)
        (Linked t5 t6) (Linked t6 t5)
        (Linked t4 t9) (Linked t9 t4)
        (Linked t9 t8) (Linked t8 t9)
        (Linked t9 t13) (Linked t13 t9)
        (Linked t13 t14) (Linked t14 t13)
        (Linked t14 t15) (Linked t15 t14)
        (Linked t15 t10) (Linked t10 t15)
        (Linked t10 t6) (Linked t6 t10)
        (Linked t15 t18) (Linked t18 t15)
        (Linked t15 t16) (Linked t16 t15)
        (Linked t18 t20) (Linked t20 t18)
        (Linked t20 t21) (Linked t21 t20)
        (Linked t21 t23) (Linked t23 t21)
        (Linked t21 t22) (Linked t22 t21)
        (Linked t22 t19) (Linked t19 t22)
        (Linked t19 t17) (Linked t17 t19)
        (Linked t17 t16) (Linked t16 t17)
        (Linked t17 t11) (Linked t11 t17)
        (Linked t11 t12) (Linked t12 t11)
        (Linked t11 t7) (Linked t7 t11)
        (Linked t7 t2) (Linked t2 t7)
        (Linked t2 t3) (Linked t3 t2)
    )

    (:goal (and
        (Mined A)
        (Mined B)
        (Mined C)
        (Mined D)
    ))
)