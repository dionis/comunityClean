import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';

import '../blocs/app/app_bloc.dart';
import '../utils/colors.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AppBloc, AppState>(
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
                indicatorDecoration: const IndicatorDecoration(
                    color: ColorsConstants.colorPrimary),
                fixedDotDecoration: const FixedDotDecoration(
                  strokeColor: ColorsConstants.colorPrimary,
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
