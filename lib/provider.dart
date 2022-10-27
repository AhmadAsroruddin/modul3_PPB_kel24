import 'package:flutter/widgets.dart';
import 'package:percobaan/screens/home.dart';

class AnimeDetail with ChangeNotifier {
  String title;
  String score;
  String broadcast;
  String synopsis;
  String image;

  AnimeDetail(
      {required this.title,
      required this.score,
      required this.broadcast,
      required this.synopsis,
      required this.image});
}

class AnimeProvider with ChangeNotifier {
  List<AnimeDetail> _items = [];

  List<AnimeDetail> getDetail() {
    return _items;
  }

  void addAnime(String title, String score, String broadcast, String synopsis,
      String image) {
    final _new = AnimeDetail(
        title: title,
        score: score,
        broadcast: broadcast,
        synopsis: synopsis,
        image: image);

    _items.add(_new);
    notifyListeners();
  }

  void delete() {
    _items = [];
    notifyListeners();
  }
}

class Profile with ChangeNotifier {
  Profile({required this.nama, required this.nim, required this.funFact});

  String nama;
  String funFact;
  String nim;
}

class ProfileProvider with ChangeNotifier {
  final List<Profile> _items = [
    Profile(
        nama: 'Ahmad Asroruddin',
        nim: '21120120140132',
        funFact: "Hari-hari dihabiskan hanya di dalam kamar"),
    Profile(
        nama: 'Faqih Al Mubarrok',
        nim: '21120120130042',
        funFact: "Programmer Game"),
    Profile(
        nama: 'Khasandra Nur ', nim: '21120120140089', funFact: "Tidak tahu"),
    Profile(
        nama: 'Refanda Putra',
        nim: '21120120120022',
        funFact: "Kalo di kelas duduk di depan terus")
  ];

  List<Profile> getProfile() {
    return _items;
  }
}
