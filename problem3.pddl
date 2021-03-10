(define (problem zoo3)
    ;; feed the carnivores and the herbivores
    ;; get food from store and pantry if required
    (:domain gordon-ramzoo)
    (:objects
        tiger1 tiger2 - carnivore
        panda1 panda2 giraffe1 - herbivore
        bear1 bear2 - omnivore
        tigerpen1 pandapen1 giraffepen1 bearpen1 - animallocation
        pantry1 - pantry
        store1 - store
        robot1 - robot
        trolley1 - trolley
        meat1 meat2 meat3 - meat
        veggie1 veggie2 veggie3 veggie4 - veggies
    )

    (:init
        (connected tigerpen1 pantry1)
        (connected pantry1 tigerpen1)
        (connected pantry1 store1)
        (connected store1 pantry1)
        (connected pandapen1 tigerpen1)
        (connected tigerpen1 pandapen1)
        (connected giraffepen1 tigerpen1)
        (connected tigerpen1 giraffepen1)
        (connected bearpen1 tigerpen1)
        (connected tigerpen1 bearpen1)

        (vacant tigerpen1)
        (vacant pandapen1)
        (vacant giraffepen1)
        (vacant bearpen1)
        ;; (vacant pantry1)

        (robot-at robot1 pantry1)

        (trolley-at trolley1 store1)

        (animal-at tiger1 tigerpen1)
        (animal-at tiger2 tigerpen1)
        (animal-at panda1 pandapen1)
        (animal-at panda2 pandapen1)
        (animal-at giraffe1 giraffepen1)
        (animal-at bear1 bearpen1)
        (animal-at bear2 bearpen1)


        (food-at meat1 pantry1)
        (food-at meat2 pantry1)
        (food-at meat3 pantry1)

        (food-at veggie1 pantry1)
        (food-at veggie2 pantry1)
        (food-at veggie3 pantry1)
        (food-at veggie4 pantry1)

        (hungry tiger1)
        (hungry tiger2)
        (hungry panda1)
        (hungry panda2)
        (hungry giraffe1)
        (hungry bear1)
        (hungry bear2)

        (free robot1)
    )
    (:goal (
        and
            (not(hungry tiger1))
            (not(hungry tiger2))
            (not(hungry panda1))
            (not(hungry panda2))
            (not(hungry giraffe1))
            (not(hungry bear1))
            (not(hungry bear2))
        )
    )
)