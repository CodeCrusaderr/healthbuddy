import 'package:dashboard/patient_dashboard.dart';
import 'package:dashboard/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerifyOTP extends StatefulWidget {
  String verificationid;
  VerifyOTP({super.key, required this.verificationid});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController otpController = TextEditingController();
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
          'OTP Page',
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
                controller: otpController,
                style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                decoration:
                    buildInputDecoration('Enter the OTP', Icons.phone_iphone),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  FirebaseAuth.instance
                      .setSettings(appVerificationDisabledForTesting: true);

                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationid,
                    smsCode: otpController.text.toString(),
                  );
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithCredential(credential);

                  // Check if the user is new or existing
                  if (userCredential.additionalUserInfo!.isNewUser) {
                    // New user
                    print('Navigating to UserDetailsPage');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(),
                      ),
                    );
                  } else {
                    // Existing user
                    print('Navigating to PatientDashboard');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => PatientDashboard(),
                      ),
                    );
                  }
                } catch (e) {
                  print('Failed to sign in: $e');
                }
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
                        'Login',
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
