import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/firebase_options.dart';
import 'package:messenger_app/responsive/desktop_view.dart';
import 'package:messenger_app/responsive/mobile_view.dart';
import 'package:messenger_app/responsive/responsive_layout.dart';
import 'package:messenger_app/responsive/tablet_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'FontMain'),
      title: 'Messenger app',
      home: const ResponsiveLayout(
        mobileScaffold: MobileView(),
        tabletScaffold: TabletView(),
        desktopScaffold: DesktopView(),
      ),
    );
  }
}
