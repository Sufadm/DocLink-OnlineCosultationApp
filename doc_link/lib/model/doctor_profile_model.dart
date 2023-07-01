class ProfileModel {
  String? uid;
  final String name;
  final String gender;
  final String qualification;
  final String category;
  final String place;
  final String imageUrl;
  final String email;
  final String phone;
  ProfileModel({
    this.uid,
    required this.imageUrl,
    required this.email,
    required this.phone,
    required this.name,
    required this.gender,
    required this.qualification,
    required this.category,
    required this.place,
  });

  static ProfileModel fromJson(Map<String, dynamic> json) => ProfileModel(
      uid: json['id'],
      name: json['name'],
      category: json['category'],
      gender: json['gender'],
      place: json['place'],
      qualification: json['qualification'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      phone: json['phone']);
}
