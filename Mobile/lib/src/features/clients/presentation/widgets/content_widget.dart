import 'package:city_clean/generated/l10n.dart';
import 'package:city_clean/src/features/clients/presentation/bloc/client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import 'completados_widget.dart';
import 'pendientes_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ClientBloc>(context)
        .add(ClientEvent.getAllGarbageRequest(id: '641f7db8450bea919af27e6f'));
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: ThemeWidget.colorPrimary,
              indicatorColor: ThemeWidget.colorPrimary,
              tabs: [
                Tab(
                  text: S.of(context).tPendientes,
                ),
                Tab(
                  text: S.of(context).tCompletados,
                )
              ],
            ),
            const Expanded(
                child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [PendientesWidget(), CompletadosWidget()]))
          ],
        ));
  }
}
