import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:afad_app/features/admin/prov/admin_map_prov.dart';

class MessagesList extends ConsumerStatefulWidget {
  final AppUser user_d;
  const MessagesList({super.key, required this.user_d});

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    final firestore = ref.watch(fbDbProv);

    final userid = widget.user_d.id;

    //final pageState = ref.watch(adminMapStateProvider);
    final pageNotifier = ref.watch(adminMapStateProvider.notifier);

    return StreamBuilder<List<HelpMessage>>(
      stream: firestore.getMsgsOfUser(userid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: messages.map(
                (msg) {
                  return Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        pageNotifier.getMessageFromEnum(msg.mt.index),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // subtitle: Text(
                      //   pageNotifier.getMessageDescFromEnum(msg.mt.index),
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
