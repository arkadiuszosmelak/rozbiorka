import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rozbiorka/widgets/auth/auth_form.dart';
import 'package:rozbiorka/error/firebase_auth_error.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('avatar_${authResult.user.uid}.jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      authResult.user.updateProfile(displayName: username, photoURL: url);

      await FirebaseFirestore.instance.collection('users').doc(username).set({
        'username': username,
        'email': email,
        'image_url': url,
        'ratingList': []
      });
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials!';

      if (error.message != null) {
        message = error.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(FirebaseAuthError.show(error.code)),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<UserCredential> _signInWithFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();

      final userData = await FacebookAuth.instance.getUserData();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData['name'])
          .set({
        'username': userData['name'],
        'email': userData['email'],
        'image_url': userData['picture']['data']['url'],
        'ratingList': []
      });

      // Create a credential from the access token
      final FacebookAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FacebookAuthException catch (e) {
      print(e);
    } on FirebaseAuthException catch (e) {
      print(e);
    } finally {}
    return null;
  }

  Future<UserCredential> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(googleUser.displayName)
          .set({
        'username': googleUser.displayName,
        'email': googleUser.email,
        'image_url': googleUser.photoUrl,
        'ratingList': []
      });

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthError catch (e) {
      print(e);
    } finally {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
        _signInWithFacebook,
        _signInWithGoogle,
      ),
    );
  }
}
