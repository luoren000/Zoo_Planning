(define (problem zoo2)
    ;; feed the carnivores and the herbivores
    ;; get food from store and pantry if required
    (:domain gordon-ramzoo)
    (:objects
        tiger1 tiger2 - carnivore
        panda1 panda2 giraffe1 - herbivore
        tigerpen1 pandapen1 giraffepen1 - animallocation
        pantry1 - pantry
        store1 - store
        robot1 - robot
        trolley1 - trolley
        meat1 meat2 - meat
        veggie1 veggie2 veggie3 - veggies
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

        (robot-at robot1 pantry1)
        (no-robot store1)
        (no-robot tigerpen1)
        (no-robot pandapen1)
        (no-robot giraffepen1)

        (trolley-at trolley1 pantry1)
        (no-trolley store1)
        (no-trolley tigerpen1)
        (no-trolley pandapen1)
        (no-trolley giraffepen1)

        (animal-at tiger1 tigerpen1)
        (animal-at tiger2 tigerpen1)
        (animal-at panda1 pandapen1)
        (animal-at panda2 pandapen1)
        (animal-at giraffe1 giraffepen1)

        (food-at meat1 pantry1)
        (food-at meat2 store1)
        (food-at veggie1 pantry1)
        (food-at veggie2 store1)
        (food-at veggie3 store1)

        (hungry tiger1)
        (hungry tiger2)
        (hungry panda1)
        (hungry panda2)
        (hungry giraffe1)

        (free robot1)

        (no-person tigerpen1) 
        (no-person pandapen1) 
        (no-person giraffepen1)
        (no-person pantry1)
        (no-person store1)
    )
    (:goal (
        and
            (not(hungry tiger1))
            (not(hungry tiger2))
            (not(hungry panda1))
            (not(hungry panda2))
            (not(hungry giraffe1))
        )
    )
)
