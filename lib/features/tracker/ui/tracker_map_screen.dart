import 'package:afad_app/features/tracker/prov/tracker_map_prov.dart';
import 'package:afad_app/ui/widgets/btns/text_btn.dart';
import 'package:afad_app/ui/widgets/error_screen.dart';
import 'package:afad_app/ui/widgets/loading_screen.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../utils/timeago_tr_messages.dart';

class TrackerMapScreen extends ConsumerStatefulWidget {
  const TrackerMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackerMapScreen> createState() => _TrackerMapScreenState();
}

class _TrackerMapScreenState extends ConsumerState<TrackerMapScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    final pageState = ref.watch(trackerMapStateProv);
    final pageNotifier = ref.watch(trackerMapStateProv.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konum Takibi'),
        automaticallyImplyLeading: false,
      ),
      body: Builder(
        builder: (context) {
          final locProv = ref.watch(trakckerLocationProv);

          return locProv.when(
            loading: LoadingScreen.new,
            error: ErrorScreen.new,
            data: (data) {
              final latlng = data.loc;
              final lastUpdated = data.lastUpdated;
              timeago.setLocaleMessages(
                'tr',
                TrMessages(),
              );
              final lastUpdatedStr = timeago.format(
                lastUpdated,
                locale: 'tr',
              );

              return SafeArea(
                child: SizedBox(
                  height: screen.size.height,
                  width: screen.size.width,
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: GoogleMap(
                              initialCameraPosition:
                                  pageState.defaultCamerapPosition,
                              markers: {
                                Marker(
                                  markerId: MarkerId(
                                    [
                                      latlng.latitude,
                                      latlng.longitude,
                                    ].join(","),
                                  ),
                                  position: LatLng(
                                    latlng.latitude,
                                    latlng.longitude,
                                  ),
                                )
                              },
                              onMapCreated: pageNotifier.onMapCreated,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Builder(
                          builder: (context) {
                            final user = ref.watch(authProvider).appUser!;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              child: SizedBox(
                                height: 190,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: user.profilePicUrl != null
                                                  ? Image.network(
                                                      user.profilePicUrl!,
                                                      fit: BoxFit.contain,
                                                    )
                                                  :
                                                  // empty box
                                                  Container(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user.fullName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder(
                                                      future: pageState
                                                          .address(data.loc),
                                                      builder: (context, snp) {
                                                        if (snp.hasData) {
                                                          return Text(snp.data
                                                              .toString());
                                                        }
                                                        return const SizedBox();
                                                      },
                                                    ),
                                                    Text(
                                                      'Son güncelleme: $lastUpdatedStr',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    TextBtn(
                                                      eventName: '',
                                                      text: 'Haritada aç',
                                                      onPressed: () {
                                                        pageNotifier
                                                            .openInMapApp(
                                                                data.loc);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ].joinWidgetList(
                                          (index) => const SizedBox(
                                            width: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
