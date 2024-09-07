// lib/laundry_request_detail_screen.dart

import 'package:flutter/material.dart';
import 'laundry_request.dart';

class LaundryRequestDetailScreen extends StatelessWidget {
  final LaundryRequest request;

  LaundryRequestDetailScreen({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laundry Request Details"),
        backgroundColor: Colors.teal, // Consistent theme color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildDetailTile("Name", request.studentName),
            _buildDetailTile("Requested on", request.requestDate),
            _buildDetailTile("Preferred Pick-up Time", request.preferredTime),
            _buildDetailTile("Notes", request.notes),
            _buildDetailTile("Room", request.roomNumber),
            _buildDetailTile("Status", request.status),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "$label:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
