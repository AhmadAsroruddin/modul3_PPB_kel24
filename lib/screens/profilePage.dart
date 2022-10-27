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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: Provider.of<ProfileProvider>(context, listen: false)
          .getProfile()
          .length,
      itemBuilder: (context, index) {
        final data =
            Provider.of<ProfileProvider>(context, listen: false).getProfile();
        return Column(
          children: <Widget>[
            ListTile(
              leading: FlutterLogo(),
              title: Text(data[index].nama),
              subtitle: Text(data[index].funFact),
            ),
          ],
        );
      },
    );
  }
}
