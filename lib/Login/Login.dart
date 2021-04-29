import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _profilePictureAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _profilePictureAnimation = Tween(begin: 10.0, end: 70.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 0.20, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            // Set this height
            brightness: Brightness.light,
            backgroundColor: Colors.blueGrey[900],
            leading: Icon(
              Icons.supervised_user_circle_outlined,
              size: _profilePictureAnimation.value,
              color: Colors.white,
            ),

            elevation: 0.0,
          ),
          backgroundColor: Colors.blueGrey[900],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextFormField(
                    cursorColor: Colors.deepOrangeAccent,
                    controller: _emailController,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent),
                      focusColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                        const Radius.circular(40),
                      )),
                    ),
                    validator: validateEmail,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextFormField(
                    cursorColor: Colors.deepOrangeAccent,
                    controller: _passwordController,
                    autocorrect: true,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent),
                      focusColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrangeAccent,
                          ),
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(40),
                          )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Minimum 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleSwitch(
                  initialLabelIndex: 0,
                  labels: ['Login', 'Sign-up'],
                  minWidth: 400.0,
                  minHeight: 55.0,
                  fontSize: 16.0,
                  cornerRadius: 50,
                  activeBgColor: Colors.deepOrangeAccent,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[800],
                  inactiveFgColor: Colors.white,
                  onToggle: (index) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                    text: "Forgot Password?",
                    style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  width: 200,
                  height: 50,
                  child: OutlinedButton(
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
