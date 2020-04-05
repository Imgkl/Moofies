class SearchModel {
  final String originalTitle, overview, posterPath, releaseDate, overView;
  final int id, runTime;
  final List genre;
  SearchModel( 
      {
      this.genre,
      this.releaseDate,
      this.runTime,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.id,
      this.overView});
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      originalTitle: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ,
      id: json['id'] ,
      releaseDate: json['release_date'],
    
    );
  }
}
