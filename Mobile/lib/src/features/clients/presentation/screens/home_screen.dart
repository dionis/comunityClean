import 'package:city_clean/generated/l10n.dart';
import 'package:city_clean/src/core/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/client_bloc.dart';
import '../widgets/content_widget.dart';
import '../widgets/user_widget.dart';
import 'pedido_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    return BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeWidget.colorPrimary,
          toolbarHeight: 150,
          flexibleSpace: SafeArea(
            child: Column(
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
          backgroundColor: ThemeWidget.colorPrimary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            selectedItemColor: ThemeWidget.colorPrimary,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: S.of(context).tHome),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person_pin),
                  label: S.of(context).tUser)
            ],
            currentIndex: state.index,
            onTap: (index) {
              BlocProvider.of<ClientBloc>(context)
                  .add(ClientEvent.changeIndexEvent(index: index));
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            }),
        // body: state.index == 0 ? const ContentWidget() : const UserWidget(),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: const [ContentWidget(), UserWidget()],
        ),
      );
    });
  }
}
