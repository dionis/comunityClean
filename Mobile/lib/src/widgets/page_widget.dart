import 'package:city_clean/src/widgets/direccion_widget.dart';
import 'package:city_clean/src/widgets/foto_widget.dart';
import 'package:city_clean/src/widgets/metros_widget.dart';
import 'package:flutter/material.dart';

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
        DireccionWidget(controller: controller),
        MetrosWidget(controller: controller),
        FotoWidget(
          controller: controller,
        ),
      ],
    ));
  }
}
