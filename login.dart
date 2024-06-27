import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plannerapp/authentication/forgot_pwd.dart';
import 'package:plannerapp/authentication/register.dart';
import 'package:plannerapp/authentication/vendor_signup.dart';
import 'package:plannerapp/home/home.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 84, 178, 254),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
                _vendorinfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Image.asset(
          "images/wedding.png",
          height: 140,
          width: 200,
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _email,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
            fillColor: Colors.white.withOpacity(0.9),
            filled: true,
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _password,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
            fillColor: Colors.white.withOpacity(0.9),
            filled: true,
            prefixIcon: const Icon(
              Icons.key,
              color: Colors.grey,
            ),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: _signInWithEmailAndPassword,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(327, 50),
            backgroundColor: Colors.black,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(55),
              ),
            ),
          ),
          child: const Text(
            "SIGN IN",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
      // Store user data in Firestore
      await _storeUserData(userCredential.user);
      // Navigate to the HomeScreen

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      log("Error signing in: $e");
    }
  }

  Future<void> _storeUserData(User? user) async {
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
      });
    }
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPassword()),
      ),
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  _signup(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Dont have an account? "),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUp()),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _vendorinfo(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Are you a Vendor?"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VendorSignUpScreen()),
              );
            },
            child: const Text(
              "Login here",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
