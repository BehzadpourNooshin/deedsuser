import 'package:deedsuser/theme/themes.dart';
import 'package:deedsuser/views/widgets/headerwb.dart';
import 'package:flutter/material.dart';

class PublicMasterLayout extends StatelessWidget {
  final Widget body;

  const PublicMasterLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          null;
        },
        child: SafeArea(
            child: Scaffold(
          backgroundColor: kScreenBackgroundColor,
          appBar: const HeaderWB(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
              SingleChildScrollView(child: body),
            ],
          ),
        )));
  }
}
