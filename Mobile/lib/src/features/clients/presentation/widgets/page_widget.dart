import 'package:city_clean/src/features/clients/data/models/garbage_model.dart';
import 'package:city_clean/src/features/clients/domain/entitie/garbage.dart';
import 'package:flutter/material.dart';

import 'direccion_widget.dart';
import 'foto_widget.dart';
import 'metros_widget.dart';

class PageWidget extends StatelessWidget {
  PageWidget({
    Key? key,
  }) : super(key: key);
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        DireccionWidget(
          controller: controller,
        ),
        MetrosWidget(controller: controller),
        FotoWidget(
          controller: controller,
        ),
      ],
    ));
  }
}
