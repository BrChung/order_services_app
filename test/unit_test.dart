import 'package:test/test.dart';
import 'package:order_services_app/services/models.dart';

// Receving null values from database can result in the app stack collapsing, resulting in a run-time error.
//The tests will ensure the model is displaying at least empty strings to ensure the app does not crash due to incomplete server data.

void main() {
  test('Location Model (Empty)', () {
    List<Location> locations = [];
    locations.map((location) => {
          expect(location.img, 'default.jpg'),
          expect(location.title, ''),
          expect(location.description, ''),
        });
  });
  test('Report Model (No Purchase History)', () {
    List<Report> reports = [];
    reports.map((report) => {
          expect(report.total, 0),
          expect(report.service, {}),
        });
  });
  test('Service Model (Null Description)', () {
    List<Service> services = [
      Service(
          id: 'testID',
          type: 'Drinks',
          img: 'image.png',
          title: 'Test Location')
    ];
    services.map((service) => {
          expect(service.id, 'testID'),
          expect(service.type, 'Drinks'),
          expect(service.img, 'image.png'),
          expect(service.title, 'Test Location'),
          expect(service.description, ''),
        });
  });
}
