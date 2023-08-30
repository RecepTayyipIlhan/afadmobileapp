import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EducationVideosScreen extends StatelessWidget {
  const EducationVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VideoPage();
  }
}

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    const title = 'Afet Videoları';
    const url = "https://www.youtube.com/watch?v=ofulChtbdwg";

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                _redirect(url);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Derprem sonrası ilk 6 saat eğitimi",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#b464f64901d8cbb2fa44792cf2bf965b");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Afet sırasında tahliye eğitimi",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#2654dc791bbd161a2ee4eef95954cb70");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "İlk Yardım Eğitimi",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#476ec94cc80cfed9c249ec9eef3dd0fc");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Afet kavramları ve çevremizdeki tehlikeler",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#71d052ea8c8aab20f4d01889a457b067");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Afet ve Acil durum çantası hazırlama eğitimi",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#c1409d1e4adc27690754d01efaeb1b46");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Afit ve Acil durum aile planı hazırlığı",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#813917c3d899fa4fcd65ded86477a9fc");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Afete Dirençli Yapılar",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#759a3bc67bc01cc7366b18950b06932a");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Evinizin içindeki riskleri belirleyin.",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#287c428e1128a450302a22b4b5e61aa5");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Yangın sırasında yapılması gerekenler",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#7083fe4ea801e8295c31522d5c58e8b5");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Sel ve taşkınlara hazırlıklı olun",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#6c6f5e2151189d62f8ba9cda5a9d9347");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Heyelan sırasında yapılması gerekenler",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                _redirect(
                    "https://www.hazirol.gov.tr/tr/video-mtp/#715b5d3ac1d777b52edf32c2d3971182");
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  //border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.video_collection_rounded,
                    color: Color(0xFF003399),
                  ),
                  title: Text(
                    "Çığ sırasında yapılması gerekenler",
                    style: TextStyle(color: Color(0xFF003399)),
                  ),
                  /*subtitle: Text(
            "Şuanki konumunuza gıda yardımı gönderir"),*/
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _redirect(String url) async {
    if (!await launchUrlString(url)) {
      throw 'Could not launch $url';
    }
  }

  /*Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }*/
}

/*Widget VideTile(String title, String url){
  return Column(
    children: [
      MaterialButton(
        onPressed: (){
          print("girdim");
          const url = "https://www.youtube.com";
          launchURL(url);

        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0,
                    3), // changes position of shadow
              ),
            ],
            //border: Border.all(color: Colors.black),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(
              Icons.emergency_rounded,
              color: Color(0xFF003399),
            ),
            title: Text(
                title,
              style: TextStyle(
                  color: Color(0xFF003399)),
            ),
            /*subtitle: Text(
                "Şuanki konumunuza gıda yardımı gönderir"),*/
          ),
        ),
      ),
      SizedBox(height: 15,),
    ],
  );

}*/