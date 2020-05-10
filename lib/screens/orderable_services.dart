import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderableServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.locationsRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          List<Location> locations = snap.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text('Locations'),
              actions: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.userCircle,
                      color: Colors.pink[200]),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                )
              ],
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: locations
                  .map((location) => LocationItem(location: location))
                  .toList(),
            ),
            bottomNavigationBar: AppBottomNav(),
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}

class LocationItem extends StatelessWidget {
  final Location location;
  const LocationItem({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: location.img,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LocationScreen(location: location),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/covers/${location.img}',
                  fit: BoxFit.contain,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          location.title,
                          style: TextStyle(
                              height: 1.5, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    location.type,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationScreen extends StatelessWidget {
  final Location location;

  LocationScreen({this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: location.img,
          child: Image.asset('assets/covers/${location.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          location.title,
          style:
              TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ServiceList(location: location)
      ]),
    );
  }
}

class ServiceList extends StatelessWidget {
  final Location location;
  ServiceList({Key key, this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: location.services.map((service) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 4,
        margin: EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            debugPrint(service.id);
            Global.reportRef.upsert(
              ({
                'total': FieldValue.increment(1),
                'services': {
                  '${location.id}': {'${service.id}': FieldValue.increment(1)}
                }
              }),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                service.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                service.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      );
    }).toList());
  }
}
