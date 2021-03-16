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
    ;; an instance of robot object is at a location
    (robot-at ?x - robot ?y - location)
    ;; an instance of an animal object is at a location
    (animal-at ?x - animal ?y - location)
    ;; an instance of a food object is at a location
    (food-at ?x - food ?y - location)
    ;; an instance of a visitors object is at a location
    (visitors-at ?x - visitors ?y - location)
    ;; indicates that a location object does not have visitors there
    (no-visitors ?x - location)
    ;; indicates two objects of type location are connected
    (connected ?x - location ?y - location)
    ;; indicates that a robot object is pushing a trolley object
    (pushing-trolley ?x - robot ?y - trolley)
    ;; indicates that a trolley object is holding a food object
    (trolley-holding ?x - trolley ?y - food)
    ;; indicates that a trolley object is located at a location object
    (trolley-at ?x - trolley ?y - location)
    ;; indicates that a location object does not have a trolley object there
    (no-trolley ?x - location)
    ;; indicated that a location object does not have a robot object there
    (no-robot ?x - location)
    ;; indicated that a location object does not have an animal there
    (no-animal ?x - animallocation)
    ;; indicates that a robot object is not pushing a trolley
    (free ?x - robot)
    ;; indicates that a robot object is holding an animal object
    (holding-animal ?x - robot ?y - animal)
    ;; indicates that a location object can be visited by a vistor object
    ;; store, pantry do not allow visitors
    ;; animallocation room allow visitors
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
