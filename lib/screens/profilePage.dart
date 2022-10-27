// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:percobaan/provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Provider.of<ProfileProvider>(context, listen: false)
            .getProfile()
            .length,
        itemBuilder: (context, index) {
          final data =
              Provider.of<ProfileProvider>(context, listen: false).getProfile();
          return Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            data[index].nim == '21120120140089'
                                ? 'assets/avatarCewek.jpg'
                                : 'assets/gambar.jpg'),
                        radius: 50,
                      ),
                      Text(
                        data[index].nama,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(data[index].nim)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
