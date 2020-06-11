import 'package:flutter/material.dart';


//import 'package:myapp/signin.dart';
import './fauth.dart';
import 'package:provider/provider.dart';
import './routing_constants.dart';
import './dialogs.dart';


class Signup extends StatefulWidget {
  @override
  _Signupfromstate createState() => _Signupfromstate();
}

class _Signupfromstate extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormFieldState>();
  var passKey = GlobalKey<FormFieldState>();
  final GlobalKey<State> _progressDialogLoader = new GlobalKey<State>();
  String uemail;
  String upassword;
  String errormsg = '';
  bool isloading = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // @override
  // void initState() {
  //   uemail = null;
  //   upassword = null;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //final authpro1 = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        title: Text("Sign Up Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.amber[10],
          child: Form(
            key: formKey,
            child: ListView(children: [
              SizedBox(
                height: 10,
              ),
              Text(
                errormsg,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 10,
              ),
              emailTextFormField(context),
              SizedBox(
                height: 10,
              ),
              passwordTextFormField(context),
              SizedBox(
                height: 10,
              ),
              // Consumer<AuthService>(builder: (context, authpro1, child) {
              //   return Text("Car=>${authpro1.getusermail()}");
              // }),
              submitForm(context),
              loadingCircle(context),
               RaisedButton(
                child: Text("Sign In"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SigninPageRoute);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget submitForm(BuildContext context) {
    print("Value of =========>>>>>>$isloading");
    final authpro = Provider.of<AuthService>(context);

    return Center(
      child: WillPopScope(
        onWillPop: () async => false,
        child: RaisedButton(
          child: Text("Sign Up"),
          onPressed: () async {
            if (formKey.currentState.validate()) {
              print("Validation Sucessfull");
              setState(() {
                isloading = true;
                print("inside------------>");
              });
              
              Dialogs.showLoadingDialog(context, _progressDialogLoader);
              var result = await AuthService()
                  .signUpUser(email: uemail, password: upassword);
              print("result:->$result");

              {
                if (result == true) {
                  setState(() {
                    errormsg = '';
                    isloading = false;
                  });
                  print("****>${authpro.getusermail()}");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, HomePageRoute);
                } else {
                  //print(" Result value is False therefore no error");
                  setState(() {
                    isloading = false;
                    errormsg = "$result";
                  });
                  Navigator.of(_progressDialogLoader.currentContext,rootNavigator: true).pop();
                }
              }
            }
          },
        ),
      ),
    );
  }

  

Widget loadingCircle(BuildContext context) {
    print("inside Loading Circle bu before condition------------>$isloading");
     if(isloading==true)

     {
       print("inside Loading Circle------------>$isloading");
       return Center(
      child: Container(
        child: CircularProgressIndicator(

        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );}
    else return Center();
  }

  Widget submitButton(BuildContext context) {
    final authpro = Provider.of<AuthService>(context);
    return Center(
      child: WillPopScope(
        onWillPop: () async => false,
        child: RaisedButton(
          child: Text("Sign Up"),
          onPressed: () async {
            if (formKey.currentState.validate()) {
              print("Validation Sucessfull");
              print(uemail);
              print(upassword);
              //var obj = new AuthService();
              var result = await AuthService()
                  .signUpUser(email: uemail, password: upassword);
              print("result:->$result");
              if (result) {
                setState(() {
                  errormsg = '';
                });
                print("****>${authpro.getusermail()}");
                Navigator.pop(context);
                Navigator.pushNamed(context, SigninPageRoute);
              } else {
                print(" Result value is False therefore no error");
                setState(() {
                  errormsg = "Email id already exist";
                });
              }
            }
          },
        ),
      ),
    );
  }

  Widget emailTextFormField(BuildContext context) {
    return TextFormField(
      key: emailKey,
      decoration: InputDecoration(hintText: 'Email id'),
      controller: _email,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter email';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(val))
          return 'Enter valid email';
        else
          return null;
      },
      onChanged: (val) {
        setState(() {
          uemail = val;
          //print("----->$val");
        });
      },
    );
  }

  Widget passwordTextFormField(BuildContext context) {
    return TextFormField(
      key: passKey,
      decoration: InputDecoration(hintText: 'Password'),
      controller: _password,
      onChanged: (val) {
        setState(() {
          upassword = val;

          //print("----->$val");
        });
      },
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter password';
        } else
          return null;
      },
    );
  }
} //stateful class
