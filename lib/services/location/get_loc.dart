import 'package:flutter/rendering.dart';
import 'package:location/location.dart';

import '../../locat.dart';

class Loc {
  Location location = Location();

  List getLocation() {
    location.getLocation().then((value) {
      listloc.add(value.latitude);
      listloc.add(value.longitude);
      debugPrint((value.latitude).toString());
      debugPrint((value.longitude).toString());
    });
    return listloc;
  }
}
