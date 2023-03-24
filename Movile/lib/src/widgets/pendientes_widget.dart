import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PendientesWidget extends StatelessWidget {
  const PendientesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Presione el botón (+)',
              style: TextStyle(
                color: ColorsConstants.colorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' y pida su primer servicio.',
            ),
          ],
        ),
      ),
    );
  }
}
