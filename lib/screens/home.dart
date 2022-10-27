import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percobaan/screens/moreDetail.dart';
import 'dart:convert';
import 'package:percobaan/provider.dart';
import 'package:provider/provider.dart';

import 'detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Center(
      child: FutureBuilder(
        future: shows,
        builder: (context, AsyncSnapshot<List<Show>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                const Text(
                  "TOP 10 Anime",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: media.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext ctx, int index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<AnimeProvider>(context, listen: false)
                              .addAnime(
                                  snapshot.data![index].title,
                                  snapshot.data![index].score.toString(),
                                  snapshot.data![index].aired,
                                  snapshot.data![index].synopsis,
                                  snapshot.data![index].images.jpg.image_url);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreDetail(
                                title: snapshot.data![index].title,
                                id: snapshot.data![index].malId,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      snapshot
                                          .data![index].images.jpg.image_url,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '${snapshot.data![index].score}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              constraints: const BoxConstraints(
                                maxWidth: 190,
                                maxHeight: 15,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data![index].title,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: media.height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                snapshot.data![index].images.jpg.image_url),
                          ),
                          title: Text(snapshot.data![index].title),
                          subtitle:
                              Text('Score: ${snapshot.data![index].score}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title),
                              ),
                            );
                            print(snapshot.data![index].synopsis);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class Show {
  final int malId;
  final String title;
  Images images;
  final double score;
  final String synopsis;
  final String aired;

  Show(
      {required this.malId,
      required this.title,
      required this.images,
      required this.score,
      required this.synopsis,
      required this.aired});

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
        malId: json['mal_id'],
        title: json['title'],
        images: Images.fromJson(json['images']),
        score: json['score'],
        synopsis: json['synopsis'],
        aired: json['aired'].toString());
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'title': title,
        'images': images,
        'score': score,
        'synopsis': synopsis,
        'aired': aired,
      };
}

class Images {
  final Jpg jpg;

  Images({required this.jpg});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      jpg: Jpg.fromJson(json['jpg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jpg': jpg.toJson(),
      };
}

class Jpg {
  String image_url;
  String small_image_url;
  String large_image_url;

  Jpg({
    required this.image_url,
    required this.small_image_url,
    required this.large_image_url,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) {
    return Jpg(
      image_url: json['image_url'],
      small_image_url: json['small_image_url'],
      large_image_url: json['large_image_url'],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'image_url': image_url,
        'small_image_url': small_image_url,
        'large_image_url': large_image_url,
      };
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'] as List;
    return jsonResponse.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
