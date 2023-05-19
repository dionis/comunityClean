import 'package:city_clean/generated/l10n.dart';
import 'package:city_clean/src/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client_bloc.dart';
import '../widgets/dots_widget.dart';
import '../widgets/page_widget.dart';

class PedidoScreen extends StatelessWidget {
  const PedidoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<ClientBloc>(context)
                  .add(ClientEvent.changeDotsEvent(dots: 0));

              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(S.of(context).tServicio),
        backgroundColor: ThemeWidget.colorPrimary,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const DotsWidget(),
              PageWidget()
            ],
          ),
        ],
      ),
    );
  }
}
