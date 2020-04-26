
import 'models/user.dart';


class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    //print(user.toString());

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('A user with this name alredy exists');
    }
  }

  getUserByLogin(String login) 
  {
    if (users.containsKey(login)) {
      return users[login];
    } 
    
    return null;
  }

  registerUserByPhone(String fullName, String phone) 
  {
      User user = User(name: fullName, phone: phone);
      
      if (getUserByLogin(user.login) != null) { 
        throw Exception('A user with this phone already exists');
      }

      users[user.login] = user;

      return user;
  }

  registerUserByEmail(String fullName, String email) 
  {
      User user = User(name: fullName, email: email);

      if (getUserByLogin(user.login) != null) {  
        throw Exception("A user with this email already exists");
      }

      users[user.login] = user;

      return user;    
  }

  void setFriends(String login, List<User> friends) 
  {
    getUserByLogin(login).addFriend(friends);
  }


  findUserInFriends(String fullName, User user) 
  {
    if (users.containsKey(fullName)) 
    {
      if (!users[fullName].friends.contains(user)) 
      {
        throw Exception("${user.login} is not a friend of the login");
      } 

      return user;
    }

    throw Exception("$fullName is not found");
  }

  List<User> importUsers(List<String> csvdata) {
    List<User> userlist = List();

    if (csvdata.isNotEmpty) {
      csvdata.forEach((e) {
        userlist.add(_parseCSVData(e));
      });
    } 

    return userlist;
  }

  _parseCSVData(String str)
  {
    List<String> splitted = str.split(";\n");

    String name = splitted[0].trim(); 
    String email = splitted[1].trim();
    String phone = splitted[2].trim();

    return User(name: name, phone: phone, email: email);
  }

}