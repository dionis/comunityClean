import 'package:city_clean/src/widgets/completados_widget.dart';
import 'package:city_clean/src/widgets/pendientes_widget.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(
              labelColor: ColorsConstants.colorPrimary,
              indicatorColor: ColorsConstants.colorPrimary,
              tabs: [
                Tab(
                  text: 'Pendientes',
                ),
                Tab(
                  text: 'Completados',
                )
              ],
            ),
            Expanded(
                child: TabBarView(
                    children: [PendientesWidget(), CompletadosWidget()]))
          ],
        ));
  }
}
