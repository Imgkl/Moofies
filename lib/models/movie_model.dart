class MovieModel {
  final String original_title, overview, poster_path, country, releaseDate, tagLine, overView, videos, homePage;
  final int id, runTime;
  final double rating;
  final List genre;
  MovieModel( 
      {this.country,
      this.rating,
      this.genre,
      this.homePage,
      this.releaseDate,
      this.runTime,
      this.original_title,
      this.overview,
      this.poster_path,
      this.id,
      this.tagLine,
      this.overView,
      this.videos});
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      tagLine: json['tagline'],
      original_title: json['title']!=null? json['title']: json['name'],
      overview: json['overview'],
      poster_path: json['poster_path'] ,
      id: json['id'] ,
      releaseDate: json['release_date']!= null ? json['release_date']: json['first_air_date'],
      runTime: json['runtime'],
      genre: json['genres'],
      rating: json['vote_average'],
      videos: json['videos'],
      homePage: json["homepage"],
    );
  }
}
