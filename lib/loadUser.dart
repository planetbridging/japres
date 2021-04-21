import 'package:shared_preferences/shared_preferences.dart';

incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int counter = (prefs.getInt('counter') ?? 0) + 1;
  print('Pressed $counter times.');
  await prefs.setInt('counter', counter);
}


setSavedUserData(String userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userData', userData);
}

Future<String> getSavedUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String u = (prefs.getString('userData') ?? "") ;
  return u;
}