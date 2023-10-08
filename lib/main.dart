import 'package:flutter/material.dart';
import 'package:messanger_app/responsive/desktop_view.dart';
import 'package:messanger_app/responsive/mobile_view.dart';
import 'package:messanger_app/responsive/responsive_layout.dart';
import 'package:messanger_app/responsive/tablet_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger app',
      home: ResponsiveLayout(
        mobileScaffold: MobileView(),
        tabletScaffold: TabletView(),
        desktopScaffold: DesktopView(),
      ),
    );
  }
}
