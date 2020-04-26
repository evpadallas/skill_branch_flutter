import '../string_utils.dart';

enum LoginType { email, phone }

class User with UserUtils {
  String email;
  String phone;
  String _lastName;
  String _firstName;
  LoginType _type;
  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
    : _firstName = firstName, _lastName = lastName, this.phone = phone, this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

/*  User.__(String name) {
    this._lastName = name;
  }*/

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone?.isEmpty == true || email?.isEmpty == true) throw Exception("phone or email is empty");
    return User._(
        firstName: _getFirstName (name),
        lastName: _getLastName (name),
        phone: phone != null ? checkPhone(phone) : null,
        email: email != null ? checkEmail(email) : null
    );
  }

  static String _getLastName(String userName) => userName.split(" ")[1]; 
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containting 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    }

    String pattern = r"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}";

    if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Enter a valid email");
    }

    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

  @override
  bool operator == (Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
        _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userlnfo => ''' 
        name: $name 
        email: $email 
        firstName: $_firstName 
        lastName: $_lastName 
        friends: ${friends.toList()} 
        \\n
  ''';

  @override
  String toString() {
    return """
        name: $name 
        email: $email
        type: $login
        phone: $phone
        friends: ${friends.toList()}
    """;
  }

}