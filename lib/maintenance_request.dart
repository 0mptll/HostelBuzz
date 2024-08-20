class MaintenanceRequest {
  String roomNumber;
  String issueDescription;

  MaintenanceRequest({
    required this.roomNumber,
    required this.issueDescription,
  });

  // Convert a MaintenanceRequest into a map for local storage
  Map<String, dynamic> toMap() {
    return {
      'roomNumber': roomNumber,
      'issueDescription': issueDescription,
    };
  }

  // Create a MaintenanceRequest from a map
  factory MaintenanceRequest.fromMap(Map<String, dynamic> map) {
    return MaintenanceRequest(
      roomNumber: map['roomNumber'],
      issueDescription: map['issueDescription'],
    );
  }
}
