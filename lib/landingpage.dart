import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/signin.dart';
//import 'package:progress_dialog/progress_dialog.dart';
//import './signup.dart';
//import './fauth.dart' as auth;
import './home.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    // pr = new ProgressDialog(context, showLogs: true);
    // pr.style(message: 'Please wait...');
    // pr.show();

    //var res = hello();
    FirebaseAuth.instance.currentUser().then((res) {
        print(res);
        try {
          if (res != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signin()),
            );
          }
        } catch (e) {
          print(e);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome to Landing Page",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container());
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
