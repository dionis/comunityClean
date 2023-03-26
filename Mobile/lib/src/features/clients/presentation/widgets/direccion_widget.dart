import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';

class DireccionWidget extends StatefulWidget {
  const DireccionWidget({Key? key, required this.controller}) : super(key: key);

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
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  S.of(context).tDireccion,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      initialValue: direccion,
                      validator: validateValues,
                      onSaved: (newValue) => direccion = newValue,
                      decoration: InputDecoration(
                          label: Text(S.of(context).tDireccion),
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
                          label: Text(S.of(context).tEntreCalles),
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
                          label: Text(S.of(context).tProvincia),
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
                          label: Text(S.of(context).tMunicipio),
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
                        final sub = '$direccion $provincia $calles $municipio';
                        BlocProvider.of<ClientBloc>(context).add(
                            ClientEvent.updateNewGarbage(
                                key: 'locations', value: sub));
                        widget.controller.animateToPage(state.dotsIndex + 1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut);
                        BlocProvider.of<ClientBloc>(context).add(
                            ClientEvent.changeDotsEvent(
                                dots: state.dotsIndex + 1));
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ThemeWidget.colorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.6, 50)),
                    child: Text(
                      S.of(context).tSiguiente,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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
      return S.of(context).tValidateV;
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
