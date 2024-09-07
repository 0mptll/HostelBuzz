// lib/laundry_status_screen.dart

import 'package:flutter/material.dart';
import 'local_storage.dart';
import 'laundry_request_detail_screen.dart';

class LaundryStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final laundryRequests = LocalStorage.getLaundryRequests();

    return Scaffold(
      appBar: AppBar(
        title: Text("Laundry Status"),
        backgroundColor: Colors.teal, // AppBar background color
      ),
      body: ListView.builder(
        itemCount: laundryRequests.length,
        itemBuilder: (ctx, index) {
          final request = laundryRequests[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                request.studentName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                "Requested on: ${request.requestDate}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: Text(
                request.status,
                style: TextStyle(
                  color: request.status == 'Pending' ? Colors.orange : Colors.green,
                ),
              ),
              onTap: () {
                // Navigate to details screen with the selected request
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LaundryRequestDetailScreen(request: request),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
