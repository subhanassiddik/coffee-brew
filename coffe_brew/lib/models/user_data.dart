class UserData {
  final String uid;
  UserData({required this.uid});
}

class UserDataDetail {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserDataDetail(
      {required this.name,
      required this.strength,
      required this.sugars,
      required this.uid});
}
