import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';

import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(state.dotsIndex == 0 ? S.of(context).tDireccion : ''),
                  Text(state.dotsIndex == 1 ? S.of(context).tMetrosBasura : ''),
                  Text(state.dotsIndex == 2 ? S.of(context).tImagen : '')
                ],
              ),
              const SizedBox(height: 10),
              DotStepper(
                dotCount: 3,
                indicatorDecoration:
                    const IndicatorDecoration(color: ThemeWidget.colorPrimary),
                fixedDotDecoration: const FixedDotDecoration(
                  strokeColor: ThemeWidget.colorPrimary,
                ),
                activeStep: state.dotsIndex,
                shape: Shape.circle,
                indicator: Indicator.shift,
                lineConnectorDecoration:
                    const LineConnectorDecoration(linePadding: 10),
                dotRadius: 6,
                tappingEnabled: false,
                spacing: size.width * 0.29,
                lineConnectorsEnabled: true,
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
