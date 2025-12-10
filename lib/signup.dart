import 'package:flutter/material.dart';
import 'package:flutter01_login/main.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _showPass = false;

  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  var _userErr = "Tài khoản phải trên 4 ký tự";
  var _emailErr = "Email không hợp lệ";
  var _passErr = "Mật khẩu phải trên 6 ký tự";

  var _userInvalid = false;
  var _emailInvalid = false;
  var _passInvalid = false;

  @override
  Widget build(BuildContext context) {
    bool isValidSignUp =
        !_userInvalid &&
        !_emailInvalid &&
        !_passInvalid &&
        _userController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passController.text.isNotEmpty;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          constraints: BoxConstraints.expand(),
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
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
                "Sign Up",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Text(
                  "Enter your credentials to continue",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: TextField(
                  controller: _userController,
                  onChanged: onUserChanged,
                  style: TextStyle(fontSize: 19, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Username",
                    errorText: _userInvalid ? _userErr : null,
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 175, 171, 171),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: TextField(
                  controller: _emailController,
                  onChanged: onEmailChanged,
                  style: TextStyle(fontSize: 19, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _emailInvalid ? _emailErr : null,
                    labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 175, 171, 171),
                      fontSize: 20,
                    ),
                    suffixIcon: Icon(Icons.check),
                  ),
                ),
              ),

              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextField(
                      controller: _passController,
                      onChanged: onPassChanged,
                      style: TextStyle(fontSize: 19, color: Colors.black),
                      obscureText: !_showPass,
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
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(text: "By continuing you agree our "),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 175, 143),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy",
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 175, 143),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: "."),
                      ],
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
                        backgroundColor: isValidSignUp
                            ? const Color.fromARGB(255, 98, 175, 143)
                            : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: isValidSignUp ? onSignUpClicked : null,
                      child: Text(
                        "Sign Up",
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
                onTap: onLogInClicked,
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
                            "Already have an account?",
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
                          "Login",
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

  void onUserChanged(String text) {
    setState(() {
      if (text.length < 4) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }
    });
  }

  void onEmailChanged(String text) {
    setState(() {
      bool emailValid = RegExp(
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(text);
      if (!emailValid) {
        _emailInvalid = true;
      } else {
        _emailInvalid = false;
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
  }

  void onSignUpClicked() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Đăng ký thành công! Hãy đăng nhập."),
        backgroundColor: Colors.green,
      ),
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
    });
  }

  Widget gotoLogIn(BuildContext context) {
    return LogIn();
  }

  Widget gotoSignUp(BuildContext context) {
    return SignUp();
  }
}
