import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';

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
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        metros = state.editGarbage?.amountGarbage.toString();
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  S.of(context).tMetrosBasura,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                          label: Text(S.of(context).tMetrosBasuraC),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<ClientBloc>(context).add(
                              ClientEvent.updateNewGarbage(
                                  key: 'amountGarbage',
                                  value: int.parse(metros!)));
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
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.45, 50)),
                      child: Text(
                        S.of(context).tSiguiente,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
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
      return S.of(context).tValidateV;
    } else if (int.tryParse(value) == null) {
      return S.of(context).tValidateIValid;
    } else if (int.parse(value) < 0) {
      return S.of(context).tValidateIValid;
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
