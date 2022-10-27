import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedin = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: _isLoggedin
            ? Column(
                children: [
                  Image.network(_userObj!.photoUrl!),
                  Text(_userObj!.displayName!),
                  Text(_userObj!.email),
                  ElevatedButton(
                    onPressed: () {
                      _googleSignIn.signOut().then((value) {
                        setState(() {
                          _isLoggedin = false;
                          _userObj = null;
                        });
                      }).catchError((e) {
                        print(e);
                      });
                    },
                    child: Text("Login out"),
                  ),
                ],
              )
            : Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _googleSignIn.signIn().then((value) {
                      setState(() {
                        _isLoggedin = true;
                        _userObj = value;
                      });
                    }).catchError((e) {
                      exit(0);
                    });
                  },
                  child: Text("Login with Google"),
                ),
              ),
      ),
    );
  }
}
