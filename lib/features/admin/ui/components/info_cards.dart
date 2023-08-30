import 'package:afad_app/features/admin/ui/detailed_person_page.dart';
import 'package:afad_app/features/app_init/app_init_prov.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'info_card.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/admin/prov/admin_map_prov.dart';

class InfoCards extends ConsumerWidget {
  final AppUser user_d;
  final SelectedScreen selectedScreen;
  const InfoCards(
      {Key? key, required this.user_d, required this.selectedScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var screen = MediaQuery.of(context).size;

    final adminProvNot = ref.watch(adminMapStateProvider.notifier);
    String? il, ilce;
    try {
      il = adminProvNot.getCity(user_d.plakaKodu);
      ilce = adminProvNot.getDistrict(
        user_d.ilceKodu,
      );
    } catch (e) {
      print(e);
    }

    String valueOrBilgiYok(dynamic value) {
      if (value == null) {
        return "Bilgi Yok";
      } else {
        return value.toString();
      }
    }

    return SizedBox(
      width: screen.width * 0.70,
      height: screen.height * 0.70,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard(
                  text: "İsim :",
                  value: valueOrBilgiYok(user_d.fullName),
                ),
                const SizedBox(
                  width: 25,
                ),
                InfoCard(
                  text: "Tc :",
                  value: valueOrBilgiYok(user_d.idNumber),
                ),
              ],
            ),
            SizedBox(height: screen.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard(
                  text: "Kan Grubu :",
                  value: valueOrBilgiYok(getStr(user_d.bloodGroup.toString())),
                ),
                const SizedBox(
                  width: 25,
                ),
                InfoCard(
                  text: "Aynı evdeki kişiler :",
                  value: valueOrBilgiYok(user_d.peopleAtSameAddress),
                ),
              ],
            ),
            SizedBox(height: screen.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard(
                  text: "İl",
                  value: valueOrBilgiYok(il),
                ),
                InfoCard(
                  text: "İlçe",
                  value: valueOrBilgiYok(ilce),
                ),
              ].joinWidgetList(
                (index) => const SizedBox(
                  width: 25,
                ),
              ),
            ),
            SizedBox(height: screen.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (user_d.buildingAge != null)
                  InfoCard(
                    text: "Bina yaşı :",
                    value: valueOrBilgiYok(user_d.buildingAge),
                  ),
                if (user_d.buildingDurability != null)
                  InfoCard(
                    text: "Bina dayanıklılığı :",
                    value: valueOrBilgiYok(user_d.buildingDurability),
                  ),
              ].joinWidgetList(
                (index) => const SizedBox(
                  width: 25,
                ),
              ),
            ),
            SizedBox(height: screen.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard(
                  text: "Kullanılan İlaçlar :",
                  value: valueOrBilgiYok(user_d.medicines),
                ),
                const SizedBox(
                  width: 25,
                ),
                InfoCard(
                  text: "Telefon Numarası :",
                  value: valueOrBilgiYok(user_d.phone),
                ),
              ],
            ),
            SizedBox(height: screen.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InfoCard(
                  text: "Adres",
                  value: valueOrBilgiYok(user_d.address),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
