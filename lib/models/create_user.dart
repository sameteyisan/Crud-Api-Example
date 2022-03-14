class CreateUserModel {
  final String name;
  final String image;
  final DateTime birthday;

  CreateUserModel({
    required this.name,
    required this.image,
    required this.birthday,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) =>
      CreateUserModel(
        name: json["name"],
        image: json["image"],
        birthday: DateTime.parse(
          json["birthday"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "birthday": birthday.toIso8601String(),
      };
}
