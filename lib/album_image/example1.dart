import 'package:album_image/album_image.dart';
import 'package:flutter/material.dart';

class Example1 extends StatefulWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(builder: (context) {
          final thumbnailQuality = MediaQuery
              .of(context)
              .size
              .width ~/ 3;
          return AlbumImagePicker(
            onSelected: (items) {},
            iconSelectionBuilder: (_, selected, index) {
              if (selected) {
                return CircleAvatar(
                  radius: 10,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 10, height: 1.4),
                  ),
                );
              }
              return Container();
            },
            crossAxisCount: 3,
            maxSelection: 4,
            onSelectedMax: () {
              print('Reach max');
            },
            albumBackGroundColor: Colors.white,
            appBarHeight: 45,
            itemBackgroundColor: Colors.grey[100]!,
            appBarColor: Colors.white,
            albumTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
            albumSubTextStyle:
            const TextStyle(color: Colors.grey, fontSize: 10),
            type: AlbumType.image,
            closeWidget: const BackButton(
              color: Colors.black,
            ),
            thumbnailQuality: thumbnailQuality * 3,
          );
        }),
      ),
    );
  }
}
