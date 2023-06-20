import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/theme/theme.dart';

class IsEmptyWidget extends StatelessWidget {
  const IsEmptyWidget({
    super.key,
  });

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
                color: ThemeWidget.colorPrimary,
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
