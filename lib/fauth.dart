import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String usermail;
  String errormsg;

  getusermail() {
    return usermail;
  }

  geterrormsg() {
    return errormsg;
  }

  setusermail(String val) {
    usermail = val;
    notifyListeners();
  }

  seterrormsg(String val) {
    errormsg = val;
    notifyListeners();
  }

  Future getUser() {
    return _auth.currentUser();
  }

  Future logout() async {
    var result = FirebaseAuth.instance.signOut();
    usermail = '';
    notifyListeners();
    return result;
  }

  Future loginUser({String email, String password}) async {
    try {
      print("Inside: loginUser function-->" + email + password);
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          
      setusermail(result.user.email);
      return true;
    } on Exception catch (e) {
      //print(e);

      if(e.toString().contains('ERROR_WRONG_PASSWORD'))
      {
      return "Password is invalid";
      }
      else if(e.toString().contains('ERROR_USER_NOT_FOUND'))
      {
      return "User id does not exist";
      }else if(e.toString().contains('ERROR_TOO_MANY_REQUESTS'))
      {
      return "Too many unsuccessful login attempts. Please try again later.";
      }
      else 
      {
        return "Unknown error occured, please try login after some time";
      }  
    }
  }

  Future signUpUser({String email, String password}) async {
    try {
      print("Inside: signUpUser function-->" + email + password);
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      setusermail(result.user.email);
      return true;
    } on Exception catch (e) {
      print(e);
      
      if(e.toString().contains('ERROR_WEAK_PASSWORD'))
      {
      return "Password should be at least 6 characters";
      }
      else if(e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE'))
      {
      return "The email address is already in use by another account.";
      }else if(e.toString().contains('ERROR_TOO_MANY_REQUESTS'))
      {
      return "Too many unsuccessful login attempts. Please try again later.";
      }
      else 
      {
        return "Unknown error occured, please try login after some time";
      }
    }
  }

  Future signOutUser() async {
    try {
      print("Inside: signoutUser function...");
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print("--->" + e.toString());
      errormsg = e;
      return false;
    }
  }
}
