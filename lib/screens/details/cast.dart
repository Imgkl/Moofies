import 'package:flutter/material.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/widgets/shimmer_effect.dart';

class CastDetails extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final type;

  const CastDetails({Key key, this.snapshot, this.type}) : super(key: key);
  @override
  _CastDetailsState createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  Api _api;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _api = Api();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Cast",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: screenWidth * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 1,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: screenHeight * 0.27,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.snapshot.data.castList.length == 0
                      ? 0
                      : widget.snapshot.data.castList.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        height: screenHeight * 0.21,
                        width: screenWidth * 0.31,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ShimmerImage(
                                  imageUrl: widget.snapshot.data.castList[i]
                                              ['profile_path'] !=
                                          null
                                      ? Api().getPosterImage(
                                          "${widget.snapshot.data.castList[i]['profile_path']}")
                                      : "https://firebasestorage.googleapis.com/v0/b/moofies.appspot.com/o/139-1396482_person-icons-gray.png?alt=media&token=eee892c2-45a2-4dd2-89fc-a3956acf3ce7",
                                  height: screenHeight * 0.2,
                                  width: screenWidth * 0.3,
                                  cornerRadius: 25,
                                  fit: widget.snapshot.data.castList[i]
                                              ['profile_path'] !=
                                          null
                                      ? BoxFit.cover
                                      : BoxFit.contain,
                                  elevation: widget.snapshot.data.castList[i]
                                              ['profile_path'] !=
                                          null
                                      ? 3
                                      : 0,
                                  enabled: widget.snapshot.data.castList[i]
                                              ['profile_path'] !=
                                          null
                                      ? true
                                      : false,
                                  shaderAvailable: false,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "${widget.snapshot.data.castList[i]['name']}",
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(child: Text("as")),
                                Expanded(
                                    child: Text(
                                  "${widget.snapshot.data.castList[i]['character']}",
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: RichText(
          //     text: TextSpan(
          //       children: List.generate(
          //         widget.snapshot.data.genre.length,
          //         (i) {
          //           return TextSpan(
          //               text: " | ${widget.snapshot.data.castList[i]['name']} | ",
          //               style: TextStyle(color: Colors.black, fontSize: 14));
          //         },
          //       ),
          //       style: Theme.of(context).textTheme.caption,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ],
      ),
    );
  }
}
