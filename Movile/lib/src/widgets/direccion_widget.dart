import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app/app_bloc.dart';
import '../utils/colors.dart';

class DireccionWidget extends StatefulWidget {
  const DireccionWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<DireccionWidget> createState() => _DireccionWidgetState();
}

class _DireccionWidgetState extends State<DireccionWidget>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String? direccion, provincia, calles, municipio;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Dirección',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      initialValue: direccion,
                      validator: validateValues,
                      onSaved: (newValue) => direccion = newValue,
                      decoration: InputDecoration(
                          label: const Text('Dirección'),
                          prefixIcon: const Icon(Icons.add_location_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      initialValue: calles,
                      validator: validateValues,
                      onSaved: (newValue) => calles = newValue,
                      decoration: InputDecoration(
                          label: const Text('Entre Calles'),
                          prefixIcon: const Icon(Icons.alt_route_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      initialValue: provincia,
                      validator: validateValues,
                      onSaved: (newValue) => provincia = newValue,
                      decoration: InputDecoration(
                          label: const Text('Provincia'),
                          prefixIcon: const Icon(Icons.local_parking_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      initialValue: municipio,
                      validator: validateValues,
                      onSaved: (newValue) => municipio = newValue,
                      decoration: InputDecoration(
                          label: const Text('Municipio'),
                          prefixIcon: const Icon(Icons.location_city),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                const SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        widget.controller.animateToPage(state.dotsIndex + 1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut);
                        BlocProvider.of<AppBloc>(context).add(
                            AppEvent.changeDotsEvent(
                                dots: state.dotsIndex + 1));
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ColorsConstants.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.6, 50)),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? validateValues(String? value) {
    if (value!.isEmpty) {
      return 'El Campo no debe estar Vacio';
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
