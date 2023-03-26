import 'package:city_clean/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';

class PendientesWidget extends StatelessWidget {
  const PendientesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final m = RichText(
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
    );
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state.garbageStatus == GarbageStatus.success) {
          if (state.listPendientes.isEmpty) {
            return Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: S.of(context).tCompletos1,
                      style: const TextStyle(
                        color: ThemeWidget.colorPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).tCompletos2,
                    ),
                  ],
                ),
              ),
            );
          } else {
            final pendientes = state.listPendientes;
            return ListView.builder(
                itemCount: pendientes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            pendientes[index].imageUrl!,
                            width: 50,
                            height: 70,
                          ),
                          title: Text(pendientes[index].locations ?? ''),
                          subtitle: Text(
                              'Cantidad de Basura: ${pendientes[index].amountGarbage} m³'),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                });
          }
        } else if (state.garbageStatus == GarbageStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.garbageStatus == GarbageStatus.error) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
