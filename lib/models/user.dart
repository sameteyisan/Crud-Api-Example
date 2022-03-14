class UserModel {
  final String id;
  String name;
  String image;
  DateTime birthday;

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.birthday,
  });

  String get horoscope => getHoroscope(birthday.day, birthday.month);

  String get age =>
      (DateTime.now().difference(birthday).inDays / 365).toStringAsFixed(0) +
      " years old";

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        birthday: DateTime.parse(json["birthday"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "birthday": birthday.toIso8601String(),
      };

  getHoroscope(int day, int month) {
    if ((month == 1 && day <= 20) || (month == 12 && day >= 22)) {
      return "♑ Capricorn";
    } else if ((month == 1 && day >= 21) || (month == 2 && day <= 18)) {
      return "♒ Aquarius";
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return "♓ Pisces";
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 20)) {
      return "♈ Aries";
    } else if ((month == 4 && day >= 21) || (month == 5 && day <= 20)) {
      return "♉ Taurus";
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return "♊ Gemini";
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return "♋ Cancer";
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 23)) {
      return "♌ Leo";
    } else if ((month == 8 && day >= 24) || (month == 9 && day <= 23)) {
      return "♍ Virgo";
    } else if ((month == 9 && day >= 24) || (month == 10 && day <= 23)) {
      return "♎ Libra";
    } else if ((month == 10 && day >= 24) || (month == 11 && day <= 22)) {
      return "♏ Scorpio";
    } else if ((month == 11 && day >= 23) || (month == 12 && day <= 21)) {
      return "♐ Sagittarius";
    } else {
      return "👽 Unknown";
    }
  }
}
