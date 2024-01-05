import 'dart:typed_data';

import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  const PhotoDetail({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Image.memory(
        image,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
