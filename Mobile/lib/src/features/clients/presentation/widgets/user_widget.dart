import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                S.of(context).tWelcome('Wachu985'),
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EditWidget(text: S.of(context).tNombre, subtitle: 'Wachu985'),
            const Divider(),
            EditWidget(
                text: S.of(context).tEmail,
                subtitle: 'pedrobonilla985@gmail.com'),
            const Divider(),
            EditWidget(text: S.of(context).tContra, subtitle: '********'),
            const Divider(),
          ],
        ),
      ],
    );
  }
}

class EditWidget extends StatelessWidget {
  const EditWidget({Key? key, required this.text, required this.subtitle})
      : super(key: key);
  final String text;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(fontSize: 19, color: Colors.black),
                  children: [
                TextSpan(
                    text: text,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: subtitle,
                )
              ])),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }
}
