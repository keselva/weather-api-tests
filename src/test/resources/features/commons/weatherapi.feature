Feature: Compare Sydney weather responses
  Background:
    * url baseUrl

  Scenario: Testing valid GET endpoint
    Given path path
    And param key = apikey
    And param q = city
    And param days = 2
    When method GET
    Then status 200