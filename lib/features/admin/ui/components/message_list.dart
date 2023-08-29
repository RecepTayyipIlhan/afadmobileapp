import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:flutter/material.dart';
import 'package:afad_app/services/cloud_firestore_service.dart';

class MessagesList extends StatefulWidget {
  final AppUser user_d;
  const MessagesList({super.key, required this.user_d});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  //final CloudFirestoreService cloudFirestoreService = CloudFirestoreService();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Text(
        "deneme"); /*Container(
      child: StreamBuilder<List<HelpMessage?>>(
        stream:
            cloudFirestoreService.getMsgsOfUser(widget.user_d.id.toString()) ,
            
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!;
            return Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
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
                      title:  Text(
                        messages[index]!.mt.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        messages[index]!.mt.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );*/
  }
}
