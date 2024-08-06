class RadioStationsModel{
  String name;
  String favicon;
  String country;
  String urlResolved;
  String homePage;
  String genre;

  RadioStationsModel({
    required this.name, 
    required this.favicon, 
    required this.country, 
    required this.urlResolved, 
    required this.homePage,
    required this.genre,
  });

  factory RadioStationsModel.fromJson(Map<String, dynamic> json) => RadioStationsModel(
    name: json['name'],
    favicon: json['favicon'],
    country: json['country'],
    urlResolved: json['url_resolved'],
    homePage: json['homepage'],
    genre: json['tags']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'favicon': favicon,
    'country': country,
    'url_resolved': urlResolved,
    'homepage': homePage,
    'tags': genre,
  };

}