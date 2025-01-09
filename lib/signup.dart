import 'package:dashboard/user_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  void signup() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.black)),
            content: Text(
              'Invalid input, Please fill all the fieds.',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print("Please fill all the fields");
    } else if (password != cpassword) {
      print("Passwords do not match");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.black)),
            content: Text(
              'Invalid credentials, Passwords Do Not Match.',
              style: TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      try {
        //Create New Account
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserDetailsPage()));
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error', style: TextStyle(color: Colors.black)),
              content: Text(
                'Invalid credentials, Please try again.',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          decoration: buildInputDecoration('Email', Icons.email),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          decoration: buildInputDecoration('Password', Icons.lock),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: cpasswordController,
          obscureText: true,
          style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          decoration: buildInputDecoration('Confirm Password', Icons.person),
        ),
        SizedBox(height: 30.0),
        // Replace ElevatedButton with GestureDetector
        GestureDetector(
          onTap: () {
            signup();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 10, 78, 159),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Color.fromARGB(255, 0, 32, 63)),
      labelStyle: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 0, 32, 63)),
        borderRadius: BorderRadius.circular(25.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 0, 32, 63)),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70.0,
                      child: Image.asset('images/logo.png')),
                ),
                SizedBox(height: 20.0),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
