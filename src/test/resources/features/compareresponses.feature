Feature: Compare Sydney weather responses
  Background:
    * def pattern = 'yyyy-MM-dd'
    * def getDate =
      """
      function() {
        var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
        var sdf = new SimpleDateFormat(pattern);
        var Calendar = Java.type('java.util.Calendar');
        var calendar = Calendar.getInstance();
        var date = new java.util.Date();
        calendar.add(Calendar.DAY_OF_YEAR, 1);
        date = calendar.getTime();
        return sdf.format(date)
      }
      """
    * def tomorrow = getDate()

  Scenario: Compare min and max temp in Sydney for next day
    * def jsonresult = call read('commons/weatherapi.feature')  { path : '/v1/forecast.json' }
    * def xmlresult = call read('commons/weatherapi.feature')  { path : '/v1/forecast.xml' }
    * json jsonResponse = karate.jsonPath(jsonresult.response.forecast.forecastday, "$[?(@.date =='" + tomorrow + "')]")
    * json xmlResponse = karate.jsonPath(xmlresult.response.root.forecast.forecastday, "$[?(@.date =='" + tomorrow + "')]")
    * string jsonmaxTemp = jsonResponse[0].day.maxtemp_c
    * string xmlmaxTemp = xmlResponse[0].day.maxtemp_c
    * string jsonminTemp = jsonResponse[0].day.mintemp_c
    * string xmlminTemp = xmlResponse[0].day.mintemp_c
    * match jsonmaxTemp == xmlmaxTemp
    * match jsonminTemp == xmlminTemp