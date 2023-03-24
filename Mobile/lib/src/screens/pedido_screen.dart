import 'package:city_clean/src/blocs/app/app_bloc.dart';
import 'package:city_clean/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              BlocProvider.of<AppBloc>(context)
                  .add(AppEvent.changeDotsEvent(dots: 0));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: const Text('Solicite su Servicio'),
        backgroundColor: ColorsConstants.colorPrimary,
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
