import 'package:flutter/material.dart';
import 'local_storage.dart';
import 'laundry_request.dart';

class LaundryBookingScreen extends StatefulWidget {
  const LaundryBookingScreen({super.key});

  @override
  _LaundryBookingScreenState createState() => _LaundryBookingScreenState();
}

class _LaundryBookingScreenState extends State<LaundryBookingScreen> {
  final _studentNameController = TextEditingController();
  final _notesController = TextEditingController();
  TimeOfDay? _selectedTime;
  String? _selectedWing;
  String? _selectedRoom;

  List<String> wings = ['A', 'B', 'C', 'D'];
  List<String> rooms = ['101', '102', '103', '104'];

  void _selectTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (time != null && _isTimeValid(time)) {
      setState(() {
        _selectedTime = time;
      });
    } else {
      // Show an error if the selected time is not within the allowed range
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Time"),
          content: const Text("Please select a time between 8:00 AM and 8:00 PM."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  bool _isTimeValid(TimeOfDay time) {
    final now = TimeOfDay.now();
    const start = TimeOfDay(hour: 8, minute: 0);
    const end = TimeOfDay(hour: 20, minute: 0);
    return (time.hour > start.hour || (time.hour == start.hour && time.minute >= start.minute)) &&
        (time.hour < end.hour || (time.hour == end.hour && time.minute <= end.minute));
  }

  void _submitRequest() {
    final studentName = _studentNameController.text;
    final preferredTime = _selectedTime?.format(context) ?? '';
    final notes = _notesController.text;
    final requestDate = DateTime.now().toString();

    if (studentName.isEmpty || preferredTime.isEmpty || _selectedWing == null || _selectedRoom == null) {
      // Show an error dialog if required fields are empty
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please enter all required fields."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    final newRequest = LaundryRequest(
      studentName: studentName,
      requestDate: requestDate,
      status: "Pending",
      preferredTime: preferredTime,
      notes: notes,
      roomNumber: '$_selectedWing-$_selectedRoom', // Combine wing and room number
    );

    LocalStorage.addLaundryRequest(newRequest);

    setState(() {
      // Optional: refresh the UI or show a confirmation
    });

    // Clear the form
    _studentNameController.clear();
    _notesController.clear();
    _selectedTime = null;
    _selectedWing = null;
    _selectedRoom = null;

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Request Submitted"),
        content: const Text("Your laundry request has been submitted."),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Laundry Service"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _studentNameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
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
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
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
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _selectTime,
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: _selectedTime?.format(context) ?? 'Select Preferred Pick-up Time',
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Preferred Pick-up Time',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRequest,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text("Submit Request"),
            ),
          ],
        ),
      ),
    );
  }
}
