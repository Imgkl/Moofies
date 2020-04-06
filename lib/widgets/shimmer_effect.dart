import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class ShimmerImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double elevation;
  final double height;
  final BoxFit fit;
  final bool shaderAvailable;
  final double cornerRadius;

  const ShimmerImage(
      {Key key,
      this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.cornerRadius,
      this.shaderAvailable, this.elevation = 0})
      : super(key: key);
  @override
  _ShimmerImageState createState() => _ShimmerImageState();
}

class _ShimmerImageState extends State<ShimmerImage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
      ),
      color: Colors.transparent,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: widget.shaderAvailable
                ? [Colors.black, Colors.transparent]
                : [Colors.black, Colors.black],
          ).createShader(Rect.fromLTRB(0.2, 0, 0.3, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Stack(
          children: <Widget>[
            Shimmer.fromColors(
              direction: ShimmerDirection.ltr,
              baseColor: Colors.transparent,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.cornerRadius),
                  color: Colors.black,
                ),
                width: widget.width,
                height: widget.height,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.imageUrl,
                fit: widget.fit,
                width: widget.width,
                height: widget.height,
              ),
            )
          ],
        ),
      ),
    );
  }
}
