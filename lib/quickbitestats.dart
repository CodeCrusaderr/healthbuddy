import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> csvData = [];
  TextEditingController _controller = TextEditingController();
  List<dynamic> nutritionInfo = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadAsset();
  }

  Future<void> loadAsset() async {
    setState(() {
      _isLoading = true;
    });
    final myData = await rootBundle.loadString('assets/nutrition.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    setState(() {
      csvData = csvTable;
      _isLoading = false;
    });
  }

  void search(String query) {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        nutritionInfo = csvData.firstWhere(
          (row) => row[0].toString().toLowerCase() == query.toLowerCase(),
          orElse: () => ['Sorry, no information found'],
        );
        _isLoading = false;
      });
    });
  }

  Widget _buildNutritionTable(List<dynamic> data) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(10, 78, 159, 1)),
        ),
      );
    } else if (data.isEmpty) {
      return SizedBox.shrink();
    } else if (data.length == 1 && data[0] == 'Sorry, no information found') {
      return Text(
        data[0],
        style: TextStyle(color: Colors.red),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 30.0,
          columns: [
            DataColumn(label: Text('Nutrient', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: [
            _buildDataRow('Energy (kCal)', '${data[2]}'),
            _buildDataRow('Carbohydrates (g)', '${data[3]}'),
            _buildDataRow('Protein (g)', '${data[4]}'),
            _buildDataRow('Fiber (g)', '${data[5]}'),
            _buildDataRow('Sugar (g)', '${data[6]}'),
            _buildDataRow('Total Fat (g)', '${data[7]}'),
            _buildDataRow('Saturated Fat (g)', '${data[8]}'),
            _buildDataRow('Trans Fat (g)', '${data[9]}'),
            _buildDataRow('Cholesterol (mg)', '${data[10]}'),
            _buildDataRow('Sodium (mg)', '${data[11]}'),
          ],
        ),
      );
    }
  }

  DataRow _buildDataRow(String nutrient, String value) {
    return DataRow(cells: [
      DataCell(Text(nutrient)),
      DataCell(Text(value)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QuickBiteStats',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter product name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                suffixIcon: IconButton(
                  onPressed: () => _controller.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                search(_controller.text);
              },
              child: Text('Send', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(10, 78, 159, 1),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _buildNutritionTable(nutritionInfo),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
