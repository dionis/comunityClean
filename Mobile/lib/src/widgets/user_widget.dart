import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                'Bienvenido Wachu985',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            EditWidget(text: 'Nombre de Usuario: ', subtitle: 'Wachu985'),
            Divider(),
            EditWidget(text: 'Email: ', subtitle: 'pedrobonilla985@gmail.com'),
            Divider(),
            EditWidget(text: 'Contraseña: ', subtitle: '********'),
            Divider(),
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
