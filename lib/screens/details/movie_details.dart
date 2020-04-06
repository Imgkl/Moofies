import 'package:flutter/material.dart';
import 'package:moofies/screens/details/custom_sheet.dart';
import 'package:moofies/services/api.dart';
import 'bg_image.dart';

class MovieDetails extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final id;
  final type;

  const MovieDetails({Key key, this.snapshot, this.id, this.type})
      : super(key: key);
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Future movieDetails;

  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    movieDetails =
        _api.getMovieInfo(widget.snapshot.data[widget.id].id, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.85,
            child: BgImage(
              snapshot: widget.snapshot,
              id: widget.id,
            ),
          ),
          FractionallySizedBox(
            // alignment: Alignment.bottomCenter,
            // heightFactor: 0.45,
            // child: Material(
            //   color: Colors.transparent,
            //   elevation: 3,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(40),
            //           topRight: Radius.circular(40)),
            //       color: Colors.white,
            //     ),
            //  child: FutureBuilder(
            //    future: movieDetails,
            //    builder: (context, snapshot) {
            //      if (!snapshot.hasData) {
            //        return CircularProgressIndicator();
            //      }
            //      if (snapshot.hasData) {
            //        return Column(
            //          children: <Widget>[
            //            GenreTagLine(snapshot: snapshot),4
            //            Rating(snapshot: snapshot),
            //            ReleaseInfo(snapshot: snapshot),
            //            About(snapshot: snapshot),
            //          ],
            //        );
            //      }
            //      if (snapshot.hasError) {
            //        return CircularProgressIndicator(
            //          strokeWidth: 1,
            //        );
            //      }
            //      return CircularProgressIndicator(
            //        strokeWidth: 1,
            //      );
            //    }),
            child: CustomBottomSheet(
              type: widget.type,
              moviedetail: movieDetails,
            ),
            // ),
            // ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FabButton(),
      // bottomNavigationBar: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     notchMargin: 5.0,
      //     child: BottomBar())
    );
  }
}
