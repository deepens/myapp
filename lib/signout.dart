//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './fauth.dart';
import './signin.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutstate createState() => _SignOutstate();
}

class _SignOutstate extends State<SignOut> {
  @override
  void initState() {
    super.initState();
    try {
      //FirebaseAuth.instance.signOut();
      AuthService().signOutUser();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    } catch (e) {
      print(e);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signin()),
      );
    }
  }

  Widget build(BuildContext context) {
    //final authpro1 = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: Text("Sign In Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Text("data"),
        ),
      ),
    );
  }
}
