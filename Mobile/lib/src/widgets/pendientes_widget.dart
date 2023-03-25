import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PendientesWidget extends StatelessWidget {
  const PendientesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: S.of(context).tCompletos1,
              style: const TextStyle(
                color: ColorsConstants.colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: S.of(context).tCompletos2,
            ),
          ],
        ),
      ),
    );
  }
}
