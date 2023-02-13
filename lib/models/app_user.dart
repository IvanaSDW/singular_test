class AppUser {
  String userId;
  String? email;
  String? name;
  String? avatarUrl;

  AppUser({required this.userId, this.email, this.name, this.avatarUrl});

  toJson() => {
    'userId': userId,
    'userEmail': email,
    'userName': name,
    'userAvatarUrl': avatarUrl,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
      userId: json['userId'],
      email: json['userEmail'],
      name: json['userName'],
      avatarUrl: json['userAvatarUrl']);
}