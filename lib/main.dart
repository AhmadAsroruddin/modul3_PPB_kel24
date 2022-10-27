import 'package:flutter/material.dart';
import 'package:percobaan/provider.dart';
import 'package:percobaan/screens/tab_screen.dart';
import 'package:provider/provider.dart';

import 'screens/detail.dart';
import 'screens/home.dart';
import 'screens/moreDetail.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AnimeProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider())
      ],
      child: MaterialApp(
        title: 'Anime app',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => TabScreen(),
          '/detail': (context) => const DetailPage(item: 0, title: ''),
          MoreDetail.routeName: ((context) => MoreDetail(title: '', id: 0))
        },
      ),
    );
  }
}
