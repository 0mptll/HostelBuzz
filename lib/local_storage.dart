// lib/local_storage.dart

import 'maintenance_request.dart';
import 'laundry_request.dart';  // Import the LaundryRequest class

class LocalStorage {
  // Existing maintenance request storage
  static final List<MaintenanceRequest> _maintenanceRequests = [];

  // New laundry request storage
  static final List<LaundryRequest> _laundryRequests = [];

  // Maintenance request methods
  static List<MaintenanceRequest> getMaintenanceRequests() {
    return _maintenanceRequests;
  }

  static void addMaintenanceRequest(MaintenanceRequest request) {
    _maintenanceRequests.add(request);
  }

  static void clearMaintenanceRequests() {
    _maintenanceRequests.clear();
  }

  // Laundry request methods
  static List<LaundryRequest> getLaundryRequests() {
    return _laundryRequests;
  }

  static void addLaundryRequest(LaundryRequest request) {
    _laundryRequests.add(request);
  }

  static void clearLaundryRequests() {
    _laundryRequests.clear();
  }
}
