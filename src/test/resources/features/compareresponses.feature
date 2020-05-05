Feature: Compare Sydney weather responses
  Background:
    * def pattern = 'yyyy-MM-dd'
    * def getDate =
      """
      function() {
        var DateUtil = Java.type('au.com.config.DateUtil');
        var dateUtil = new DateUtil();
        return dateUtil.getNextDay();
      }
      """
    * def tomorrow = getDate()

  Scenario Outline: Compare min and max temp in <city> for next day
    * def jsonresult = call read('commons/weatherapi.feature')  { path : '/v1/forecast.json' , city : '#(city)'}
    * def xmlresult = call read('commons/weatherapi.feature')  { path : '/v1/forecast.xml' , city : '#(city)'}
    * json jsonResponse = karate.jsonPath(jsonresult.response.forecast.forecastday, "$[?(@.date =='" + tomorrow + "')]")
    * json xmlResponse = karate.jsonPath(xmlresult.response.root.forecast.forecastday, "$[?(@.date =='" + tomorrow + "')]")
    * string jsonmaxTemp = jsonResponse[0].day.maxtemp_c
    * string xmlmaxTemp = xmlResponse[0].day.maxtemp_c
    * string jsonminTemp = jsonResponse[0].day.mintemp_c
    * string xmlminTemp = xmlResponse[0].day.mintemp_c
    * match jsonmaxTemp == xmlmaxTemp
    * match jsonminTemp == xmlminTemp

    Examples:
      | city      |
      | sydney    |
      | perth     |
      | melbourne |
      | cairns    |