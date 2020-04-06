import 'package:flutter/material.dart';
import 'package:moofies/screens/details/genre_and_tag_line.dart';
import 'package:moofies/screens/details/about.dart';
import 'package:moofies/screens/details/rating_bar.dart';
import 'package:moofies/screens/details/release_info.dart';

class CustomBottomSheet extends StatefulWidget {
  final moviedetail;

  const CustomBottomSheet({Key key, this.moviedetail}) : super(key: key);
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetOpen;
  double sheetClose;
  bool isExpanded = false;
  Animation<double> animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 100)).whenComplete(() {
      setState(() {
        sheetClose = MediaQuery.of(context).size.height * 0.1;
        sheetOpen = MediaQuery.of(context).size.height * 0.8;
      });
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300));
      animation = Tween<double>(begin: sheetOpen, end: sheetClose).animate(
          CurvedAnimation(
              parent: _controller,
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut))
        ..addListener(() {
          setState(() {});
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: animation.value != null? animation.value: 100,
          left: 0,
          child: GestureDetector(
            // onVerticalDragEnd: (DragEndDetails dragEndDetails) {
            //   if (dragEndDetails.primaryVelocity < 0.0) {
            //     _controller.forward();
            //   } else if (dragEndDetails.primaryVelocity > 0.0) {
            //     _controller.reverse();
            //   } else {
            //     return;
            //   }
            // },
            onTap: (){
              if(isExpanded){
                 _controller.forward();
                 setState(() {
                   isExpanded = !isExpanded;
                 });
              }
              else if(!isExpanded){
                _controller.reverse();
                 setState(() {
                   isExpanded = !isExpanded;
                 });
              }
              else{
                return;
              }

            },
            child: SheetContainer(
              movieDetails: widget.moviedetail,
            ),
          ),
        ),
      ],
    );
  }
}

class SheetContainer extends StatefulWidget {
  final movieDetails;

  const SheetContainer({Key key, this.movieDetails}) : super(key: key);

  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        elevation: 3,
        child: Container(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: widget.movieDetails,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                                      child: Column(
                      children: <Widget>[
                        GenreTagLine(snapshot: snapshot),
                        Rating(snapshot: snapshot),
                        ReleaseInfo(snapshot: snapshot),
                        About(snapshot: snapshot)
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return CircularProgressIndicator(
                    strokeWidth: 1,
                  );
                }
                return CircularProgressIndicator(
                  strokeWidth: 1,
                );
              }),
        )));
  }
}
