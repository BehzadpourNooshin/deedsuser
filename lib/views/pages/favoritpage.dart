import 'package:deedsuser/views/pages/portal.dart';
import 'package:deedsuser/views/widgets/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return PortalMasterLayout(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: SingleChildScrollView(
                    child: PersonalSettingTable(
                  scrollController: scrollController,
                )))
          ],
        ),
      ),
    );
  }
}
