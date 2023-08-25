import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final String value;
  const InfoCard({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: screen.height * 0.15,
        // width: screen.width * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsetsDirectional.only(
                  start: 25, end: 25, top: 25, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Flexible(
                      child: Icon(Icons.person,
                          color: Colors.lightBlueAccent, size: 30)),
                ],
              ),
            ),
            Flexible(
                child: Text(
              value,
              style: TextStyle(
                  fontFamily: "Roboto", fontSize: 20, color: Colors.black45),
            )),
          ],
        ),
      ),
    );
  }
}
