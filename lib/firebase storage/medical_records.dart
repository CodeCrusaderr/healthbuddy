import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HealthRecordsPage extends StatefulWidget {
  @override
  _HealthRecordsPageState createState() => _HealthRecordsPageState();
}

class _HealthRecordsPageState extends State<HealthRecordsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> healthRecords = [];

  @override
  void initState() {
    super.initState();
    _getPDFs();
  }

  Future<void> _getPDFs() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final querySnapshot =
          await _firestore.collection('uploads').doc(userId).get();
      if (querySnapshot.exists) {
        setState(() {
          healthRecords =
              List<Map<String, dynamic>>.from(querySnapshot.data()!['files']);
        });
      }
    }
  }

  Future<String> _uploadPDF(String fileName, File file) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final reference =
          FirebaseStorage.instance.ref().child("uploads/$userId/$fileName.pdf");
      final uploadTask = reference.putFile(file);
      await uploadTask.whenComplete(() {});
      final downloadLink = await reference.getDownloadURL();
      return downloadLink;
    } else {
      throw Exception("User not signed in.");
    }
  }

  Future<void> _pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files.first.name;
      File file = File(pickedFile.files.first.path!);
      try {
        String downloadLink = await _uploadPDF(fileName, file);
        await _firestore.collection('uploads').doc(_auth.currentUser!.uid).set({
          'files': FieldValue.arrayUnion([
            {'name': fileName, 'url': downloadLink}
          ])
        }, SetOptions(merge: true));
        await _getPDFs();
      } catch (e) {
        print("Error uploading PDF: $e");
      }
    }
  }

  Future<void> _deletePDF(int index) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      String fileName = healthRecords[index]['name'];
      try {
        await FirebaseStorage.instance
            .ref()
            .child("uploads/$userId/$fileName.pdf")
            .delete();
      } catch (e) {
        print('Failed to delete file from Firebase Storage: $e');
      }
      List<Map<String, dynamic>> updatedRecords = List.from(healthRecords);
      updatedRecords.removeAt(index);
      try {
        await _firestore
            .collection('uploads')
            .doc(userId)
            .update({'files': updatedRecords});
      } catch (e) {
        print('Failed to update Firestore document: $e');
      }
      setState(() {
        healthRecords = updatedRecords;
      });
    } else {
      print('User not signed in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        title: Text('Health Records',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: healthRecords.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PDFViewerScreen(pdfUrl: healthRecords[index]["url"]),
                  ));
                },
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(healthRecords[index]["name"]),
                    trailing: IconButton(
                      color: Color.fromRGBO(10, 78, 159, 1),
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deletePDF(index);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickFile();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;

  PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    _initialisePDF();
  }

  Future<void> _initialisePDF() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(document: document!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
