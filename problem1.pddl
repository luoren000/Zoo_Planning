(define (problem zoo1)
    ;; feed the tigers
    ;; some food is in the pantry, some is at the store
    (:domain gordon-ramzoo)
    (:objects
        tiger1 tiger2 - carnivore
        tigerpen1 - animallocation
        pantry1 - pantry
        store1 - store
        robot1 - robot
        trolley1 - trolley
        meat1 meat2 - meat
    )

    (:init
        (connected tigerpen1 pantry1)
        (connected pantry1 tigerpen1)
        (connected pantry1 store1)
        (connected store1 pantry1)
        (vacant tigerpen1)
        (vacant store1)
        (robot-at robot1 pantry1)
        (trolley-at trolley1 pantry1)
        (animal-at tiger1 tigerpen1)
        (animal-at tiger2 tigerpen1)
        (food-at meat1 pantry1)
        (food-at meat2 store1)
        (hungry tiger1)
        (hungry tiger2)
        (free robot1)
    )
    (:goal (
        and
            (not(hungry tiger1))
            (not(hungry tiger2))
        )
    )
)