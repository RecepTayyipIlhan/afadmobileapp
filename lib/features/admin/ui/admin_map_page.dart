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
              initialCameraPosition: pageState.defaultCamerapPosition,
              markers: pageState.mapMarkers,
              onMapCreated: pageNotifier.onMapCreated,
            ),
          ),
          PositionedDirectional(
            end: 0,
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
                      //color: Color.fromRGBO(223, 210, 175, 0.8),
                      height: screen.size.width * 0.4,
                      width: screen.size.width * 0.4,
                      child: SingleChildScrollView(
                        child: Builder(
                          builder: (context) {
                            final els = pageState.messages.where(
                              (e) {
                                return pageNotifier.queryUser(ui: e.ui) != null;
                              },
                            ).map(
                              (item) {
                                final user =
                                    pageNotifier.queryUser(ui: item.ui)!;

                                final index = pageState.messages.indexOf(item);

                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        user.fullName,
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        pageNotifier.getMessageFromEnum(
                                          item.mt.index,
                                        ),
                                      ),
                                    ),
                                    //DataCell(Text("deneme")),
                                    DataCell(
                                      Text(
                                        pageNotifier.getCity(user.plakaKodu),
                                      ),
                                    ),

                                    DataCell(
                                      Text(
                                        pageNotifier.getDistrict(
                                          user.ilceKodu,
                                        ),
                                      ),
                                    ),

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
                                );
                              },
                            );
                            return DataTable(
                              sortColumnIndex: pageState.sortColumnIndex,
                              sortAscending: pageState.sortAscending,
                              columns: pageNotifier.dataTableColumns,
                              rows: els.toList(),
                            );
                          },
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
