import 'package:flutter/material.dart';
import 'package:messenger_app/responsive/desktop_view.dart';
import 'package:messenger_app/responsive/mobile_view.dart';
import 'package:messenger_app/responsive/tablet_view.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  const ResponsiveLayout(
      {super.key,
      required this.mobileScaffold,
      required this.tabletScaffold,
      required this.desktopScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        if (Constraints.maxWidth <= 600) {
          return const MobileView();
        } else if (Constraints.maxWidth < 1100) {
          return const TabletView();
        } else {
          return const DesktopView();
        }
      },
    );
  }
}
