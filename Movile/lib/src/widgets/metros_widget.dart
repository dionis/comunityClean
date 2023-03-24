import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app/app_bloc.dart';
import '../utils/colors.dart';

class MetrosWidget extends StatefulWidget {
  const MetrosWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<MetrosWidget> createState() => _MetrosWidgetState();
}

class _MetrosWidgetState extends State<MetrosWidget>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String? metros;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Metros de Basura',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 150, bottom: 200, left: 20, right: 20),
                  child: TextFormField(
                      initialValue: metros,
                      validator: validateValues,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) => metros = newValue,
                      decoration: InputDecoration(
                          label: const Text('Metros Cúbicos de Basura'),
                          prefixIcon: const Icon(Icons.delete),
                          suffix: RichText(
                            text: const TextSpan(
                              text: 'm',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '³',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        widget.controller.animateToPage(state.dotsIndex - 1,
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
                      child: const Text(
                        'Atras',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 50)),
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                  ],
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
    } else if (int.tryParse(value) == null) {
      return 'El Valor debe ser un Numero Valido';
    } else if (int.parse(value) < 0) {
      return 'El Valor debe ser un Numero Valido';
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
