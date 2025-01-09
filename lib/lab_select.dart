import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/lab_recipt.dart';
import 'package:dashboard/lab_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LabTestSelectPage(),
  ));
}

class LabTest {
  final String name;
  final int price;
  final String description;
  final String prerequisites;

  LabTest({
    required this.name,
    required this.price,
    required this.description,
    required this.prerequisites,
  });
}

final List<LabTest> labTests = [
  LabTest(
    name: 'Complete Blood Count (CBC)',
    price: 500,
    description:
        'A Complete Blood Count (CBC) is a routine blood test that provides detailed information about different types of cells in your blood, including red blood cells, white blood cells, and platelets. It helps in diagnosing various conditions such as anemia, infection, and blood disorders.',
    prerequisites:
        '• Fast for 8-12 hours before the test, drinking only water.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
        '• Wear loose-fitting clothing to facilitate blood sample collection.',
  ),
  LabTest(
    name: 'Basic Metabolic Panel (BMP)',
    price: 400,
    description:
        'The BMP measures your blood glucose level, electrolyte balance, and kidney function, providing important information about your metabolic health. It aids in detecting conditions like diabetes, kidney disease, and electrolyte imbalances.',
    prerequisites:
        '• Fast for 8-12 hours prior to the test, drinking only water.\n'
        '• Refrain from consuming alcohol or engaging in strenuous exercise for at least 24 hours before the test.\n'
        '• Follow any additional instructions provided by your doctor.',
  ),
  LabTest(
    name: 'Lipid Panel',
    price: 600,
    description:
        'This test measures cholesterol levels and triglycerides in your blood, helping assess your risk for cardiovascular diseases. It helps in evaluating the risk of developing cardiovascular diseases such as heart attacks and strokes.',
    prerequisites:
        '• Fast for 9-12 hours before the test, drinking only water.\n'
        '• Avoid consuming alcohol and fatty foods for at least 24 hours prior to the test.\n'
        '• Inform your healthcare provider about any medications you\'re taking, as some may affect lipid levels.',
  ),
  LabTest(
    name: 'Liver Function Tests (LFTs)',
    price: 450,
    description:
        'LFTs assess the health of your liver by measuring levels of enzymes and other substances in the blood associated with liver function. They help diagnose liver diseases such as hepatitis, cirrhosis, and fatty liver disease.',
    prerequisites:
        '• Fast for 8-12 hours prior to the test, drinking only water.\n'
        '• Avoid alcohol consumption for at least 24 hours before the test.\n'
        '• Inform your doctor about any medications or supplements you\'re currently taking, as they may affect liver function.',
  ),
  LabTest(
    name: 'Thyroid Stimulating Hormone (TSH)',
    price: 300,
    description:
        'The Thyroid Stimulating Hormone (TSH) test measures the level of TSH in the blood, which helps evaluate thyroid function. Abnormal TSH levels may indicate conditions such as hypothyroidism or hyperthyroidism.',
    prerequisites: '• No specific fasting is usually required for this test.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially thyroid medications.\n'
        '• Follow any additional instructions provided by your doctor.',
  ),
  LabTest(
    name: 'Hemoglobin A1c (HbA1c)',
    price: 350,
    description:
        'Hemoglobin A1c (HbA1c) is a blood test that reflects average blood sugar levels over the past 2-3 months. It is commonly used to monitor long-term blood sugar control in people with diabetes.',
    prerequisites: '• No fasting is necessary for this test.\n'
        '• Continue taking your medications as prescribed, including diabetes medications.\n'
        '• Inform your healthcare provider about any recent illnesses or changes in medication.',
  ),
  LabTest(
    name: 'Urinalysis',
    price: 200,
    description:
        'Urinalysis is a test that examines the physical and chemical properties of urine, including its color, clarity, and composition. It helps detect urinary tract infections, kidney disorders, and other health conditions.',
    prerequisites:
        '• Collect a fresh urine sample in a clean container as per your healthcare provider\'s instructions.\n'
        '• Follow any specific instructions provided, such as avoiding certain foods or medications that may interfere with the test results.\n'
        '• Inform your doctor if you\'re menstruating or experiencing any unusual symptoms.',
  ),
  LabTest(
    name: 'C-Reactive Protein (CRP)',
    price: 250,
    description:
        'C-Reactive Protein (CRP) is a marker of inflammation in the body. This blood test measures CRP levels and helps assess the presence and severity of inflammatory conditions such as infections, autoimmune diseases, and cardiovascular diseases.',
    prerequisites: '• No specific fasting is required.\n'
        '• Inform your healthcare provider about any recent infections or inflammatory conditions.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Electrocardiogram (ECG/EKG)',
    price: 700,
    description:
        'An Electrocardiogram (ECG or EKG) is a non-invasive test that records the electrical activity of the heart. It helps diagnose heart conditions such as arrhythmias, heart attacks, and heart rhythm disorders.',
    prerequisites: '• No specific preparation is typically required.\n'
        '• Wear comfortable clothing that allows easy access to your chest area.\n'
        '• Inform the technician if you have any metal implants or devices in your body.',
  ),
  LabTest(
    name: 'Blood Glucose (Fasting)',
    price: 150,
    description:
        'A fasting Blood Glucose test measures the level of glucose in your blood after fasting for a certain period, usually overnight. It helps diagnose diabetes and monitor blood sugar control in individuals with diabetes.',
    prerequisites:
        '• Fast for 8-12 hours before the test, drinking only water.\n'
        '• Avoid consuming food, beverages (except water), and medications that may affect blood sugar levels.\n'
        '• Follow any specific instructions provided by your healthcare provider.',
  ),
  LabTest(
    name: 'Serum Iron',
    price: 250,
    description:
        'The Serum Iron test measures the level of iron in the blood. It is useful in diagnosing conditions such as iron deficiency anemia and hemochromatosis.',
    prerequisites: '• No specific fasting is required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect iron levels.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Vitamin D Test',
    price: 300,
    description:
        'A Vitamin D test measures the level of vitamin D in your blood. It helps assess bone health, calcium metabolism, and overall vitamin D status.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially vitamin D supplements.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Calcium Test',
    price: 200,
    description:
        'The Calcium Test measures the level of calcium in the blood. It is important for bone health, nerve function, and muscle contraction.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect calcium levels.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Potassium Test',
    price: 200,
    description:
        'The Potassium Test measures the level of potassium in the blood. Potassium is essential for proper nerve and muscle function, as well as maintaining fluid balance in the body.',
    prerequisites: '• No specific fasting is typically required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect potassium levels.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Magnesium Test',
    price: 250,
    description:
        'The Magnesium Test measures the level of magnesium in the blood. Magnesium is important for nerve function, muscle contraction, and maintaining a normal heart rhythm.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect magnesium levels.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Thyroid Panel',
    price: 450,
    description:
        'A Thyroid Panel is a group of blood tests that evaluate thyroid function, including TSH, T3, and T4 levels. It helps diagnose thyroid disorders such as hypothyroidism and hyperthyroidism.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially thyroid medications.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Prostate Specific Antigen (PSA)',
    price: 350,
    description:
        'The Prostate Specific Antigen (PSA) test measures the level of PSA in the blood, which can help in the early detection of prostate cancer and monitoring the effectiveness of treatment for prostate conditions.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
        '• Avoid activities such as cycling or sexual intercourse 48 hours before the test, as they may affect PSA levels.',
  ),
  LabTest(
    name: 'Ferritin Test',
    price: 300,
    description:
        'The Ferritin Test measures the level of ferritin in the blood, which reflects the body\'s iron stores. It helps diagnose iron deficiency anemia and monitor treatment response.',
    prerequisites: '• No specific fasting is typically required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect ferritin levels.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Creatinine Test',
    price: 200,
    description:
        'The Creatinine Test measures the level of creatinine in the blood, which is a waste product produced by muscles. It helps assess kidney function and diagnose conditions such as chronic kidney disease.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
        '• Ensure adequate hydration before the test by drinking plenty of water, unless instructed otherwise by your doctor.',
  ),
  LabTest(
    name: 'Hepatitis Panel',
    price: 550,
    description:
        'A Hepatitis Panel is a group of blood tests that detect antibodies and antigens associated with hepatitis viruses. It helps diagnose hepatitis infections and assess liver function.',
    prerequisites: '• No specific fasting is typically required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'HIV Test',
    price: 400,
    description:
        'The HIV Test detects antibodies or antigens produced by the body in response to the human immunodeficiency virus (HIV). It is used to diagnose HIV infection and screen for the virus.',
    prerequisites: '• No specific fasting is usually required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
        '• Be prepared for pre-test counseling to understand the implications of the test results.',
  ),
  LabTest(
    name: 'Coagulation Panel',
    price: 600,
    description:
        'A Coagulation Panel is a group of blood tests that assess blood clotting function. It helps diagnose bleeding disorders, monitor anticoagulant therapy, and evaluate clotting ability before surgery.',
    prerequisites: '• No specific fasting is typically required.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially blood-thinning medications.\n'
        '• Follow any additional instructions provided by your doctor for accurate test results.',
  ),
  LabTest(
    name: 'Stool Culture',
    price: 350,
    description:
        'A Stool Culture is a laboratory test that detects and identifies bacteria or other pathogens in a stool sample. It helps diagnose gastrointestinal infections such as bacterial gastroenteritis.',
    prerequisites: '• No specific fasting is required.\n'
        '• Collect a fresh stool sample as per your healthcare provider\'s instructions.\n'
        '• Ensure the sample is properly stored and transported to the laboratory in a timely manner.',
  ),
  LabTest(
    name: 'Pap Smear',
    price: 300,
    description:
        'A Pap Smear, also known as a Pap Test, is a screening procedure to detect cervical cancer and abnormalities in cervical cells. It involves collecting cells from the cervix for examination under a microscope.',
    prerequisites:
        '• Avoid using vaginal creams, lubricants, or douches for 48 hours before the test.\n'
        '• Schedule the test for a time when you are not menstruating, if possible.\n'
        '• Inform your healthcare provider about any concerns or symptoms you may have.',
  ),
  LabTest(
    name: 'Mammogram',
    price: 500,
    description:
        'A Mammogram is a low-dose X-ray of the breast used to detect breast cancer in its early stages. It is an essential screening tool for women to assess breast health.',
    prerequisites:
        '• Schedule the mammogram for a time when your breasts are least likely to be tender, typically one week after menstruation.\n'
        '• Avoid using deodorants, powders, or creams on your breasts and underarms on the day of the test.\n'
        '• Inform your healthcare provider if you have breast implants or any breast symptoms.',
  ),
  LabTest(
    name: 'Colonoscopy',
    price: 800,
    description:
        'A Colonoscopy is a procedure that allows a doctor to examine the inner lining of your large intestine (colon) for abnormalities, such as polyps or cancer. It is an important screening test for colorectal cancer.',
    prerequisites:
        '• Follow a clear liquid diet and use laxatives or enemas as instructed to cleanse your colon before the procedure.\n'
        '• Arrange for someone to drive you home after the procedure, as you may still be groggy from sedation.\n'
        '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as well as any health conditions you have.',
  ),
];

class LabTestSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Lab Tests',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: labTests.length,
        itemBuilder: (context, index) {
          final labTest = labTests[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            child: ListTile(
              title: Text(
                labTest.name,
                style: TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                'Price: ₹ ${labTest.price}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabTestDetailsPage(labTest: labTest),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class LabTestDetailsPage extends StatefulWidget {
  final LabTest labTest;

  LabTestDetailsPage({required this.labTest});

  @override
  _LabTestDetailsPageState createState() => _LabTestDetailsPageState();
}

class _LabTestDetailsPageState extends State<LabTestDetailsPage> {
  bool agreeToTerms = false;

  void _showTermsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
          content: Text(
              'Please agree to the terms and conditions before proceeding.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.labTest.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.labTest.description,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Guidelines:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(widget.labTest.prerequisites,
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                    activeColor: Colors.green,
                    shape: CircleBorder(),
                  ),
                  Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
            if (agreeToTerms) TimeSlotWidget(labTest: widget.labTest),
          ],
        ),
      ),
    );
  }
}

class TimeSlotWidget extends StatefulWidget {
  final LabTest labTest;

  TimeSlotWidget({required this.labTest});

  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  final user = FirebaseAuth.instance.currentUser!;
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

        print('Query returned ${querySnapshot.docs.length} documents');

