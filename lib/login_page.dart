import 'package:dashboard/phone/phone_login.dart';
import 'package:dashboard/user_details.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/patient_dashboard.dart';
import 'package:dashboard/signup.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatelessWidget {
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
                      backgroundColor: Color.fromARGB(255, 0, 32, 63),
                      radius: 70.0,
                      child: Image.asset('images/logo.png')),
                ),
                SizedBox(height: 20.0),
                AuthForm(),
                SizedBox(height: 20.0),
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to signup page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 0, 32, 63),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  signInWithGoogle() async {
    setState(
      () {
        isLoading = true;
      },
    );

    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut(); // Sign out the user from Google

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      setState(
        () {
          isLoading = false;
        },
      );

      // Delay navigation to allow auth state change listener to process
      await Future.delayed(Duration(seconds: 1));

      if (userCredential.additionalUserInfo!.isNewUser) {
        // Navigate to UserDetailsPage
        print('Navigating to UserDetailsPage');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => UserDetailsPage(),
          ),
        );
      } else {
        // Navigate to PatientDashboardPage
        print('Navigating to PatientDashboardPage');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PatientDashboard(),
          ),
        );
      }
    }
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      print("Please fill all the fields");
    } else {
      try {
        //Create New Account
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PatientDashboard()),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error', style: TextStyle(color: Colors.black)),
              content: Text(
                'Invalid credentials',
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
        ElevatedButton(
          onPressed: () async {
            login();
            // Implement login logic here
            // For demo, navigate to the patient dashboard
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            backgroundColor: Color.fromARGB(255, 10, 78, 159),
          ),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        SizedBox(height: 12.0),

        SizedBox(height: 12.0),
        TextButton(
          onPressed: () {
            // Implement forgot password logic here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInWithPhone(),
              ),
            );
          },
          child: Text(
            'Sign Up Using Mobile Number?',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ),
        // Add Google Sign In Button
        Center(
          child: SignInButton(
            Buttons.google,
            text: "Sign up with Google",
            onPressed: () async {
              signInWithGoogle();
            },
          ),
        ),
        if (isLoading)
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
        TextButton(
          onPressed: () {
            // Implement forgot password logic here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
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
