import 'services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {
  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    Location: (data) => Location.fromMap(data),
    Service: (data) => Service.fromMap(data),
    Report: (data) => Report.fromMap(data),
  };

  static final Collection<Location> locationsRef =
      Collection<Location>(path: 'locations');

  static final UserData<Report> reportRef =
      UserData<Report>(collection: 'reports');
}
