import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/patient_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  addData(String name, String mobile, String age) async {
    if (name.isEmpty || mobile.isEmpty || age.isEmpty) {
      print('Please fill all the fields');
    } else {
      int? mobileNumber = int.tryParse(mobile);
      int? ageNumber = int.tryParse(age);
      try {
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        final user = FirebaseAuth.instance.currentUser;

        // Check if the user already exists in the database
        QuerySnapshot querySnapshot =
            await users.where('mobile', isEqualTo: mobileNumber).limit(1).get();
        if (querySnapshot.docs.isNotEmpty) {
          // User already exists, do not add data
          print('User already exists');
        } else {
          // User doesn't exist, add data
          await users.add({
            'name': name,
            'mobile': mobileNumber,
            'age': ageNumber,
            'userId': user?.uid
          });
          print('Data added successfully');
        }

        // Navigate back to PatientDashboard after data addition
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PatientDashboard()),
        );
      } catch (e) {
        print("Failed to Add Data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 10, 78, 159),
        title: Text(
          'User Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'images/logo.png', // Replace 'assets/logo.png' with your logo path
                  ),
                  radius: 75.0,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Please enter your details to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 32, 63)),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: 300.0, // Adjust the width of the text fields container
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                        decoration: buildInputDecoration('Name', Icons.person),
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        controller: mobileController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                        decoration:
                            buildInputDecoration('Mobile Number', Icons.phone),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        controller: ageController,
                        style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                        decoration:
                            buildInputDecoration('Age', Icons.calendar_today),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    // Handle button press here
                    String name = nameController.text.toString();
                    String mobile = mobileController.text.toString();
                    String age = ageController.text.toString();

                    int? mobileNumber = int.tryParse(mobile);

                    try {
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('Users');

                      // Check if the user already exists in the database
                      QuerySnapshot querySnapshot = await users
                          .where('mobile', isEqualTo: mobileNumber)
                          .limit(1)
                          .get();
                      if (querySnapshot.docs.isNotEmpty) {
                        // Existing user
                        print('Existing user');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientDashboard()),
                        );
                      } else {
                        // New user
                        print('New user');
                        // Handle adding data to Firestore
                        addData(name, mobile, age);
                      }
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    backgroundColor: Color.fromARGB(255, 10, 78, 159),
                  ),
                  child: Text(
                    'Let\'s Go',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
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

class DateFormat {}

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
