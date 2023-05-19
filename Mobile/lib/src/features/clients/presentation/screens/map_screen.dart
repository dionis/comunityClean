import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/theme/theme.dart';
import '../bloc/client_bloc.dart';
import '../widgets/custom_buttom_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<ClientBloc>(context)
                    .add(ClientEvent.changeDotsEvent(dots: 0));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          centerTitle: true,
          title: Text(S.of(context).tServicio),
          backgroundColor: ThemeWidget.colorPrimary,
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(20.02163, -75.82966),
                zoom: 18,
                maxZoom: 18,
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'app.wachu.city_clean',
                ),
                BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, state) {
                    return MarkerLayer(
                      markers: [
                        Marker(
                          point: state.position ?? LatLng(20.02163, -75.82966),
                          width: 30,
                          height: 30,
                          rotate: false,
                          builder: (context) => Draggable(
                            feedback: Icon(Icons.location_on,
                                size: 50.0, color: Colors.red.withOpacity(0.5)),
                            childWhenDragging: Container(),
                            child: const Icon(Icons.location_on,
                                size: 50.0, color: Colors.red),
                            onDragEnd: (details) {
                              final lat = mapController.pointToLatLng(
                                  CustomPoint(
                                      details.offset.dx, details.offset.dy));
                              final position =
                                  lat ?? LatLng(20.02163, -75.82966);
                              BlocProvider.of<ClientBloc>(context).add(
                                  ClientEvent.updatePosition(
                                      newPosition: position));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: CustomButtonWidget(
                  text: S.of(context).tSavePosition,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ));
  }
}
