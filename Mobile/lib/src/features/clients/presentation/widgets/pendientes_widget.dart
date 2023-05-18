import 'package:city_clean/src/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client_bloc.dart';
import 'garbage_widget.dart';
import 'is_empty_widget.dart';

class PendientesWidget extends StatelessWidget {
  const PendientesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        if (state.garbageStatus == GarbageStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: ThemeWidget.colorPrimary,
            duration: const Duration(seconds: 2),
          ));
        }
      },
      child: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          if (state.garbageStatus == GarbageStatus.success) {
            if (state.listPendientes.isEmpty) {
              return const IsEmptyWidget();
            } else {
              final pendientes = state.listPendientes;
              return ListView.builder(
                  itemCount: pendientes.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GarbageWidget(pendiente: pendientes[index]),
                      ],
                    );
                  });
            }
          } else if (state.garbageStatus == GarbageStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const IsEmptyWidget();
        },
      ),
    );
  }
}
