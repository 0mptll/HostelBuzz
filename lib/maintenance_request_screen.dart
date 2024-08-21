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

  // List of rooms and wings/buildings
  String? _selectedRoom;
  String? _selectedWing;

  List<String> rooms = ['101', '102', '103', '104'];
  List<String> wings = ['A', 'B', 'C', 'D'];

  void _submitRequest() {
    final issueDescription = _issueDescriptionController.text;

    // Check if any required fields are empty
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

    LocalStorage.addRequest(request);

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
    final requests = LocalStorage.getRequests();

    return Scaffold(
      appBar: AppBar(title: Text('Maintenance Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Wing'),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Room Number'),
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
