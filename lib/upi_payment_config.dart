import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class MyTransactionPage extends StatelessWidget {
  // Initialize UpiIndia object
  UpiIndia _upiIndia = UpiIndia();

  // Method to start the transaction
  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "varshavaghela001@okicici",
      receiverName: 'Varsha Vaghela',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 100.00,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get all available UPI apps
    Future<List<UpiApp>> getUpiApps() async {
      return await _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
    }

    return FutureBuilder<List<UpiApp>>(
      future: getUpiApps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the UPI apps list, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If an error occurs while fetching UPI apps, display an error message
          return Center(child: Text('Error fetching UPI apps'));
        } else {
          // Once the UPI apps list is available, display the dialog
          List<UpiApp> apps = snapshot.data ?? [];
          return AlertDialog(
            title: Text('Choose UPI App'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(apps.length, (index) {
                return ListTile(
                  title: Text(apps[index].name),
                  onTap: () async {
                    // Initiate transaction when an UPI app is clicked
                    UpiResponse response = await initiateTransaction(apps[index]);
                    // Handle response here
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }),
            ),
          );
        }
      },
    );
  }
}
