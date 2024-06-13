import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String userEmail;
  String id;
  String state;
  String token;

  UserProvider({
    this.userEmail = '',
    this.id = '',
    this.state = 'no-authenticated',
    this.token = ''
  });

  void changeUserEmail({
    required String newUserEmail,
    required String newId,
    required String newToken,
    String? newState
  }) async {
    userEmail = newUserEmail;
    id = newId;
    token = newToken;
    state = newState ?? 'no-authenticated';
    notifyListeners();
  }

  void deletedUser() async {
    userEmail = '';
    id = '';
    state = 'no-authenticated';
    notifyListeners();
  }
}
