import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/login_page.dart';
import 'package:dashboard/readabouthealth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'lab_test.dart';
import 'package:flutter/material.dart';
import 'join_as_doc.dart';
import 'scheduled.dart';
import 'settings.dart';
import 'doctor_appointment.dart';
import 'edit_profile.dart';
import 'firebase storage/medical_records.dart';
import 'package:dashboard/quickbitestats.dart';
import 'package:dashboard/lab_select.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  // final user = FirebaseAuth.instance.currentUser!.displayName;
  final user = FirebaseAuth.instance.currentUser!;
  bool loggedIn = false;
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.providerData[0].providerId == 'google.com') {
        // User signed in with Google, use the name from the Google account
        setState(() {
          userName = user.displayName;
        });
      } else {
        // User signed in with mobile, fetch the name from Firestore
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('userId', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If the query returns at least one document, use the 'name' field of the first document
          setState(() {
            userName = querySnapshot.docs[0]['name'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Confirm Logout',
                  style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                ),
                content: Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes',
                        style:
                            TextStyle(color: Color.fromRGBO(10, 78, 159, 1))),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: TextStyle(color: Color.fromRGBO(10, 78, 159, 1)),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'HealthBuddy',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromRGBO(10, 78, 159, 1),
          iconTheme: IconThemeData(color: Colors.white), // Set icon color
        ),
        backgroundColor: Colors.white, // Updated background color to white
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color:
                      Color.fromRGBO(10, 78, 159, 1), // Header background color
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $userName!',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    LinearProgressIndicator(
                      value:
                          0.75, // Placeholder for the completion progress (75%)
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 0, 32, 63),
                      ), // Progress bar color
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Profile Completion: 75%', // Update with actual progress
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Image.network(
                  'https://img.icons8.com/?size=60&id=sVl5GKPpWl5z&format=png',
                  width: 24, // Adjust the width as needed-
                  height: 24, // Adjust the height as needed
                ),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                onTap: () {
                  // Navigate to edit profile screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Edits()),
                  );
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://img.icons8.com/?size=48&id=zLUcOB9hQUB9&format=png',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                title: Text(
                  'View Schedule',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                onTap: () {
                  // Navigate to view schedule screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentsPage()),
                  );
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://cdn-icons-png.freepik.com/256/9670/9670597.png?ga=GA1.1.449627703.1712332560&semt=ais_hybrid',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                title: Text(
                  'HealthShaala',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                onTap: () {
                  // Navigate to view schedule screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadAboutHealthPage()),
                  );
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://img.icons8.com/?size=80&id=DHJCUP779OXh&format=png',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                title: Text(
                  'Join as a Doctor',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                onTap: () {
                  // Navigate to join as a doctor screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JoinAsDoctorPage()),
                  );
                },
              ),
              ListTile(
                leading: Image.network(
                  'https://img.icons8.com/?size=48&id=13951&format=png',
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                ),
                onTap: () {
                  // Navigate to settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () async {
                  final User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    // Check if the user signed in with Google
                    if (user.providerData[0].providerId == 'google.com') {
                      // Sign out from Google
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut();
                    }

                    // Sign out from Firebase
                    await FirebaseAuth.instance.signOut();
                  }

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          AuthScreen(), // Navigate to the login page
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hello, $userName!',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 32, 63), // Updated text color
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'How can we assist you today?',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.0),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DashboardButton(
                      title: 'Book Appointments',
                      iconUrl:
                          'https://cdn-icons-png.flaticon.com/128/3584/3584957.png', // URL of the image
                      onTap: () {
                        // Navigate to doctor appointment screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Doctor_Appointment(),
                          ),
                        );
                      },
                    ),
                    DashboardButton(
                      title: 'Book Lab \nTests',
                      iconUrl:
                          'https://cdn-icons-png.flaticon.com/128/8859/8859014.png', // URL of the image
                      onTap: () {
                        // Navigate to lab test booking screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CurrentLocationScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardButton(
                      title: 'Upload Past Prescriptions',
                      iconUrl:
                          'https://cdn-icons-png.flaticon.com/128/6525/6525342.png', // URL of the image
                      onTap: () {
                        // Navigate to upload prescriptions screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HealthRecordsPage(),
                          ),
                        );
                      },
                    ),
                    DashboardButton(
                      title: 'QuickBiteStats:Food Info Hub',
                      iconUrl:
                          'https://cdn-icons-png.freepik.com/512/3703/3703377.png', // URL of the image
                      onTap: () {
                        // Navigate to chat application screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'Recommended Lab Tests',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 32, 63), // Updated text color
                  ),
                ),
                SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/4cb2baf3234-Fullbody.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/e1a18d8deac-Vitamins.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/1e927857c26-Diabetes.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/e1c60c444bf-Fever.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/7b238cdbb60-womencare.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/71fb3c06e71-Thyroid.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/6b775dd8478-covid.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/bca113a1b80-Bone.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/520acd31898-heart.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LabTestSelectPage()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.network(
                            'https://cms-contents.pharmeasy.in/homepage_top_categories_images/9696ef00b0a-lifestyle.png?dim=256x0',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Read About Health: HealthShaala',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 32, 63), // Updated text color
                  ),
                ),
                SizedBox(
                  height: 250, // Adjust the height according to your design
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            HealthArticleCard(
                              'Importance of Sleep',
                              'Getting a good night\'s sleep is crucial for overall health.',
                              imageUrl:
                                  'https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            ),
                            HealthArticleCard(
                              'Benefits of a Healthy Diet',
                              'Eating a balanced diet contributes to better well-being.',
                              imageUrl:
                                  'https://images.pexels.com/photos/1172019/pexels-photo-1172019.jpeg?auto=compress&cs=tinysrgb&w=600',
                            ),
                            HealthArticleCard(
                              'Stress Management',
                              'Learn effective ways to manage stress in your life.',
                              imageUrl:
                                  'https://images.pexels.com/photos/3755761/pexels-photo-3755761.jpeg?auto=compress&cs=tinysrgb&w=600',
                            ),
                            HealthArticleCard(
                              'Exercise for a Healthy Life',
                              'Regular exercise has numerous health benefits.',
                              imageUrl:
                                  'https://images.pexels.com/photos/1199590/pexels-photo-1199590.jpeg?auto=compress&cs=tinysrgb&w=600',
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle See More button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReadAboutHealthPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color.fromRGBO(10, 78, 159, 1),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(
                                color: Color.fromRGBO(10, 78, 159, 1)),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'See More',
                            style: TextStyle(
                              color: Color.fromRGBO(10, 78, 159, 1),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
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
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final String iconUrl; // Change IconData to String
  final VoidCallback onTap;

  DashboardButton({
    required this.title,
    required this.iconUrl, // Change IconData to String
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromARGB(255, 10, 78, 159),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 60.0,
                width: 60.0,
                child: Image.network(
                  iconUrl, // Use the iconUrl property
                  fit: BoxFit.contain, // Fit the image within the box
                  // Apply color if needed
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabTestCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  LabTestCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.0, // Decreased icon size
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0, // Decreased font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0, // Decreased font size
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl; // Image URL

  HealthArticleCard(this.title, this.description, {required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust the width here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 120, // Decreased height of the image
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0, // Decreased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.0, // Decreased font size
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
