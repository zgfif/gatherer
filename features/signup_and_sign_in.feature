Feature: Singup

  Scenario: As user I can signup
    Given email and password
    When fill the Singup form
    Then I can regularly signin
