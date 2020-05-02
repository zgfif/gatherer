Feature: Change order of tasks

  Scenario: change order of tasks associated with the project
    Given existing project with 3 tasks
    When moves up the second task of the project
    Then the second task becomes first in order
    And after reloading order is the same
