import 'maintenance_request.dart';

class LocalStorage {
  static final List<MaintenanceRequest> _requests = [];

  static List<MaintenanceRequest> getRequests() {
    return _requests;
  }

  static void addRequest(MaintenanceRequest request) {
    _requests.add(request);
  }

  static void clearRequests() {
    _requests.clear();
  }
}
