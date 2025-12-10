import 'package:flutter/material.dart';
import 'package:flutter01_login/signup.dart';
import 'package:flutter01_login/product_detail.dart';
import 'package:flutter01_login/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: LogIn());
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  var _userNameErr = "Email không hợp lệ";
  var _passErr = "Mật khẩu phải trên 6 ký tự";

  var _userInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    bool isValidLogin =
        !_userInvalid &&
        !_passInvalid &&
        _userController.text.isNotEmpty &&
        _passController.text.isNotEmpty;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
          constraints: BoxConstraints.expand(),
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(0),
                    child: Image.asset(
                      'assets/login_logo.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Text(
                "Loging",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Text(
                  "Enter your emails and password",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: TextField(
                  controller: _userController,
                  style: TextStyle(fontSize: 19, color: Colors.black),
                  onChanged: onEmailChanged,
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _userInvalid ? _userNameErr : null,
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 175, 171, 171),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextField(
                      controller: _passController,
                      style: TextStyle(fontSize: 19, color: Colors.black),
                      obscureText: !_showPass,
                      onChanged: onPassChanged,
                      decoration: InputDecoration(
                        labelText: "Password",
                        errorText: _passInvalid ? _passErr : null,
                        labelStyle: TextStyle(
                          color: const Color.fromARGB(255, 175, 171, 171),
                          fontSize: 20,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: onToggleShowPass,
                          child: Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isValidLogin
                            ? const Color.fromARGB(255, 98, 175, 143)
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: isValidLogin ? onLogInClicked : null,
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSignUpClicked,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 98, 175, 143),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onEmailChanged(String text) {
    setState(() {
      bool emailValid = RegExp(
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(text);
      if (!emailValid) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }
    });
  }

  void onPassChanged(String text) {
    setState(() {
      if (text.length < 6) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }
    });
  }

  void onLogInClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void onSignUpClicked() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Widget gotoSignUp(BuildContext context) {
    return SignUp();
  }

  Widget gotoProductDetail(BuildContext context) {
    return ProductDetail();
  }

  Widget gotoHomeScreen(BuildContext context) {
    return HomeScreen();
  }
}
