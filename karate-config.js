function fn() {
  var config = {
        baseUrl : 'http://api.weatherapi.com',
        apikey : karate.properties['apikey']
    };

    return config;
}