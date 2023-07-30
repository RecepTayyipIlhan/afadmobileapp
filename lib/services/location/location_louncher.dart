import 'package:flutter/rendering.dart';
import 'package:location/location.dart';

class Requests {
  Location location = Location();

  void requestService() async {
    final enabled = await location.serviceEnabled();
    if (enabled != true) {
      location.requestService().then((value) {
        print((value).toString());
      });
    } else {
      print("already service enabled");
    }
  }

  void requestPermission() async {
    if (await location.hasPermission() != PermissionStatus.granted) {
      location.requestService().then((value) {
        print((value).toString());
      });
    } else {
      print("Already has permission");
    }
  }

  /*List get_location() {
    var loc = [];
    location.getLocation().then((value) {
      loc.add(value.latitude);
      loc.add(value.longitude);
      print(value.latitude.toString());
      print(value.longitude.toString());
    });
    return loc;
  }*/
}

/*class LocationLauncher extends StatefulWidget {
  @override
  State<LocationLauncher> createState() => _LocationLauncherState();
}
class _LocationLauncherState extends State<LocationLauncher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(onPressed: (){}, child: child)
          ],
        ),
      ),
    );
  }
}*/