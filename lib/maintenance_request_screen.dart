import 'package:flutter/material.dart';
import 'DialogBox/ErrorDialog.dart';
import 'DialogBox/SuccessDialog.dart';
import 'local_storage.dart';
import 'maintenance_request.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  @override
  _MaintenanceRequestScreenState createState() => _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  final _issueDescriptionController = TextEditingController();

  String? _selectedRoom;
  String? _selectedWing;

  List<String> rooms = ['101', '102', '103', '104'];
  List<String> wings = ['A', 'B', 'C', 'D'];

  void _submitRequest() {
    final issueDescription = _issueDescriptionController.text;

    if (_selectedRoom == null || _selectedWing == null || issueDescription.isEmpty) {
      showErrorDialog(
        context,
        title: 'Error',
        content: 'Please fill in all the fields before submitting the request.',
      );
      return;
    }

    final request = MaintenanceRequest(
      roomNumber: '$_selectedWing-$_selectedRoom',
      issueDescription: issueDescription,
    );

    LocalStorage.addMaintenanceRequest(request);

    _selectedRoom = null;
    _selectedWing = null;
    _issueDescriptionController.clear();

    showSuccessDialog(
      context,
      title: 'Success',
      content: 'Maintenance request submitted successfully!',
    );

    setState(() {}); // Refresh the list of requests
  }

  @override
  Widget build(BuildContext context) {
    final requests = LocalStorage.getMaintenanceRequests(); // Ensure this method is implemented correctly

    return Scaffold(
      appBar: AppBar(
          title: Text('Maintenance Request'),
          backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Wing',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              value: _selectedWing,
              items: wings.map((wing) {
                return DropdownMenuItem(
                  value: wing,
                  child: Text(wing),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedWing = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Room Number',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              value: _selectedRoom,
              items: rooms.map((room) {
                return DropdownMenuItem(
                  value: room,
                  child: Text(room),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoom = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _issueDescriptionController,
              decoration: InputDecoration(
                labelText: 'Issue Description',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitRequest,
              child: Text('Submit Request'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    child: ListTile(
                      title: Text('Room: ${request.roomNumber}'),
                      subtitle: Text('Issue: ${request.issueDescription}'),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
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
