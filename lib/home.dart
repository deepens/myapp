import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/dialogs.dart';
import 'package:provider/provider.dart';
import './signin.dart';
import './fauth.dart';
import 'package:myapp/networkconnectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _useremail = '';
  String _token = '';
  getname() async {
    var instance = await FirebaseAuth.instance.currentUser();

    setState(() {
      _useremail = instance.email.toString();
    });

    print(_useremail);
  }

  @override
  void initState() {
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    print('***------>$connectionStatus');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome to Home Page",
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false,
      ),
      body: connectionStatus == ConnectivityStatus.Offline
          ? Dialogs.showNoInternetDialog(context)
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome User :$_useremail",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome User :$_token",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      child: Text("Sign out"),
                      onPressed: () {
                        try {
                          //FirebaseAuth.instance.signOut();
                          AuthService().signOutUser();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
