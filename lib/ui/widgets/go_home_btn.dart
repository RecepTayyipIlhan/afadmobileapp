import 'package:flutter/material.dart';

import '../../utils/route_table.dart';
import '../../utils/utils.dart';

class GoHomeBtn extends StatelessWidget {
  const GoHomeBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        while (true) {
          final router = GoRouter.of(context);

          final loc = router.location;

          if (loc == RouteTable.initialLocation) {
            break;
          }

          router.pop();
        }
      },
      child: Text(
        getStr('go_back_to_home'),
      ),
    );
  }
}
