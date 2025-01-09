import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class DoctorSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Doctor',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          DoctorListItem(name: 'Dr. John Doe', rating: 4),
          DoctorListItem(name: 'Dr. Jane Smith', rating: 5),
          DoctorListItem(name: 'Dr. Emily Brown', rating: 3),
          DoctorListItem(name: 'Dr. Michael Johnson', rating: 4),
          DoctorListItem(name: 'Dr. Sarah Davis', rating: 5),
        ],
      ),
    );
  }
}

class DoctorListItem extends StatefulWidget {
  final String name;
  final int rating;

  DoctorListItem({required this.name, required this.rating});

  @override
  _DoctorListItemState createState() => _DoctorListItemState();
}

class _DoctorListItemState extends State<DoctorListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(
                  () {
                    isExpanded = !isExpanded;
                  },
                );
              },
              leading: CircleAvatar(
                child: Text(
                  widget.name[0], // Display first letter of doctor's name
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color.fromRGBO(10, 78, 159, 1),
              ),
              title: Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                children: List.generate(
                  widget.rating,
                  (index) => Icon(Icons.star, color: Colors.amber, size: 16),
                ),
              ),
            ),
            if (isExpanded) ...[
              TimeSlotSelection(doctorName: widget.name),
            ],
          ],
        ),
      ),
    );
  }
}

class TimeSlotSelection extends StatefulWidget {
  final String doctorName;
  const TimeSlotSelection({super.key, required this.doctorName});

  @override
  State<TimeSlotSelection> createState() => _TimeSlotSelectionState();
}

