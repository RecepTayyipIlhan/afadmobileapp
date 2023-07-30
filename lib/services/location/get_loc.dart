import 'package:flutter/rendering.dart';
import 'package:location/location.dart';

import '../../global_data.dart';

class Loc {
  Location location = Location();

  List getLocation() {
    location.getLocation().then((value) {
      listloc.add(value.latitude);
      listloc.add(value.longitude);
      print((value.latitude).toString());
      print((value.longitude).toString());
    });
    return listloc;
  }
}
