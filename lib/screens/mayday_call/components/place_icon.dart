import 'package:flutter/material.dart';

class PlaceIcon extends StatefulWidget {
  final String path;
  final String title;
  const PlaceIcon({super.key, required this.path, required this.title});

  @override
  State<PlaceIcon> createState() => _PlaceIconState();
}

class _PlaceIconState extends State<PlaceIcon> {
  bool _initialValue = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print("Konumunuz Gönderildi");
            setState(() {
              _initialValue = !_initialValue;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            //color: Colors.amber,
            height: _initialValue ? 50 : 60,
            width: _initialValue ? 50 : 60,

            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],

              color: Colors.white,
              //color: _initialValue ? Colors.redAccent[200] : Colors.red,

              borderRadius: BorderRadius.circular(8.0),
            ),

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                color: Colors.white,
                //color: _initialValue ? Colors.redAccent[200] : Colors.red,

                image: DecorationImage(
                  scale: 0.2,
                  alignment: Alignment.topCenter,
                  image: AssetImage(widget.path),
                  // opacity: 0.8,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            //color: _initialValue ? Colors.white : Colors.black,
            fontSize: _initialValue ? 12 : 13,
            fontWeight: _initialValue ? FontWeight.normal : FontWeight.bold,
          ),
        )
      ],
    );
  }
}
