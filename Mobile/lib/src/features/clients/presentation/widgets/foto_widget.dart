import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';

class FotoWidget extends StatelessWidget {
  const FotoWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return BlocListener<ClientBloc, ClientState>(
          listenWhen: (previous, current) {
            if (previous.garbageSubmit == GarbageSubmit.loading &&
                current.garbageSubmit == GarbageSubmit.success) {
              return true;
            } else if (previous.garbageSubmit == GarbageSubmit.initial &&
                current.garbageSubmit == GarbageSubmit.loading) {
              return true;
            } else if (previous.garbageSubmit == GarbageSubmit.loading &&
                current.garbageSubmit == GarbageSubmit.error) {
              return true;
            }
            if (previous.garbageSubmit == GarbageSubmit.success &&
                current.garbageSubmit == GarbageSubmit.loading) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            dynamic dialog;

            if (state.garbageSubmit == GarbageSubmit.loading) {
              dialog = showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        content: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(S.of(context).tSubiendo),
                            ),
                          ],
                        ));
                  });
            } else if (state.garbageSubmit == GarbageSubmit.success) {
              Navigator.of(context, rootNavigator: true).pop(dialog);
              BlocProvider.of<ClientBloc>(context)
                  .add(ClientEvent.changeDotsEvent(dots: 0));
              BlocProvider.of<ClientBloc>(context).add(
                  ClientEvent.getAllGarbageRequest(
                      id: '641f7db8450bea919af27e6f'));
              Navigator.pop(context);
            } else if (state.garbageSubmit == GarbageSubmit.error) {
              Navigator.of(context, rootNavigator: true).pop(dialog);
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  S.of(context).tImagenR,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: state.editGarbage!.id.isEmpty
                          ? Image.asset(
                              'assets/no-image.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              state.editGarbage!.imageUrl,
                              fit: BoxFit.cover,
                            )),
                ),
                Row(
                  children: [
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: 'hero1',
                      onPressed: () {},
                      backgroundColor: ThemeWidget.colorPrimary,
                      child: const Icon(Icons.photo),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: 'hero',
                      backgroundColor: ThemeWidget.colorPrimary,
                      onPressed: () {},
                      child: const Icon(Icons.camera_alt_rounded),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          controller.animateToPage(state.dotsIndex - 1,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.bounceInOut);
                          BlocProvider.of<ClientBloc>(context).add(
                              ClientEvent.changeDotsEvent(
                                  dots: state.dotsIndex - 1));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: ThemeWidget.colorPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.45, 50)),
                        child: Text(
                          S.of(context).tAtras,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<ClientBloc>(context).add(
                              ClientEvent.updateNewGarbage(
                                  key: 'user',
                                  value: '641f7db8450bea919af27e6f'));
                          BlocProvider.of<ClientBloc>(context).add(
                              ClientEvent.submitNewGarbage(
                                  key: 'image_url',
                                  value:
                                      'https://previews.123rf.com/images/nikitos77/nikitos771705/nikitos77170500028/77491626-cami%C3%B3n-de-basura-descarga-basura-del-contenedor-en-el-vertedero.jpg'));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: ThemeWidget.colorPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.45, 50)),
                        child: Text(
                          S.of(context).tFinalizar,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
