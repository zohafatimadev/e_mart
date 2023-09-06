import 'package:emart_app/views/splash_screen/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'consts/consts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: const FirebaseOptions(
  //       apiKey: 'your_app_key',
  //       appId: 'emart-89c3f',
  //       messagingSenderId: 'your msg sending id',
  //       projectId: 'projectid'),
  // );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            //to set appBar icons colors
            iconTheme: IconThemeData(
              color: darkFontGrey,
            ),
            //set elevation
            elevation: 0.0,
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
