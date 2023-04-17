class AppUser {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  AppUser({
    this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.imageUrl,
  });

  static AppUser fromJson(json) => AppUser(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "imageUrl": imageUrl,
      };
}
