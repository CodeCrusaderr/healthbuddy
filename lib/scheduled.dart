import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Appointment {
  String doctorName;
  String time;
  bool completed;

  Appointment(
      {required this.doctorName, required this.time, this.completed = false});
}

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final user = FirebaseAuth.instance.currentUser!.displayName;

  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  void fetchAppointments() async {
    final firestore = FirebaseFirestore.instance;
    final userAppointments = firestore
        .collection('userAppointments')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final data = (await userAppointments).data();
    if (data != null && data['appointments'] is List) {
      setState(() {
        appointments = List<Map<String, dynamic>>.from(data['appointments']);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        centerTitle: true,
        title: Text('Scheduled Appointments',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            return Card(
              color: Color.fromRGBO(10, 78, 159, 1),
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Appointment with ${appointment['DoctorName']}',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                subtitle: Text('Time: ${appointment['time']}',
                    style: TextStyle(
                        color: Colors.yellow, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    );
  }
}
