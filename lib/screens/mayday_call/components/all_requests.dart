import 'package:flutter/material.dart';
import 'request_button.dart';


class AllRequests extends StatelessWidget {
  const AllRequests({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[200],
      width: size.width,
      padding: EdgeInsets.all(25),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yardım Talepleri',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.more_horiz)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          RequestButton(
              title: "Ambulans",
              subtitle: "Şuanki konumunuza ambulans gönderir",
              icon_data: Icons.emergency
          ),RequestButton(
              title: "Gıda Talebi",
              subtitle: "Şuanki konumunuza gıda yardımı gönderir",
              icon_data: Icons.food_bank_rounded
          ),RequestButton(
              title: "İlaç Talebi",
              subtitle: "Şuanki konumunuza ilaç yardımı gönderir",
              icon_data: Icons.local_hospital
          ),RequestButton(
              title: "Barınma Talebi",
              subtitle: "Bu bilgiyi Afad size en uygun barınma yerlerine Yönlendirmek için kullanıcaktır",
              icon_data: Icons.local_hotel_rounded
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'İhbarlar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.more_horiz)
            ],
          ),
          SizedBox(
            height: 20,
          ),

          RequestButton(
            title: "Gaz Kaçağı",
            subtitle:
            "Bu bilgi Afadın gaz kaçaklarını tespit edebilmesi için kullanılıcaktır",
            icon_data: Icons.dangerous_outlined,
          ),
          RequestButton(
              title: "Yangın",
              subtitle: "Konumumun yakınlarında yangın var",
              icon_data: Icons.fireplace_rounded),
          RequestButton(
              title: "Enkaz",
              subtitle:
              "Yakınımda enkaz altında kurtarılmayı bekleyen insanlar var",
              icon_data: Icons.house_siding_rounded),
        ],
      ),

    );
  }
}