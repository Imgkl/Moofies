import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/models/search_model.dart';
import 'package:moofies/screens/details/movie_details.dart';
import 'package:moofies/services/api.dart';

class Search extends StatefulWidget {
  final type;

  const Search({Key key, this.type}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<SearchModel>> searchMovies;
  TextEditingController controllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
          body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: controllerText,
              onChanged: (text) {
                searchMovies = Api().serach(controllerText.text, widget.type);
              },
              decoration: InputDecoration(
                suffixIcon: controllerText.text.length > 0
                    ? InkWell(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => controllerText.clear());
                          setState(() {
                            searchMovies == null;
                          });
                        },
                        child: Icon(
                          LineIcons.close,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      )
                    : Text(" "),
                hintText: "Search term here",
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          controllerText.text.length == 0
              ? Center(child: Image.asset("assets/search.png"))
              : FutureBuilder<List<SearchModel>>(
                  future: searchMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      // return Center(child: Image.asset("assets/error.png"));
                      return Text(snapshot.error.toString());
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: Image.asset("assets/waiting.png"));
                    } else if (snapshot.connectionState == ConnectionState.none) {
                      return Center(child: Image.asset("assets/search.png"));
                    } else if(snapshot.data.length == 0){
                       return Center(child: Image.asset("assets/error.png"));
                    }
                    else if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      return Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1 / 2,
                                    mainAxisSpacing: 10),
                            itemCount: snapshot.data.length,
                            shrinkWrap: false,
                            itemBuilder: (ctx, pos) {
                              return Card(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetails(
                                            snapshot: snapshot,
                                            type: widget.type,
                                            id: pos,
                                          )));
                                },
                                child: Image.network(
                                  snapshot.data[pos].posterPath != null
                                      ? Api().getPosterImage(
                                          snapshot.data[pos].posterPath)
                                      : "https://kicksdigitalmarketing.com/wp-content/uploads/2019/09/iStock-1142986365.jpg",
                                  fit: BoxFit.fitHeight,
                                ),
                              ));
                            }),
                      );
                    }
                    return Center(child: Image.asset("assets/error.png"));
                  },
                ),
        ],
      ),
    );
  }
}
