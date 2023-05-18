class Search {
  int? id;
  String? title;
  String? backdropPath;
  String? originalTitle;
  String? posterPath;
  String? releaseDate;

  Search(
      this.backdropPath,
      this.id,
      this.originalTitle,
      this.posterPath,
      this.releaseDate,
      this.title,
      );
      

  Search.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
  }

}