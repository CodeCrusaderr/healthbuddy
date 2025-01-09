import 'package:dashboard/phone/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({super.key});

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        title: Text(
          'Phone Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70.0,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: phoneController,
                style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                decoration: buildInputDecoration(
                    'Enter your Mobile Number', Icons.phone_iphone),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    codeSent: (String verificationid, int? resendToken) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VerifyOTP(verificationid: verificationid)));
                    },
                    codeAutoRetrievalTimeout: (String verificationID) {},
                    phoneNumber: "+91" + phoneController.text.toString(),
                    timeout: Duration(seconds: 60));

                // Add functionality to get OTP
              },
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 0, 32, 63),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 10, 78, 159),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        'Get OTP',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
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
