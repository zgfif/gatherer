Feature: new project

  Scenario: creating a new project
    Given existing user
    When user signin
    And fills new project's form
    Then appears created project with tasks
