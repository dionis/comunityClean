import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client_bloc.dart';
import 'garbage_widget.dart';
import 'is_empty_widget.dart';

class CompletadosWidget extends StatelessWidget {
  const CompletadosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state.garbageStatus == GarbageStatus.success) {
          if (state.listCompletos.isEmpty) {
            return const IsEmptyWidget();
          } else {
            final completados = state.listCompletos;
            return ListView.builder(
                itemCount: completados.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GarbageWidget(
                    pendiente: completados[index],
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
    );
  }
}
