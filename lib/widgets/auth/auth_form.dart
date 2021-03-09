// Naprawianie klawiatury -> zabawa z media query i SizeBoxem z 87 linii

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:rozbiorka/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading, this.facebookLogin, this.googleLogin);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final Function facebookLogin;
  final Function googleLogin;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userImageFile;
  bool _isObscure = true;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
      //send auth to firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _isLogin
                            ? SizedBox(height: 150)
                            : SizedBox(height: 100),
                        if (!_isLogin) UserImagePicker(_pickedImage),
                        if (!_isLogin) SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            )
                          ]),
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Wprowadź poprany adres email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _userEmail = value;
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.indigoAccent,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        if (!_isLogin) SizedBox(height: 30),
                        if (!_isLogin)
                          TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Nick musi zawierać przynajmniej 4 znaki';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userName = value;
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.indigoAccent,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Nazwa użytkownika',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            )
                          ]),
                          child: TextFormField(
                            obscureText: _isObscure ? true : false,
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 7) {
                                return 'Hasło musi zawierać przynajmniej 7 znaków';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userPassword = value;
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.indigoAccent,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Colors.white,
                              ),
                              hintText: 'Hasło',
                              hintStyle: TextStyle(
                                color: Colors.white54,
                                fontFamily: 'OpenSans',
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        !_isLogin
                            ? SizedBox(height: 30)
                            : Container(
                                padding: EdgeInsets.only(top: 10.0),
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  child: Text(
                                    'Nie pamiętasz hasła?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                  onPressed: () {},
                                  padding: EdgeInsets.only(right: 0.0),
                                ),
                              ),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            width: 200,
                            child: RaisedButton(
                              child: Text(
                                  _isLogin ? 'Zaloguj się' : 'Zarejestruj się'),
                              onPressed: _trySubmit,
                              elevation: 5.0,
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Theme.of(context).buttonColor,
                              textColor: Colors.indigo,
                            ),
                          ),
                        if (_isLogin & !isKeyboardVisible)
                          Column(
                            children: [
                              SizedBox(height: 20.0),
                              Container(
                                child: Text(
                                  '- lub -',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 5.0),
                        if (_isLogin & !isKeyboardVisible)
                          Container(
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: IconButton(
                                    icon:
                                        Image.asset('assets/icons/fb_icon.png'),
                                    onPressed: widget.facebookLogin,
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: IconButton(
                                    icon: Image.asset(
                                        'assets/icons/google_icon.png'),
                                    onPressed: widget.googleLogin,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (!isKeyboardVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    !_isLogin ? 'Masz u nas konto?' : 'Nie masz jeszcze konta?',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  FlatButton(
                    child: Text(
                      !_isLogin ? 'Zaloguj się' : 'Zarejestruj się',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
