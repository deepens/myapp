import 'package:flutter/material.dart';
import './routing_constants.dart';
//import './landingpage.dart';
import './nopagefound.dart';
import './home.dart';
import './signin.dart';
import './signup.dart';

Route<dynamic> redirectingtopage(RouteSettings page) {
  switch (page.name) {
    //case LandingPageRoute:
    //  return MaterialPageRoute(builder: (context) => LandingPage());
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case SigninPageRoute:
      return MaterialPageRoute(builder: (context) => Signin());
    case SignupPageRoute:
      return MaterialPageRoute(builder: (context) => Signup());    
    default:
      print(page.name);
      return MaterialPageRoute(
          builder: (context) => NoPageFound(name: page.name));
  }
}

