(define (domain gordon-ramzoo)
  (:requirements :typing :negative-preconditions :existential-preconditions)

  (:types
    carnivore herbivore omnivore - animal
    meat veggies - food
    robot trolley - moveable
    store pantry animallocation room - location
    tour-bus - visitors
  )

  (:predicates
    ;; determines whether an animal needs to be fed
    (hungry ?x - animal)

    (robot-at ?x - robot ?y - location)

    (animal-at ?x - animal ?y - location)

    (food-at ?x - food ?y - location)

    ;; indicates visitors at a location
    (visitors-at ?x - visitors ?y - location)

    ;; indicates that a location does not have visitors there
    (no-visitors ?x - location)

    (connected ?x - location ?y - location)

    ;; indicates that a robot is pushing a trolley
    (pushing-trolley ?x - robot ?y - trolley)

    ;; indicates that a trolley is holding a food item
    (trolley-holding ?x - trolley ?y - food)
    (trolley-at ?x - trolley ?y - location)

    ;;;;(eats ?x - animal ?y - food)

    ;; indicates that a location does not have a trolley
    ;;;;(vacant ?x - location)
    (no-trolley ?x - location)

    ;; indicated that a location does not have a robot
    (no-robot ?x - location)

    (no-animal ?x - animallocation)

    ;; indicates that a robot is not pushing a trolley
    (free ?x - robot)

    ;; indicates that a robot is holding an animal
    (holding-animal ?x - robot ?y - animal)

    ;; indicates that this location is a store or a pantry and a visitor is not allowed to move here
    (visitors-allowed  ?x - location)
  )

  (:action feed-carnivore
    :parameters (
      ?an - carnivore
      ?aniloc - animallocation
      ?f - meat
      ?rob - robot
      ?tro - trolley
    )

    :precondition (
      and
        (hungry ?an)
        (robot-at ?rob ?aniloc)
        (animal-at ?an ?aniloc)
        (pushing-trolley ?rob ?tro)
        (trolley-holding ?tro ?f)
        (trolley-at ?tro ?aniloc)
        (not(free ?rob))
        (no-visitors ?aniloc)
    )

    :effect (
      and
        (not(hungry ?an))
        (not(trolley-holding ?tro ?f))
    )
  )

  (:action feed-herbivore
    :parameters (
      ?an - herbivore
      ?aniloc - animallocation
      ?f - veggies
      ?rob - robot
      ?tro - trolley
    )

    :precondition (
      and
        (hungry ?an)
        (robot-at ?rob ?aniloc)
        (animal-at ?an ?aniloc)
        (pushing-trolley ?rob ?tro)
        (trolley-holding ?tro ?f)
        (trolley-at ?tro ?aniloc)
        (not(free ?rob))
        (no-visitors ?aniloc)
    )

    :effect (
      and
        (not(hungry ?an))
        (not(trolley-holding ?tro ?f))
    )
  )

  (:action feed-omnivore
    :parameters (
      ?an - omnivore
      ?aniloc - animallocation
      ?f - food
      ?rob - robot
      ?tro - trolley
    )

    :precondition (
      and
        (hungry ?an)
        (robot-at ?rob ?aniloc)
        (animal-at ?an ?aniloc)
        (pushing-trolley ?rob ?tro)
        (trolley-holding ?tro ?f)
        (trolley-at ?tro ?aniloc)
        (not(free ?rob))
        (no-visitors ?aniloc)
    )

    :effect (
      and
        (not(hungry ?an))
        (not(trolley-holding ?tro ?f))
    )
  )

  (:action free-move
    :parameters (
      ?rob - robot
      ?loc1 - location
      ?loc2 - location
    )

    :precondition (
      and
        (free ?rob)
        (robot-at ?rob ?loc1)
        (connected ?loc1 ?loc2)
        (no-robot ?loc2)
    )

    :effect (
      and
        (not(robot-at ?rob ?loc1))
        (robot-at ?rob ?loc2)
        (not(no-robot ?loc2))
        (no-robot ?loc1)
        ;; (vacant ?loc1)
    )
  )

  (:action push-trolley
    :parameters (
      ?rob - robot
      ?loc1 - location
      ?loc2 - location
      ?tro - trolley
    )

    :precondition (
        and
            (not(free ?rob))
            (pushing-trolley ?rob ?tro)
            (connected ?loc1 ?loc2)
            (robot-at ?rob ?loc1)
            (trolley-at ?tro ?loc1)
            (no-robot ?loc2)
            (no-trolley ?loc2)

    )

    :effect (
      and
        (not(robot-at ?rob ?loc1))
        (robot-at ?rob ?loc2)
        (not(no-robot ?loc2))
        (no-robot ?loc1)
        (not(trolley-at ?tro ?loc1))
        (trolley-at ?tro ?loc2)
        (no-trolley ?loc1)
        (not(no-trolley ?loc2))
    )
  )

  (:action grab-trolley
    :parameters (
      ?rob - robot
      ?tro - trolley
      ?loc - location
    )

    :precondition (
      and
        (robot-at ?rob ?loc)
        (free ?rob)
        (trolley-at ?tro ?loc)
    )
    :effect (
      and
        (pushing-trolley ?rob ?tro)
        (not(free ?rob))
    )
  )

  (:action drop-trolley
    :parameters (
      ?rob - robot
      ?tro - trolley
      ?loc - location
    )

    :precondition (
      and
        (robot-at ?rob ?loc)
        (not(free ?rob))
        (pushing-trolley ?rob ?tro)
        (trolley-at ?tro ?loc)
    )
    :effect (
      and
        (not(pushing-trolley ?rob ?tro))
        (free ?rob)
    )
  )

  (:action pick-up-food
      :parameters (
        ?rob - robot
        ?tro - trolley
        ?loc - location
        ?f - food
      )
      :precondition (
        and
          (robot-at ?rob ?loc)
          (food-at ?f ?loc)
          (not(trolley-holding ?tro ?f))
          (not(free ?rob))
          (pushing-trolley ?rob ?tro)
      )
      :effect (
        and
          (not(food-at ?f ?loc))
          (trolley-holding ?tro ?f)
      )
  )

  (:action visitors-move
    :parameters (
      ?vis - visitors
      ?loc1 - location
      ?loc2 - location
    )
    :precondition (
      and
      (visitors-at ?vis ?loc1)
      (connected ?loc1 ?loc2)
      (no-visitors ?loc2)
      (visitors-allowed ?loc2)
    )
    :effect (
      and
      (visitors-at ?vis ?loc2)
      (not (no-visitors ?loc2))
      (no-visitors ?loc1)
    )
  )

  (:action grab-animal
    :parameters (
        ?rob - robot
        ?loc - location
        ?an - animal
    )

    :precondition (
        and
            (robot-at ?rob ?loc)
            (animal-at ?an ?loc)
            (free ?rob)
    )

    :effect (
        and
            (holding-animal ?rob ?an)
            (not(free ?rob))
            (not(animal-at ?an ?loc))
    )
  )

  (:action move-animal
    :parameters (
        ?rob - robot
        ?loc1 - location
        ?loc2 - location
        ?an - animal
    )

    :precondition (
        and
            (holding-animal ?rob ?an)
            (not(free ?rob))
            (robot-at ?rob ?loc1)
            (no-robot ?loc2)
            (connected ?loc1 ?loc2)
    )

    :effect (
        and
            (not(robot-at ?rob ?loc1))
            (no-robot ?loc1)
            (robot-at ?rob ?loc2)
            (not(no-robot ?loc2))
    )
  )

  (:action release-animal
    :parameters (
        ?rob - robot
        ?loc - animallocation
        ?an - animal
    )

    :precondition (
        and
            (holding-animal ?rob ?an)
            (not(free ?rob))
            (robot-at ?rob ?loc)
            (no-animal ?loc)
    )

    :effect (
        and
            (not(holding-animal ?rob ?an))
            (free ?rob)
            (animal-at ?an ?loc)
            (not(no-animal ?loc))
    )
  )


)
