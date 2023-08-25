import 'dart:io';

import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/ui/widgets/primary_dropdown.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/loading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../ui/widgets/btns/auth_icon_btn.dart';
import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

import '../../../ui/widgets/primary_image_picker.dart';
import '../prov/signup_prov.dart';

class QrCodeScreen extends ConsumerWidget {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signupStateProvider);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Loading(
        child: Scaffold(
          appBar: AppBar(
            // we do not want to show the back button when we are on the info step
            automaticallyImplyLeading: formState.isEmailStep,
            title: const Text('Cihaz tanıtma'),
          ),
          body: SafeArea(
            child: Form(
              key: formState.formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // the height of the screen - safearea - keyboard
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical,
                ),
                child: Builder(builder: (context) {
                  // this is a disgusting thing. flutter is breaking
                  // when giving a maxwidth of 500 to screens that
                  // are smaller than 500. so we have to do this
                  // disgusting thing.
                  final w = MediaQuery.of(context).size.width;
                  if (w < 500) {
                    return const _Bod();
                  }

                  return Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 500,
                        ),
                        child: const _Bod(),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bod extends StatelessWidget {
  const _Bod();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: defPaddingAll,
      child: Column(
        children: [
          const _Fields(),
        ].joinWidgetList(
          (index) => const SizedBox(
            height: defPaddingSize * 2,
          ),
        ),
      ),
    );
  }
}

class _Fields extends ConsumerStatefulWidget {
  const _Fields();

  @override
  ConsumerState<_Fields> createState() => _FieldsState();
}

class _FieldsState extends ConsumerState<_Fields> {
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        GoRouter.of(context).pushNamed(RouteTable.rSignupScreen);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final formState = ref.watch(signupStateProvider);
    final notifier = ref.watch(signupStateProvider.notifier);

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: (result != null)
                ? Text(
                    'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                : Text('Scan a code'),
          ),
        )
      ].joinWidgetList(
        (index) => const SizedBox(
          height: defPaddingSize,
        ),
      ),
    );
  }
}
