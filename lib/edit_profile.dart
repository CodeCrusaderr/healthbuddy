import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'patient_dashboard.dart';

class Edits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(10, 78, 159, 1),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 0, 32, 63),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Color.fromARGB(255, 0, 32, 63),
          unselectedLabelColor: Color.fromARGB(255, 0, 32, 63).withOpacity(0.5),
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 0, 32, 63),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final picker = ImagePicker();
  File? _imageFile;

  Future<File?> _getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientDashboard()),
            ); // Navigate back to the previous screen
          },
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'Medical'),
              Tab(text: 'Lifestyle'),
            ],
          ),
          body: TabBarView(
            children: [
              PersonalSection(onImageUpload: _getImage, imageFile: _imageFile),
              MedicalSection(),
              Lifestyle(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PersonalSection extends StatefulWidget {
  final Function(ImageSource) onImageUpload;
  File? imageFile;

  PersonalSection({required this.onImageUpload, required this.imageFile});

  @override
  _PersonalSectionState createState() => _PersonalSectionState();
}

class _PersonalSectionState extends State<PersonalSection> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _bloodGroupController = TextEditingController();
  TextEditingController _emergencyContactController = TextEditingController();

  String? imageUrl;

  Future<void> pickedImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File file = File(
          pickedImage.path); // Get the image file and store it in a variable

      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;

        // Upload the image to Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child(userId);
        await ref.putFile(file);

        // Get the download URL of the uploaded image
        imageUrl = await ref.getDownloadURL();

        // Create a document in the 'profile_pictures' collection with the download URL of the uploaded image
        await FirebaseFirestore.instance
            .collection('profile_pictures')
            .doc(userId)
            .set({
          'imageUrl': imageUrl,
        });

        // Update the UI
        setState(() {});
      }
    }
  }

  void fetchImageUrl() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final doc = await FirebaseFirestore.instance
          .collection('profile_pictures')
          .doc(userId)
          .get();
      setState(() {
        imageUrl = doc.data()?['imageUrl'] as String?;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImageUrl();
    fetchUserData();
  }

  fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Personal Details')
          .doc(user.uid)
          .get();
      setState(
        () {
          _nameController.text = docSnapshot['name'];
          _contactController.text = docSnapshot['contact'];
          _emailController.text = docSnapshot['email'];
          _dobController.text = docSnapshot['dob'];
          _heightController.text = docSnapshot['height'];
          _weightController.text = docSnapshot['weight'];
          _bloodGroupController.text = docSnapshot['bloodGroup'];
          _emergencyContactController.text = docSnapshot['emergencyContact'];
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Upload Photo'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Choose from Gallery'),
                          onTap: () async {
                            Navigator.pop(context);
                            await pickedImage();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Take a Photo'),
                          onTap: () async {
                            final pickedImage =
                                await widget.onImageUpload(ImageSource.camera);
                            setState(() {
                              widget.imageFile = pickedImage;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
            ),
          ),
          SizedBox(height: 10.0),
          imageUrl == null
              ? Text(
                  'Tap to upload profile picture',
                  style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
                )
              : SizedBox.shrink(),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
          TextFormField(
            controller: _contactController,
            decoration: InputDecoration(labelText: 'Contact No.'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email ID'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
              fontSize: 16,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: _dobController,
            decoration: InputDecoration(labelText: 'Date of Birth'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
            keyboardType: TextInputType.datetime,
          ),
          TextFormField(
            controller: _heightController,
            decoration: InputDecoration(labelText: 'Height'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
          TextFormField(
            controller: _weightController,
            decoration: InputDecoration(labelText: 'Weight in Kgs'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _bloodGroupController,
            decoration: InputDecoration(labelText: 'Blood Group'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
          ),
          TextFormField(
            controller: _emergencyContactController,
            decoration: InputDecoration(labelText: 'Emergency Contact'),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 63),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20.0),
          Text(
            'Please Click on the Button below to Save your details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                print("SAVE BUTTON PRESSED");
                // Get the current user
                final user =
                    FirebaseAuth.instance.currentUser; // Get the current user
                if (user != null) {
                  final userId = user.uid;

                  // Update the user's details in the 'users' collection
                  await FirebaseFirestore.instance
                      .collection('Personal Details')
                      .doc(userId)
                      .set(
                    {
                      'userId': userId,
                      'name': _nameController.text,
                      'contact': _contactController.text,
                      'email': _emailController.text,
                      'dob': _dobController.text,
                      'height': _heightController.text,
                      'weight': _weightController.text,
                      'bloodGroup': _bloodGroupController.text,
                      'emergencyContact': _emergencyContactController.text,
                    },
                  );
                }
              },
              child: Text(
                'Save your Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                backgroundColor: Color.fromARGB(255, 10, 78, 159),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MedicalSection extends StatefulWidget {
  const MedicalSection({super.key});

  @override
  State<MedicalSection> createState() => _MedicalSectionState();
}

class _MedicalSectionState extends State<MedicalSection> {
  TextEditingController _pastMedicationsController = TextEditingController();
  TextEditingController _presentMedicationsController = TextEditingController();
  TextEditingController _pastSurgeriesController = TextEditingController();
  TextEditingController _allergiesController = TextEditingController();
  TextEditingController _injuriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserMed();
  }

  fetchUserMed() async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Medical Details')
          .doc(user.uid)
          .get();
      setState(() {
        _pastMedicationsController.text = docSnapshot['pastMedications'];
        _presentMedicationsController.text = docSnapshot['presentMedications'];
        _pastSurgeriesController.text = docSnapshot['pastSurgeries'];
        _allergiesController.text = docSnapshot['allergies'];
        _injuriesController.text = docSnapshot['injuries'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _pastMedicationsController,
            decoration: InputDecoration(labelText: 'Past Medications'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _presentMedicationsController,
            decoration: InputDecoration(labelText: 'Present Medications'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _pastSurgeriesController,
            decoration: InputDecoration(labelText: 'Past Surgeries'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _allergiesController,
            decoration: InputDecoration(labelText: 'Allergies'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _injuriesController,
            decoration: InputDecoration(labelText: 'Injuries Or Disabilities'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          SizedBox(height: 20.0),
          Text(
            'Please Click on the Button below to Save your details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Get the current user
                final user =
                    FirebaseAuth.instance.currentUser; // Get the current user
                if (user != null) {
                  final userId = user.uid;

                  // Update the user's details in the 'users' collection
                  await FirebaseFirestore.instance
                      .collection('Medical Details')
                      .doc(userId)
                      .set(
                    {
                      'userId': userId,
                      'pastMedications': _pastMedicationsController.text,
                      'presentMedications': _presentMedicationsController.text,
                      'pastSurgeries': _pastSurgeriesController.text,
                      'allergies': _allergiesController.text,
                      'injuries': _injuriesController.text,
                    },
                  );
                }
              },
              child: Text(
                'Save your Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                backgroundColor: Color.fromARGB(255, 10, 78, 159),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Lifestyle extends StatefulWidget {
  const Lifestyle({super.key});

  @override
  State<Lifestyle> createState() => _LifestyleState();
}

class _LifestyleState extends State<Lifestyle> {
  TextEditingController _smokingHabitsController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _alcoholConsumptionController = TextEditingController();
  TextEditingController _activityLevelController = TextEditingController();
  TextEditingController _foodPreferenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserLifeStyle();
  }

  fetchUserLifeStyle() async {
    var _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Lifestyle Details')
          .doc(user.uid)
          .get();
      setState(() {
        _smokingHabitsController.text = docSnapshot['smokingHabits'];
        _occupationController.text = docSnapshot['occupation'];
        _alcoholConsumptionController.text = docSnapshot['alcoholConsumption'];
        _activityLevelController.text = docSnapshot['activityLevel'];
        _foodPreferenceController.text = docSnapshot['foodPreference'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _smokingHabitsController,
            decoration: InputDecoration(labelText: 'Smoking Habits(How Often)'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _occupationController,
            decoration: InputDecoration(labelText: 'Occupation'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _alcoholConsumptionController,
            decoration:
                InputDecoration(labelText: 'Alcohol(How Often/Quantity)'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          TextFormField(
            controller: _activityLevelController,
            decoration: InputDecoration(labelText: 'Activity Level'),
            style: TextStyle(color: Color.fromARGB(255, 0, 32, 63)),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Diet Preference'),
            items: <String>['Veg', 'Non-Veg']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _foodPreferenceController.text = newValue!;
              });
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Please Click on the Button below to Save your details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Get the current user
                final user =
                    FirebaseAuth.instance.currentUser; // Get the current user
                if (user != null) {
                  final userId = user.uid;

                  // Update the user's details in the 'users' collection
                  await FirebaseFirestore.instance
                      .collection('Lifestyle Details')
                      .doc(userId)
                      .set(
                    {
                      'userId': userId,
                      'smokingHabits': _smokingHabitsController.text,
                      'occupation': _occupationController.text,
                      'alcoholConsumption': _alcoholConsumptionController.text,
                      'activityLevel': _activityLevelController.text,
                      'foodPreference': _foodPreferenceController.text,
                    },
                  );
                }
              },
              child: Text(
                'Save your Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                backgroundColor: Color.fromARGB(255, 10, 78, 159),
              ),
            ),
          )
        ],
      ),
    );
  }
}
