class UnsplashUser {
  String id;
  String userName;
  String? firstName;
  String? lastName;
  String avatarSmall;
  String avatarMedium;
  String avatarLarge;

  UnsplashUser({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.avatarSmall,
    required this.avatarMedium,
    required this.avatarLarge,
  });

  toJson() => {
        'id': id,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'avatarSmall': avatarSmall,
        'avatarMedium': avatarMedium,
        'avatarLarge': avatarLarge,
      };

  factory UnsplashUser.fromJson(Map<String, dynamic> json) => UnsplashUser(
        id: json['id'],
        userName: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatarSmall: json['profile_image']['small'],
        avatarMedium: json['profile_image']['medium'],
        avatarLarge: json['profile_image']['large'],
      );
  factory UnsplashUser.fromFirebase(Map<String, dynamic> json) => UnsplashUser(
    id: json['id'],
    userName: json['userName'],
    firstName: json['first_name'],
    lastName: json['firstName'],
    avatarSmall: json['avatarSmall'],
    avatarMedium: json['avatarMedium'],
    avatarLarge: json['avatarLarge'],
  );
}
