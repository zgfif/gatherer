Feature: Add a task

  Background:
    Given a project named 'Gatherer On Rails 5.2'
    Given an associated tasks with attributes:
       |          title|size|project_order|
       |Hunt the aliens|   1|            1|
       |   Write a book|   1|            2|

  Scenario: I can add and change the priority of a new task
    When I visit the project page
    And I complete the new task form
    Then I am back on the project page
    And I see the new task is last in the list
    When I click to move the new task up
    Then I am back on the project page
    And the new task is in the middle of the list
