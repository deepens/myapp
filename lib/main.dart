import 'package:flutter/material.dart';
import 'package:myapp/networkconnectivity.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/signin.dart';
//userdefined class/page
import './nopagefound.dart';
import './redirect.dart' as pagerouting;
import './fauth.dart';
import './home.dart';


void main() {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  runApp(
    
    StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityService().connectionStatusController,
          child: ChangeNotifierProvider<AuthService>(
          builder: (context) => AuthService(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey:navigatorKey ,
        onGenerateRoute: pagerouting.redirectingtopage,
        //initialRoute: LandingPage(),//LandingPageRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => NoPageFound(name: settings.name)),
        home: LandingPage()//LandingPage(),
        ),
      ),
    ),
  );
  
}
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
class _LandingPageState extends State<LandingPage> {
  // ProgressDialog pr;
  var _showCircularProgressIndicator = true;

  @override
  void initState() {
    super.initState();
    
    //check connectivity
    //CheckConnectivity _checkconnectivity  = CheckConnectivity();
   
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
        body: _showCircularProgressIndicator? CircularProgressIndicator():Container(),
        );
  }
}