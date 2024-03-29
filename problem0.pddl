(define (problem zoo0)
  ;; your trolley already holds the food
  ;; take it to the tiger
  (:domain gordon-ramzoo)
  (:objects
    tiger - carnivore
    tigerpen1 - animallocation
    pantry1 - pantry
    robot1 - robot
    trolley1 - trolley
    meat1 - meat
  )

  (:init
    (connected tigerpen1 pantry1)
    (connected pantry1 tigerpen1)
    (robot-at robot1 pantry1)
    (no-robot tigerpen1)
    (trolley-at trolley1 pantry1)
    (no-trolley tigerpen1)
    (animal-at tiger tigerpen1)
    (trolley-holding trolley1 meat1)
    (hungry tiger)
    (free robot1)
    
    (no-visitors tigerpen1)
    (no-visitors pantry1)
  )
  (:goal
    (not(hungry tiger))
  )
)