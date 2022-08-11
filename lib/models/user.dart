class UserModel {
  final String uid;
  final String name;
  final String platform;
  final String token;
  final String createdAt;

  const UserModel({
    required this.createdAt,
    required this.name,
    required this.platform,
    required this.token,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        createdAt: json['createdAt'],
        platform: json['platform'],
        token: json['token'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'token': token,
        'name': name,
        'platform': platform,
        'createdAt': createdAt,
      };
}
