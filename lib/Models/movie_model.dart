class Movie {
  final String? id;
  final String title;
  final String url;
  final String imageUrl;

  Movie({
    this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  static Movie fromJson(json) => Movie(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "imageUrl": imageUrl,
      };
}
