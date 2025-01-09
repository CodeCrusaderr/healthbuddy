import 'package:flutter/material.dart';
import 'doc_dashboard.dart';

class JoinAsDoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Join as a Doctor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please fill in the details to join as a doctor:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Doctor Type',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 0, 32, 63),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Upload Degree Certificate (PDF)',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 32, 63),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement file picker logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Upload'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement submit logic here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorDashboard()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(10, 78, 159, 1),
                foregroundColor: Colors.white,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
