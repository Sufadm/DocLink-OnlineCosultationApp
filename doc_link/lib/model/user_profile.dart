class UserProfileModel {
  String? uid;
  final String name;
  final String gender;
  final String age;
  final String imageUrl;
  final String fcmToken;

  UserProfileModel({
    this.uid,
    required this.fcmToken,
    required this.age,
    required this.imageUrl,
    required this.name,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'fcmToken': fcmToken,
      'id': uid,
      'gender': gender,
      'age': age,
      'imageUrl': imageUrl,
      'name': name
    };
  }

  static UserProfileModel fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
          fcmToken: json['fcmToken'],
          age: json['age'],
          gender: json['gender'],
          imageUrl: json['imageUrl'],
          name: json['name'],
          uid: json['id']);
}
