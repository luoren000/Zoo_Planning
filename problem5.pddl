(define (problem zoo5)
  (:domain gordon-ramzoo)
  (:objects
    tiger - carnivore
    giraffe - herbivore
    chimpanzee - omnivore
    exhibit1 exhibit2 exhibit3 exhibit4 - animallocation
    room1 room2 room3 room4 - room
    pantry1 - pantry
    robot1 robot2 - robot
    trolley1 - trolley
    steak1 fish1 - meat
    leaves1 - veggies
  )

  (:init
    (connected exhibit1 exhibit2)
    (connected exhibit2 exhibit1)
    (connected exhibit3 exhibit4)
    (connected exhibit4 exhibit3)

    (connected exhibit1 room1)
    (connected room1 exhibit1)
    (connected exhibit2 room1)
    (connected room1 exhibit2)
    (connected room1 exhibit3)
    (connected exhibit3 room1)
    (connected room1 exhibit4)
    (connected exhibit4 room1)

    (connected room1 pantry1)
    (connected pantry1 room1)
    (connected pantry1 room2)
    (connected room2 pantry1)
    (connected pantry1 room3)
    (connected room3 pantry1)
    (connected pantry1 room4)
    (connected room4 pantry1)

    (animal-at giraffe room2)
    (animal-at chimpanzee room3)
    (animal-at tiger room4)

    (hungry tiger)
    (hungry chimpanzee)
    (hungry giraffe)

    (robot-at robot1 exhibit4)
    (robot-at robot2 exhibit1)

    (no-robot exhibit1)

    (no-robot exhibit2)
    (no-robot exhibit3)
    (no-robot room1)
    (no-robot room2)
    (no-robot room3)
    (no-robot room4)
    (no-robot pantry1)

    (free robot1)
    (free robot2)

    (trolley-at trolley1 pantry1)
    (no-trolley exhibit1)
    (no-trolley exhibit2)
    (no-trolley exhibit3)
    (no-trolley exhibit4)
    (no-trolley room1)
    (no-trolley room2)
    (no-trolley room3)
    (no-trolley room4)

    (no-visitors room1)
    (no-visitors room2)
    (no-visitors room3)
    (no-visitors room4)
    (no-visitors exhibit1)
    (no-visitors exhibit2)
    (no-visitors exhibit3)
    (no-visitors exhibit4)
    (no-visitors pantry1)

    (food-at steak1 pantry1)
    (food-at fish1 pantry1)
    (food-at leaves1 pantry1)

    (no-animal exhibit1)
    (no-animal exhibit2)
    (no-animal exhibit3)
    (no-animal exhibit4)
  )

  (:goal (
    and
        (not(hungry giraffe))
        (not(hungry tiger))
        (not(hungry chimpanzee))
    )
  )
)