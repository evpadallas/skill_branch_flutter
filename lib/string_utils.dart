extension MyString on String {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}

mixin UserUtils {
  capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}