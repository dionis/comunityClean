import 'package:city_clean/src/features/clients/data/models/garbage_model.dart';
import 'package:city_clean/src/features/clients/presentation/bloc/client_bloc.dart';
import 'package:city_clean/src/features/clients/presentation/screens/pedido_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../../generated/l10n.dart';
import '../../domain/entitie/garbage.dart';

class GarbageWidget extends StatelessWidget {
  const GarbageWidget({
    super.key,
    required this.pendiente,
  });

  final Garbage pendiente;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool isDelete = false;
        if (direction == DismissDirection.endToStart) {
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  title: Text(S.of(context).tConfirmacion),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).tPregunta,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          isDelete = false;
                          Navigator.of(context).pop();
                        },
                        child: Text(S.of(context).tCancelar,
                            style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        isDelete = true;
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).tAceptar,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                );
              });
        }
        return isDelete;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          BlocProvider.of<ClientBloc>(context)
              .add(ClientEvent.deleteGarbageRequest(id: pendiente.id ?? ''));
        }
      },
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete_sweep_rounded,
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<ClientBloc>(context).add(
                  ClientEvent.updateGarbage(
                      newGarbage: GarbageModel(
                          amountGarbage: pendiente.amountGarbage ?? 0,
                          id: pendiente.id ?? '',
                          imageUrl: pendiente.imageUrl ?? '',
                          locations: pendiente.locations ?? '',
                          stat: pendiente.stat ?? false,
                          user: pendiente.user ?? '')));
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const PedidoScreen(),
                  ));
            },
            onLongPress: () => showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      content: Hero(
                        tag: pendiente.id!,
                        child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/no-image.png'),
                            image: NetworkImage(pendiente.imageUrl!)),
                      ),
                    )),
            child: FadeInLeft(
              child: ListTile(
                leading: Hero(
                  tag: pendiente.id!,
                  child: Image.network(
                    pendiente.imageUrl!,
                    width: 50,
                    height: 70,
                  ),
                ),
                title: Text(pendiente.locations ?? ''),
                subtitle: Text(
                    '${S.of(context).tCantBasura}: ${pendiente.amountGarbage} m³'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
