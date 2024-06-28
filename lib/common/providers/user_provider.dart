import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
import 'package:wherehome/data/repositories/user_repo.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  HomeOwner? _currentHomeOwner;
  String? _uniqueId;
  String? _apiToken;

  User? get user => _user;

  HomeOwner? get homeOwner => _currentHomeOwner;

  String? get uniqueId => _uniqueId;

  String? get apiToken => _apiToken;

  void setUser(User user, String apiToken) {
    _user = user;
    _uniqueId = user.id;
    _apiToken = apiToken;
    //_saveUserId();
    notifyListeners();
  }

  void setHomeOwner(HomeOwner homeOwner) {
    _currentHomeOwner = homeOwner;
    notifyListeners();
  }

  void signOut() {
    _user = null;
    _uniqueId = null;
    _currentHomeOwner = null;
    _disposeUserId();
    notifyListeners();
  }

  void setToken(String newToken) {
    _apiToken = newToken;
    notifyListeners();
  }

  bool get isUserAuthenticated => _user != null;

  void loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _uniqueId = prefs.getString('userId');
    _apiToken = prefs.getString('apiToken');
    notifyListeners();
  }

  Future<void> _disposeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('apiToken');
  }

  Future<void> _saveUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', _uniqueId!);
    prefs.setString('apiToken', _apiToken!);
  }
}
