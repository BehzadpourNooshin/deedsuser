import 'package:deedsuser/views/pages/portal.dart';
import 'package:deedsuser/views/widgets/reportmarketplacewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReporMarketPlacePage extends StatelessWidget {
  const ReporMarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: SingleChildScrollView(child: Reportmarketplace()))
          ],
        ),
      ),
    );
  }
}
