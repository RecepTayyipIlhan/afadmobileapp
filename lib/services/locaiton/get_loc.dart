import 'package:location/location.dart';

import '../../locat.dart';

class Loc{
  Location location = Location();

  List get_location() {

    location.getLocation().then((value) {
      listloc.add(value.latitude);
      listloc.add(value.longitude);
      print(value.latitude);
      print(value.longitude);
    });
    return listloc;
  }
}



