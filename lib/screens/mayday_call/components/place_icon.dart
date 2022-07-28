import 'package:flutter/material.dart';

class PlaceIcon extends StatefulWidget {


   String path;
   String title;
   PlaceIcon({@required this.path, @required this.title });

  @override
  State<PlaceIcon> createState() => _PlaceIconState();
}

class _PlaceIconState extends State<PlaceIcon> {
  bool _initialValue =true;
  @override
  Widget build(BuildContext context) {


    return  Column(
      children: [
        GestureDetector(
          onTap: (){
            print("Konumunuz Gönderildi");
            setState(() {
              _initialValue = !_initialValue;
            });
            },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            //color: Colors.amber,
            height: _initialValue ? 50 : 55,
            width: _initialValue ? 50 : 55,

            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(

              color: _initialValue ? Colors.redAccent[200] : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                //color: Color(0xFFE63946).withOpacity(0.5),
                color: _initialValue ? Colors.redAccent[200] : Colors.grey,
                image: DecorationImage(
                  scale: 0.8,
                  alignment: Alignment.topCenter,
                  image: AssetImage(widget.path),
                  // opacity: 0.8,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Text(widget.title,
          style: TextStyle(
            color: Colors.white,
            //color: _initialValue ? Colors.white : Colors.black,
            fontSize:  _initialValue ? 12 : 13,
            fontWeight: _initialValue ? FontWeight.normal : FontWeight.bold,
          ),)
      ],
    );

  }
}

