@vcr

Feature: get current_user's twitter avatar

  Scenario: Get avatar on the project's page near the task
      Given a logged-in user
      When the user completed a task
      And I view the project's page
      Then I should see the User's twitter avatar
