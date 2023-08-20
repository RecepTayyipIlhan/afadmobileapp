import 'package:afad_app/features/admin/prov/admin_map_prov.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminMapPage extends ConsumerStatefulWidget {
  const AdminMapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminMapPage> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<AdminMapPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        final pageNotifier = ref.watch(adminMapStateProvider.notifier);
        pageNotifier.init(
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    final pageState = ref.watch(adminMapStateProvider);
    final pageNotifier = ref.watch(adminMapStateProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screen.size.height,
            width: screen.size.width,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(41.0122, 28.976),
                zoom: 10.0,
              ),
              markers: pageState.mapMarkers,
              onMapCreated: pageNotifier.onMapCreated,
            ),
          ),
          PositionedDirectional(
            end: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: pageNotifier.toggleShow,
                      child: Text(pageState.show ? 'Gizle' : 'Göster'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Theme.of(context).error),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () => pageNotifier.logout(context),
                      child: const Text('Çıkış Yap'),
                    ),
                  ].joinWidgetList(
                    (index) => const SizedBox(width: 10),
                  ),
                ),
                if (pageState.show) ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      height: screen.size.width * 0.4,
                      width: screen.size.width * 0.4,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: pageState.dataTableColumns,
                          rows: List<DataRow>.generate(
                            pageState.messages.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(
                                    pageState.messages[index].ui.toString())),
                                DataCell(Text(
                                    pageState.messages[index].mt.toString())),
                                DataCell(Text(pageState
                                    .messages[index].loc.latitude
                                    .toString())),
                                /* DataCell(Text("Enkaz Altı")),
                                DataCell(Text(konumDataList[index])), */
                              ],
                              onSelectChanged: (selected) =>
                                  pageNotifier.onSelectChanged(
                                context: context,
                                index: index,
                                selected: selected,
                              ),
                              selected: pageState.isRowSelected(index),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ].joinWidgetList(
                (index) => const SizedBox(
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
