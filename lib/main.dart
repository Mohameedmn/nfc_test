import 'package:flutter/material.dart';
import 'get_data.dart'; // Import your GetData class

void main() {
  runApp(MaterialApp(
    home: DataFromJavaScreen(),
  ));
}

class DataFromJavaScreen extends StatefulWidget {
  const DataFromJavaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataFromJavaScreenState createState() => _DataFromJavaScreenState();
}

class _DataFromJavaScreenState extends State<DataFromJavaScreen> {
  String _data = 'Press the button to get data from Java';

  void _fetchData() async {
    String result = await GetData.getDataFromJava();
    setState(() {
      _data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Java Data Example')),
      body: Center(child: Text(_data, textAlign: TextAlign.center)),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        tooltip: 'Fetch Data',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
