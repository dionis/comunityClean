import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app/app_bloc.dart';
import '../utils/colors.dart';

class FotoWidget extends StatelessWidget {
  const FotoWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                S.of(context).tImagenR,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                    image: AssetImage(
                      'assets/no-image.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  FloatingActionButton(
                    heroTag: 'loco1',
                    onPressed: () {},
                    backgroundColor: ColorsConstants.colorPrimary,
                    child: const Icon(Icons.photo),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    heroTag: 'loco',
                    backgroundColor: ColorsConstants.colorPrimary,
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
                        BlocProvider.of<AppBloc>(context).add(
                            AppEvent.changeDotsEvent(
                                dots: state.dotsIndex - 1));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: ColorsConstants.colorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 50)),
                      child: Text(
                        S.of(context).tAtras,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AppBloc>(context)
                            .add(AppEvent.changeDotsEvent(dots: 0));
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: ColorsConstants.colorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 50)),
                      child: Text(
                        S.of(context).tFinalizar,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
