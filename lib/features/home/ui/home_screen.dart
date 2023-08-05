import 'package:afad_app/services/analytics_service.dart';
import 'package:afad_app/ui/widgets/btns/tertiary_btn.dart';
import 'package:afad_app/ui/widgets/error_widget.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:afad_app/utils/prov/auth_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/utils.dart';

part 'already_entered_quiz_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: defPaddingAll,
      child: Column(
        children: [].joinWidgetList(
          (_) => const SizedBox(
            height: defPaddingSize * 2,
          ),
        ),
      ),
    );
  }
}