        if (querySnapshot.docs.isNotEmpty) {
          // If the query returns at least one document, use the 'name' field of the first document
          print('First document data: ${querySnapshot.docs[0].data()}');

          setState(() {
            userName = querySnapshot.docs[0]['name'];
          });
          print(userName);
        }
      }
    }
  }

  String userId = FirebaseAuth.instance.currentUser!.uid;
  List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
  ];

  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Available Time Slots:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: timeSlots
                .map(
                  (slot) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = slot;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
                      decoration: BoxDecoration(
                        color: selectedTimeSlot == slot
                            ? Colors.blue
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(slot),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (selectedTimeSlot == null) {
                  // Show a popup if no time slot is selected
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('No Time Slot Selected'),
                        content: Text(
                            'Please select a time slot before confirming.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Navigate to the receipt page with selected information
                  var firestore = FirebaseFirestore.instance;

                  // Create a new document for the user with the user's ID
                  var userDoc = firestore.collection('usersLabTests').doc(
                      'userId'); // Replace 'userId' with the actual user's ID

                  // Update the user's document with the booked time slot
                  await userDoc.set({
                    'timeSlot': selectedTimeSlot,
                    'LabTestName': widget.labTest.name,
                  });

                  // Create a new document in the 'bookedTimeSlots' collection with the time slot
                  var timeSlotDoc =
                      firestore.collection('bookedLabSlots').doc();

                  // Update the time slot document with the user's ID and the booked time slot
                  await timeSlotDoc.set({
                    'userId':
                        userId, // Replace 'userId' with the actual user's ID
                    'timeSlot': selectedTimeSlot,
                    'LabTest': widget.labTest.name,
                  });

                  // Navigate to the receipt page with selected information
                  if (selectedTimeSlot != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptPage(
                          patientName: userName ?? 'Unknown user',
                          labTestSelected: widget.labTest.name,
                          price: widget.labTest.price,
                          timeSlotSelected: selectedTimeSlot ?? '',
                        ),
                      ),
                    );
                  } else {
                    print('selectedTimeSlot is null');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 125.0),
                backgroundColor:
                    Color.fromRGBO(10, 78, 159, 1), // Appbar blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // No rounded corners
                ),
              ),
              child: Text(
                'CONFIRM',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
