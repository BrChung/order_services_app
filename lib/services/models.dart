///// Database Collections

class Service {
  String id;
  String title;
  String description;
  String img;
  String type;

  Service({this.title, this.img, this.description, this.id, this.type});

  factory Service.fromMap(Map data) {
    return Service(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? '',
    );
  }
}

class Location {
  final String id;
  final String title;
  final String description;
  final String img;
  final String address;
  final String type;
  final List<Service> services;

  Location(
      {this.id,
      this.title,
      this.description,
      this.img,
      this.address,
      this.type,
      this.services});

  factory Location.fromMap(Map data) {
    return Location(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.jpg',
      address: data['address'] ?? '',
      type: data['type'] ?? '',
      services: (data['service'] as List ?? [])
          .map((v) => Service.fromMap(v))
          .toList(), //data['services'],
    );
  }
}

class Report {
  String uid;
  int total;
  dynamic service;

  Report({this.uid, this.total, this.service});

  factory Report.fromMap(Map data) {
    return Report(
      uid: data['uid'],
      total: data['total'] ?? 0,
      service: data['service'] ?? {},
    );
  }
}
