import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:dashboard/upi_payment_config.dart';

class ReceiptPage extends StatefulWidget {
  final String patientName;
  final String labTestSelected;
  final int price;
  final String timeSlotSelected;

  ReceiptPage({
    required this.patientName,
    required this.labTestSelected,
    required this.price,
    required this.timeSlotSelected,
  });

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
      accountSid: "AC95efc63bc754f1a7b08eb0b396cf1530",
      authToken: "fed3ef2442085ed327c0945a738ab522",
      twilioNumber: "+17012034268",
    );
    super.initState();
  }

  void sendSms(String guidelines) async {
    try {
      await twilioFlutter.sendSMS(
        toNumber: '+919820791925',
        messageBody:
            'CONFIRMED! Your Lab Test for ${widget.labTestSelected} at Healthbuddy Labs at ${widget.timeSlotSelected}. Guidelines:\n${guidelines}',
      );
      print("SMS sent successfully!");
    } catch (e) {
      print("Failed to send SMS: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Receipt',
          style: TextStyle(
            color: Colors.white, // White text color
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1), // Appbar blue color
        iconTheme: IconThemeData(color: Colors.white), // White icon color
      ),
      backgroundColor: Colors.white, // Set the body color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Patient Name:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.patientName,
              style: TextStyle(fontSize: 18),
            ),
            Divider(), // Horizontal line
            SizedBox(height: 16),
            Text(
              'Lab Test Selected:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.labTestSelected,
              style: TextStyle(fontSize: 18),
            ),
            Divider(), // Horizontal line
            SizedBox(height: 16),
            Text(
              'Price:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '₹ ${widget.price}',
              style: TextStyle(fontSize: 18),
            ),
            Divider(), // Horizontal line
            SizedBox(height: 16),
            Text(
              'Time Slot Selected:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.timeSlotSelected,
              style: TextStyle(fontSize: 18),
            ),
            Divider(), // Horizontal line
            SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                _startRazorpayPayment(context);
                sendSms(getGuidelines(widget.labTestSelected));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Rectangular button
                ),
                backgroundColor:
                    Color.fromRGBO(10, 78, 159, 1), // Appbar blue color
              ),
              child: Text('Pay using Credit/Debit Card',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                sendSms(getGuidelines(widget.labTestSelected));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTransactionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Rectangular button
                ),
                backgroundColor: Colors.blue, // Blue color
              ),
              child:
                  Text('Pay using UPI', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _startRazorpayPayment(BuildContext context) {
    final razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      print("Payment Successful: ${response.paymentId}");
      // Handle success as per your app logic
    });

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      print("Payment Error: ${response.code} - ${response.message}");
      // Handle error as per your app logic
    });

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      print("External Wallet: ${response.walletName}");
      // Handle external wallet selection as per your app logic
    });

    final options = {
      'key': 'rzp_test_MwQLjkgRvRRbdi',
      'amount': widget.price *
          100, // amount in the smallest currency unit (e.g., 100 paise for INR)
      'name': widget.patientName,
      'description': 'Healthcare',
      'prefill': {
        'contact': '9820791925', // replace with customer's phone number
        'email': 'test@example.com', // replace with customer's email
      },
      'theme': {
        'color': '#3399cc',
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  String getGuidelines(String labTestSelected) {
    // List of all lab tests and their corresponding guidelines
    List<Map<String, String>> allLabTestGuidelines = [
      {
        'name': 'Complete Blood Count (CBC)',
        'prerequisites': '• Fast for 8-12 hours before the test, drinking only water.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
            '• Wear loose-fitting clothing to facilitate blood sample collection.'
      },
      {
        'name': 'Basic Metabolic Panel (BMP)',
        'prerequisites':
            '• Fast for 8-12 hours prior to the test, drinking only water.\n'
                '• Refrain from consuming alcohol or engaging in strenuous exercise for at least 24 hours before the test.\n'
                '• Follow any additional instructions provided by your doctor.'
      },
      {
        'name': 'Lipid Panel',
        'prerequisites': '• Fast for 9-12 hours before the test, drinking only water.\n'
            '• Avoid consuming alcohol and fatty foods for at least 24 hours prior to the test.\n'
            '• Inform your healthcare provider about any medications you\'re taking, as some may affect lipid levels.'
      },
      {
        'name': 'Liver Function Tests (LFTs)',
        'prerequisites':
            '• Fast for 8-12 hours prior to the test, drinking only water.\n'
                '• Avoid alcohol consumption for at least 24 hours before the test.\n'
                '• Inform your doctor about any medications or supplements you\'re currently taking, as they may affect liver function.'
      },
      {
        'name': 'Thyroid Stimulating Hormone (TSH)',
        'prerequisites':
            '• No specific fasting is usually required for this test.\n'
                '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially thyroid medications.\n'
                '• Follow any additional instructions provided by your doctor.'
      },
      {
        'name': 'Hemoglobin A1c (HbA1c)',
        'prerequisites': '• No fasting is necessary for this test.\n'
            '• Continue taking your medications as prescribed, including diabetes medications.\n'
            '• Inform your healthcare provider about any recent illnesses or changes in medication.'
      },
      {
        'name': 'Urinalysis',
        'prerequisites':
            '• Collect a fresh urine sample in a clean container as per your healthcare provider\'s instructions.\n'
                '• Follow any specific instructions provided, such as avoiding certain foods or medications that may interfere with the test results.\n'
                '• Inform your doctor if you\'re menstruating or experiencing any unusual symptoms.'
      },
      {
        'name': 'C-Reactive Protein (CRP)',
        'prerequisites': '• No specific fasting is required.\n'
            '• Inform your healthcare provider about any recent infections or inflammatory conditions.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Electrocardiogram (ECG/EKG)',
        'prerequisites': '• No specific preparation is typically required.\n'
            '• Wear comfortable clothing that allows easy access to your chest area.\n'
            '• Inform the technician if you have any metal implants or devices in your body.'
      },
      {
        'name': 'Blood Glucose (Fasting)',
        'prerequisites': '• Fast for 8-12 hours before the test, drinking only water.\n'
            '• Avoid consuming food, beverages (except water), and medications that may affect blood sugar levels.\n'
            '• Follow any specific instructions provided by your healthcare provider.'
      },
      {
        'name': 'Serum Iron',
        'prerequisites': '• No specific fasting is required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect iron levels.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Vitamin D Test',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially vitamin D supplements.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Calcium Test',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect calcium levels.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Potassium Test',
        'prerequisites': '• No specific fasting is typically required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect potassium levels.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Magnesium Test',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect magnesium levels.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Thyroid Panel',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially thyroid medications.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Prostate Specific Antigen (PSA)',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
            '• Avoid activities such as cycling or sexual intercourse 48 hours before the test, as they may affect PSA levels.'
      },
      {
        'name': 'Ferritin Test',
        'prerequisites': '• No specific fasting is typically required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as some may affect ferritin levels.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Creatinine Test',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
            '• Ensure adequate hydration before the test by drinking plenty of water, unless instructed otherwise by your doctor.'
      },
      {
        'name': 'Hepatitis Panel',
        'prerequisites': '• No specific fasting is typically required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'HIV Test',
        'prerequisites': '• No specific fasting is usually required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking.\n'
            '• Be prepared for pre-test counseling to understand the implications of the test results.'
      },
      {
        'name': 'Coagulation Panel',
        'prerequisites': '• No specific fasting is typically required.\n'
            '• Inform your healthcare provider about any medications or supplements you\'re currently taking, especially blood-thinning medications.\n'
            '• Follow any additional instructions provided by your doctor for accurate test results.'
      },
      {
        'name': 'Stool Culture',
        'prerequisites': '• No specific fasting is required.\n'
            '• Collect a fresh stool sample as per your healthcare provider\'s instructions.\n'
            '• Ensure the sample is properly stored and transported to the laboratory in a timely manner.'
      },
      {
        'name': 'Pap Smear',
        'prerequisites':
            '• Avoid using vaginal creams, lubricants, or douches for 48 hours before the test.\n'
                '• Schedule the test for a time when you are not menstruating, if possible.\n'
                '• Inform your healthcare provider about any concerns or symptoms you may have.'
      },
      {
        'name': 'Mammogram',
        'prerequisites':
            '• Schedule the mammogram for a time when your breasts are least likely to be tender, typically one week after menstruation.\n'
                '• Avoid using deodorants, powders, or creams on your breasts and underarms on the day of the test.\n'
                '• Inform your healthcare provider if you have breast implants or any breast symptoms.'
      },
      {
        'name': 'Colonoscopy',
        'prerequisites':
            '• Follow a clear liquid diet and use laxatives or enemas as instructed to cleanse your colon before the procedure.\n'
                '• Arrange for someone to drive you home after the procedure, as you may still be groggy from sedation.\n'
                '• Inform your healthcare provider about any medications or supplements you\'re currently taking, as well as any health conditions you have.'
      }
    ];

    // Find the selected lab test and return its guidelines
    for (var item in allLabTestGuidelines) {
      if (item['name'] == labTestSelected) {
        return item['prerequisites'] ?? ''; // Return guidelines if found
      }
    }

    // Return empty string if no guidelines found for the selected lab test
    return '';
  }
}
