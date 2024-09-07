// lib/laundry_request.dart

class LaundryRequest {
  final String studentName;
  final String requestDate;
  final String status;
  final String preferredTime;
  final String notes;
  final String roomNumber; // Add this property

  LaundryRequest({
    required this.studentName,
    required this.requestDate,
    required this.status,
    required this.preferredTime,
    required this.notes,
    required this.roomNumber, // Initialize this property
  });

  // Optionally, you can add a method to convert this object to a map if needed for storage
  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'requestDate': requestDate,
      'status': status,
      'preferredTime': preferredTime,
      'notes': notes,
      'roomNumber': roomNumber,
    };
  }
}
