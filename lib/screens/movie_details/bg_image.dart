import 'package:flutter/material.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/widgets/shimmer_effect.dart';

class BgImage extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int id;

  const BgImage({Key key, this.snapshot, this.id}) : super(key: key);
  @override
  _BgImageState createState() => _BgImageState();
}

class _BgImageState extends State<BgImage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Hero(
          child: ShimmerImage(
            shaderAvailable: true,
            imageUrl: Api().getPosterImage(
                "${widget.snapshot.data[widget.id].posterPath}"),
            cornerRadius: 0,
            height: screenHeight * 0.6,
            width: screenWidth,
            fit: BoxFit.cover,
          ),
          tag: widget.snapshot.data[widget.id],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "${widget.snapshot.data[widget.id].originalTitle}",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }
}