class _TimeSlotSelectionState extends State<TimeSlotSelection> {
  DateTime? selectedDate;
  List<_TimeSlotButtonState> timeSlotButtonStates = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 365),
                ),
              );

              if (date != null) {
                // Update the selected date
                setState(() {
                  selectedDate = date;
                });
                print("$selectedDate");
              }
            },
            child: Text(
              'Select Date For Appointment..',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // 20 is the radius value
              ),
              backgroundColor: Color.fromRGBO(10, 78, 159, 1),
            ),
          ),
          SizedBox(height: 14.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              5,
              (index) {
                final hour = index + 10;
                final time = '$hour:00';
                final button = TimeSlotButton(
                    time: time,
                    selectedDate: selectedDate,
                    doctorName: widget.doctorName);
                timeSlotButtonStates.add(button.createState());
                return button;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSlotButton extends StatefulWidget {
  final String time;
  final String doctorName;
  final DateTime? selectedDate;

  TimeSlotButton(
      {required this.time,
      required this.doctorName,
      required this.selectedDate});

  @override
  _TimeSlotButtonState createState() => _TimeSlotButtonState();
}

class _TimeSlotButtonState extends State<TimeSlotButton> {
  bool isSelected = false;
  bool isBooked = false; // Add this line

  @override
  void initState() {
    super.initState();
    checkIfSlotIsBooked();
  }

  @override
  void didUpdateWidget(TimeSlotButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      checkIfSlotIsBooked();
    }
  }

  void checkIfSlotIsBooked() async {
    // Get a reference to the Firestore instance
    final firestoreInstance = FirebaseFirestore.instance;

    // Get the document for the specific doctor from the 'appointments' collection
    final doctorDocument = await firestoreInstance
        .collection('appointments')
        .doc(widget.doctorName)
        .get();

    // Get the 'timeSlots' field from the document, which is a list of time slots
    final timeSlots =
        doctorDocument.data()?['timeSlots'] as List<dynamic>? ?? [];

    // Find the time slot that matches the time of this widget
    // final slot = timeSlots.firstWhere((slot) => slot['time'] == widget.time,
    //     orElse: () => null);
    final slot = timeSlots.firstWhere(
        (slot) =>
            slot['time'] == widget.time &&
            slot['selectedDate'].toDate().day == widget.selectedDate?.day &&
            slot['selectedDate'].toDate().month == widget.selectedDate?.month &&
            slot['selectedDate'].toDate().year == widget.selectedDate?.year,
        orElse: () => null);

    // If the slot is found and it's booked (isBooked == true), set isBooked to true
    if (slot != null) {
      setState(
        () {
          isBooked = true;
          ;
        },
      );
    } else {
      setState(() {
        isBooked = slot != null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isBooked
          ? null
          : () async {
              // Disable the button if the slot is booked
              setState(
                () {
                  isSelected = !isSelected;
                },
              );
              if (isSelected) {
                _showConfirmationPopup(context);

                // Get a reference to the Firestore instance
                final firestoreInstance = FirebaseFirestore.instance;

                // Get a reference to the doctor's document
                final doctorDocument = firestoreInstance
                    .collection('appointments')
                    .doc(widget.doctorName);

                // Update the time slot
                await doctorDocument.set({
                  'timeSlots': FieldValue.arrayUnion([
                    {
                      'time': widget.time,
                      'isBooked': true,
                      'username':
                          FirebaseAuth.instance.currentUser!.displayName,
                      'selectedDate': widget.selectedDate != null
                          ? Timestamp.fromDate(widget.selectedDate!)
                          : null,
                    }
                  ])
                }, SetOptions(merge: true));
                setState(() {
                  isBooked = true;
                }); // Use SetOptions(merge: true) to merge new data with existing data
              }

              if (isBooked) {
                final firestore = FirebaseFirestore.instance;
                final userAppointments = firestore
                    .collection('userAppointments')
                    .doc(FirebaseAuth.instance.currentUser!.uid);

                await userAppointments.set({
                  'appointments': FieldValue.arrayUnion([
                    {
                      'time': widget.time,
                      'isBooked': true,
                      'DoctorName': widget.doctorName,
                      'selectedDate': widget.selectedDate != null
                          ? Timestamp.fromDate(widget.selectedDate!)
                          : null,
                    }
                  ])
                }, SetOptions(merge: true));
              }
            },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        backgroundColor: isBooked
            ? Colors.red
            : (isSelected
                ? Colors.black
                : Color.fromRGBO(
                    10, 78, 159, 1)), // Change the color if the slot is booked
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        widget.time,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  void _showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: 300.0,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Confirmed!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(10, 78, 159, 1),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your appointment with ${widget.doctorName} has been confirmed on ${widget.selectedDate?.toLocal().toString().split(' ')[0]} at ${widget.time}.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AppointmentReceiptPage(
                              doctorName: widget.doctorName,
                              time: widget.time,
                              selectedDate: widget.selectedDate!)),
                    );
                  },
                  child: Text(
                    'Proceed to Pay',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppointmentReceiptPage extends StatefulWidget {
  final String doctorName;
  final String time;
  final DateTime selectedDate;

  AppointmentReceiptPage(
      {required this.doctorName,
      required this.time,
      required this.selectedDate});

  @override
  _AppointmentReceiptPageState createState() => _AppointmentReceiptPageState();
}

class _AppointmentReceiptPageState extends State<AppointmentReceiptPage> {
  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    super.initState();
    twilioFlutter = TwilioFlutter(
      accountSid: "",
      authToken: "",
      twilioNumber: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Receipt Page',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReceiptHeader(),
            SizedBox(height: 24.0),
            _buildAppointmentDetails(),
            SizedBox(height: 24.0),
            _buildPaymentOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Receipt',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAppointmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Doctor Name', '${widget.doctorName}'),
        _buildDetailItem('Doctor Type', 'General Physician'),
        _buildDetailItem('Time Slot Selected', '${widget.time}'),
        _buildDetailItem('Location', 'HealthBuddy Labs'),
        SizedBox(height: 16.0),
        Text(
          'Amount: Rs. 100',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _startTransaction();
            sendSms();
          },
          child: Text('Pay with Google Pay',
              style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            backgroundColor: Color.fromRGBO(10, 78, 159, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  void _startTransaction() {
    UpiIndia _upiIndia = UpiIndia();
    _upiIndia
        .startTransaction(
      app: UpiApp.googlePay,
      receiverUpiId: "varshavaghela001@okicici",
      receiverName: 'Varsha Vaghela',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 100.00,
    )
        .then((value) {
      print('Transaction response: $value');
      if (value.status == UpiPaymentStatus.SUCCESS) {
        print('Payment successful!');
      } else {
        print('Payment failed or canceled!');
      }
    }).catchError((error) {
      print('Error initiating transaction: $error');
    });
  }

  void sendSms() async {
    try {
      await twilioFlutter.sendSMS(
          toNumber: '+919820791925',
          messageBody:
              'CONFIRMED! Your Appointment with ${widget.doctorName} is confirmed on ${widget.selectedDate} at ${widget.time}');
      print("SMS sent successfully!");
    } catch (e) {
      print("Failed to send SMS: $e");
    }
  }
}
