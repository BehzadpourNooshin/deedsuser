import 'package:deedsuser/theme/themes.dart';
import 'package:deedsuser/views/widgets/header.dart';
import 'package:flutter/material.dart';

class PortalMasterLayout extends StatelessWidget {
  final Widget body;
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final void Function(bool isOpened)? onDrawerChanged;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;

  const PortalMasterLayout({
    super.key,
    required this.body,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    this.onDrawerChanged,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kScreenBackgroundColor,
        appBar: const Header(),
        body: body);
  }
}
