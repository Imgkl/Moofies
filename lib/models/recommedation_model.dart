class RecommendationModel {
  final String originalTitle, overview, posterPath, country, releaseDate, lang;
  final int id, runTime;
  final double rating;
  final List genre;
  List hits;



  RecommendationModel(
      {this.country,
      this.rating,
      this.genre,
      this.releaseDate,
      this.runTime,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.id, this.lang});




  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      lang: json['original_language'],
      originalTitle: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      id: json['id'],
      // country: json['production_companies'][0]['origin_country'],
      releaseDate: json['release_date'],
      // runTime: json['runtime'],
      // genre: json['genres'],
      rating: json['vote_average']
    );
  }
}