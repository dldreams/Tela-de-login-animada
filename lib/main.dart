import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _correctPassword = 'admin';
  String _animationType = 'idle';

  TextEditingController _passwordController = TextEditingController();

  FocusNode _passwordNode = FocusNode();
  FocusNode _usernameNode = FocusNode();

  @override
  void initState() {
    this._passwordNode.addListener(() {
      if (this._passwordNode.hasFocus) {
        setState(() => this._animationType = 'hands_up');
      } else {
        setState(() => this._animationType = 'hands_down');
      }
    });

    this._usernameNode.addListener(() {
      if (this._usernameNode.hasFocus) {
        setState(() => this._animationType = 'test');
      } else {
        setState(() => this._animationType = 'idle');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Container(
              height: 300,
              width: 300,
              child: FlareActor(
                'assets/Teddy.flr',
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                animation: this._animationType,
                callback: (currentAnimation) {
                  setState(() => this._animationType = 'idle');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    focusNode: this._usernameNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                  Divider(),
                  TextFormField(
                    focusNode: this._passwordNode,
                    obscureText: true,
                    controller: this._passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: signIn,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    currentFocus.unfocus();

    await Future.delayed(Duration(milliseconds: 400));

    if (_passwordController.text.compareTo(_correctPassword) == 0) {
      setState(() => this._animationType = 'success');
    } else {
      setState(() => this._animationType = 'fail');
    }
  }
}
