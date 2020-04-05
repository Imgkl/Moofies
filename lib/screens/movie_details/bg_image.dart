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
    return Hero(
      child: ShimmerImage(
        shaderAvailable: true,
        imageUrl:widget.snapshot.data[widget.id].posterPath!= null ? Api().getPosterImageOriginal(
            "${widget.snapshot.data[widget.id].posterPath}"): "https://kicksdigitalmarketing.com/wp-content/uploads/2019/09/iStock-1142986365.jpg",
        cornerRadius: 0,
        height: screenHeight * 0.85,
        width: screenWidth,
        fit: BoxFit.cover,
      ),
      tag: widget.snapshot.data[widget.id],
    );
  }
}
