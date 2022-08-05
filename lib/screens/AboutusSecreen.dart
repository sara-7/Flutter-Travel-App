import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travel_now_app/screens/HomeSecreen.dart';
import 'package:travel_now_app/widgets/app_bar.dart';

class AboutusSecreen extends StatefulWidget {
  static const id = 'AboutusSecreen';
  const AboutusSecreen({Key? key}) : super(key: key);

  @override
  State<AboutusSecreen> createState() => _AboutusSecreenState();
}

class _AboutusSecreenState extends State<AboutusSecreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
        //Locale('es', ''), // Spanish, no country code
      ],
      color: Colors.grey,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey.shade100,
        appBar: MyAppBar(
          title: 'نبذة عنا',
          backgroundColor: Colors.transparent,
          loading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.brown,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              }),
        ),
        body: ListView(
          padding: EdgeInsets.only(right: 10.0),
          children: <Widget>[
            //1
            Container(
              margin: EdgeInsets.fromLTRB(8.0, 70.0, 0.0, 8.0),
              child: Image.asset("assets/images/tr2.jpeg"),
            ),
            //2

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  'تطبيق للسياحة والسفر',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.brown),
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'يعد تطبيق السياحة والسفر حلقة وصل بينالاماكن السياحية\nو السياح فهو يتيح لهم استكشاف اماكن جديدة\nومعرفة افضل الخيارات من الفنادق من حيث الموقع والسعر.',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.grey,
              height: 5.0,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  'مميزات التطبيق:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.brown),
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.brown,
                ),
                Text(
                  'سهولة إنشاء حساب في التطبيق و تسجيل الدخول.',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.brown,
                ),
                Text(
                  'سهولة الاستخدام و التنقل فى التطبيق.',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.brown,
                ),
                Text(
                  'لتسهيل الوصول للاماكن المرغوب بها بأسرع وقت يمنح \nالعملاء ميزات بحث متقدمة داخله',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: Colors.brown,
                ),
                Text(
                  'وجود التقويم والموقع والسعر لكل فندق.',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Divider(
              color: Colors.grey,
              height: 5.0,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  'الهدف العام:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.brown),
                ),
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              'إنشاء تطبيق الكتروني يتيح للسياح\n اجمل الخيارات لخوض تجارب جديدة\n بالاضافة لاقتراحات لاجمل الفنادق وكل تفاصيلها', // textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  color: Colors.black),
            ),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
