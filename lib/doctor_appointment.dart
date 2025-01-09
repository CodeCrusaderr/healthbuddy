import 'package:dashboard/doc_select.dart';
import 'package:flutter/material.dart';

class Doctor_Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(10, 78, 159, 1),
          automaticallyImplyLeading: true, // Set to true to show back button
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Book Appointments',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: false, // Align title to the left
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  DoctorCard(
                    icon: Icons.local_hospital,
                    title: 'General Physician',
                  ),
                  DoctorCard(
                    icon: Icons.bloodtype,
                    title: 'Blood Doctor',
                  ),
                  DoctorCard(
                    icon: Icons.vaccines,
                    title: 'Vaccinologist',
                  ),
                  DoctorCard(
                    icon: Icons.local_pharmacy,
                    title: 'Pharmacist',
                  ),
                  DoctorCard(
                    icon: Icons.healing,
                    title: 'Dressing Doctor',
                  ),
                  DoctorCard(
                    icon: Icons.accessibility,
                    title: 'Orthopedic',
                  ),
                  DoctorCard(
                    icon: Icons.assessment,
                    title: 'Cardiologist',
                  ),
                  DoctorCard(
                    icon: Icons.accessible_forward,
                    title: 'Neurologist',
                  ),
                  DoctorCard(
                    icon: Icons.airline_seat_individual_suite,
                    title: 'Dermatologist',
                  ),
                  DoctorCard(
                    icon: Icons.person_outline,
                    title: 'Pediatrician',
                  ),
                  DoctorCard(
                    icon: Icons.contact_page,
                    title: 'ENT Specialist',
                  ),
                  DoctorCard(
                    icon: Icons.favorite_border,
                    title: 'Cardiovascular Surgeon',
                  ),
                  DoctorCard(
                    icon: Icons.remove_red_eye,
                    title: 'Eye Specialist',
                  ),
                  DoctorCard(
                    icon: Icons.face,
                    title: 'Dermatologist',
                  ),
                  DoctorCard(
                    icon: Icons.spa,
                    title: 'Physiotherapist',
                  ),
                  DoctorCard(
                    icon: Icons.pregnant_woman,
                    title: 'Gynecologist',
                  ),
                  DoctorCard(
                    icon: Icons.developer_board,
                    title: 'Endocrinologist',
                  ),
                  DoctorCard(
                    icon: Icons.local_hotel,
                    title: 'Sleep Specialist',
                  ),
                  // Add more DoctorCard widgets for other types of doctors
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final IconData icon;
  final String title;

  DoctorCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorSelectionPage()),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        child: Card(
          color: Color.fromRGBO(10, 78, 159, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
