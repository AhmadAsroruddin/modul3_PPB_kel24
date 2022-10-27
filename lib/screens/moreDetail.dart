import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percobaan/provider.dart';
import 'package:provider/provider.dart';

class MoreDetail extends StatefulWidget {
  MoreDetail({required this.title, required this.id});

  String title;
  dynamic id;
  static const routeName = '/MoreDetail';

  @override
  State<MoreDetail> createState() => _MoreDetailState();
}

class _MoreDetailState extends State<MoreDetail> {
  Widget build(BuildContext context) {
    List<AnimeDetail> animedetail =
        Provider.of<AnimeProvider>(context, listen: false).getDetail();
    Provider.of<AnimeProvider>(context, listen: false).delete();
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    animedetail[0].image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  animedetail[0].title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(animedetail[0].synopsis)
              ],
            ),
          ),
        ));
  }
}
