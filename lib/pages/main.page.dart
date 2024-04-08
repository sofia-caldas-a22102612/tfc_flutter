import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfc_flutter/pages/login_page.dart';
import 'package:tfc_flutter/pages/pages.dart';

import '../model/session.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final session = context.watch<Session>();

    if (session.user == null) {
      return LoginPage();
    } else {
      return buildBottomBar(session);
    }
  }

  Scaffold buildBottomBar(Session session) {
    return Scaffold(
        appBar: AppBar(title: Text(pages[_selectedIndex].title),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.person),
            itemBuilder: (context) => [PopupMenuItem(value: 0, child: Text('Sair'))],
            onSelected: (index) => session.user = null,
          )
        ],),
        body: pages[_selectedIndex].widget,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: pages.map((page) => NavigationDestination(icon: Icon(page.icon), label: page.title)).toList(),
        )
    );
  }
}