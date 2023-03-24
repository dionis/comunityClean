import 'package:city_clean/src/blocs/app/app_bloc.dart';
import 'package:city_clean/src/screens/pedido_screen.dart';
import 'package:city_clean/src/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/content_widget.dart';
import '../widgets/user_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsConstants.colorPrimary,
          toolbarHeight: 150,
          flexibleSpace: Column(
            children: [
              Image.asset('assets/logo.png', scale: 3),
              Text(
                'City Clean',
                style: GoogleFonts.pacifico(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'locura',
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const PedidoScreen(),
                ));
          },
          backgroundColor: ColorsConstants.colorPrimary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            selectedItemColor: ColorsConstants.colorPrimary,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin), label: 'User')
            ],
            currentIndex: state.index,
            onTap: (index) => BlocProvider.of<AppBloc>(context)
                .add(AppEvent.changeIndexEvent(index: index))),
        body: state.index == 0 ? const ContentWidget() : const UserWidget(),
      );
    });
  }
}
