import 'package:flutter/material.dart';
import 'local_storage.dart';
import 'maintenance_request.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  @override
  _MaintenanceRequestScreenState createState() => _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  final _roomNumberController = TextEditingController();
  final _issueDescriptionController = TextEditingController();

  void _submitRequest() {
    final roomNumber = _roomNumberController.text;
    final issueDescription = _issueDescriptionController.text;

    if (roomNumber.isEmpty || issueDescription.isEmpty) {
      return;
    }

    final request = MaintenanceRequest(
      roomNumber: roomNumber,
      issueDescription: issueDescription,
    );

    LocalStorage.addRequest(request);

    _roomNumberController.clear();
    _issueDescriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Maintenance request submitted!')),
    );

    setState(() {}); // Refresh the list of requests
  }

  @override
  Widget build(BuildContext context) {
    final requests = LocalStorage.getRequests();

    return Scaffold(
      appBar: AppBar(title: Text('Maintenance Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _roomNumberController,
              decoration: InputDecoration(labelText: 'Room Number'),
            ),
            TextField(
              controller: _issueDescriptionController,
              decoration: InputDecoration(labelText: 'Issue Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRequest,
              child: Text('Submit Request'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return ListTile(
                    title: Text('Room: ${request.roomNumber}'),
                    subtitle: Text('Issue: ${request.issueDescription}'),
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
