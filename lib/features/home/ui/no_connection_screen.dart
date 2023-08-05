import 'package:afad_app/features/home/prov/network_detector_prov.dart';
import 'package:afad_app/ui/widgets/btns/primary_btn.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';

import '../../../utils/utils.dart';

class NoConnectionScreen extends ConsumerWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Loading(
      child: Scaffold(
        body: Container(
          padding: defPaddingAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getStr(
                  'no_connection:subtitle',
                ),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).NoConnectionText,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defPaddingSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryBtn(
                    onPressed: () {
                      ref.read(networkAwareProvider.notifier).refresh(context);
                    },
                    text: getStr('no_connection:retry_btn'),
                    eventName: 'no_connection:retry_btn',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
