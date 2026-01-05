import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/serie.dart';
import 'package:movies/models/credit.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';

/// Service class that handles all API calls to TMDB (The Movie Database)
/// Provides methods to fetch movies, actors, reviews, and related data
class ApiService {
  /// Fetches a list of popular movies from the TMDB API
  /// Returns all available results without any limit
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach((m) => movies.add(Movie.fromMap(m)));
      return movies;
    } catch (e) { return null; }
  }

  /// Fetches movies from a custom TMDB API endpoint
  /// [url] - The specific endpoint path to query
  /// Returns up to 6 movies from the response
  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  /// Searches for movies by title or query string
  /// [query] - The search query string
  /// Returns all matching movies from the search results
  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=YourApiKey&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  /// Fetches user reviews for a specific movie
  /// [movieId] - The TMDB ID of the movie
  /// Returns a list of reviews with author, content, and rating information
  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }
  
  /// Fetches a list of popular actors from TMDB
  /// Returns all available popular actors
  static Future<List<Actor>?> getPopularActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  /// Fetches detailed information for a specific actor including biography
  /// [personId] - The TMDB ID of the actor
  /// Returns detailed actor information from the TMDB API
  static Future<Actor?> getActorDetails(int personId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$personId?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      return Actor.fromMap(res);
    } catch (e) {
      return null;
    }
  }

  /// Fetches movies in which an actor has appeared
  /// [personId] - The TMDB ID of the actor
  /// Returns up to 10 movies where the actor has acted
  static Future<List<Movie>?> getActorMovies(int personId) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$personId/movie_credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['cast'].take(10).forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }
  /// Fetches the cast (actors) for a specific TV series
  /// [seriesId] - The TMDB ID of the TV series
  /// Returns up to 10 actors from the series' cast list  /// Fetches the cast (actors) for a specific movie
  /// [movieId] - The TMDB ID of the movie
  /// Returns up to 10 actors from the movie's cast list
  static Future<List<Actor>?> getMovieCast(int movieId) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['cast'].take(10).forEach((a) => actors.add(Actor.fromMap(a)));
      return actors;
    } catch (e) {
      return null;
    }
  }

  /// Fetches a list of popular TV series from TMDB
  /// Returns all available popular series
  static Future<List<Serie>?> getPopularSeries() async {
    List<Serie> series = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach((s) => series.add(Serie.fromMap(s)));
      return series;
    } catch (e) { return null; }
  }

  static Future<List<Actor>?> getSeriesCast(int seriesId) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$seriesId/credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['cast'].take(10).forEach((a) => actors.add(Actor.fromMap(a)));
      return actors;
    } catch (e) { return null; }
  }

  static Future<List<Credit>?> getActorCombinedCredits(int personId) async {
    List<Credit> credits = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$personId/combined_credits?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      res['cast'].take(15).forEach(
        (c) => credits.add(Credit.fromMap(c)),
      );
      return credits;
    } catch (e) {
      return null;
    }
  }

  /// Fetches complete details for a specific movie including full description
  /// [movieId] - The TMDB ID of the movie
  /// Returns full movie details from TMDB
  static Future<Movie?> getMovieDetails(int movieId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId?api_key=${Api.apiKey}&language=en-US'));
      return Movie.fromMap(jsonDecode(response.body));
    } catch (e) { return null; }
  }

  /// Fetches complete details for a specific TV series including full description
  /// [tvId] - The TMDB ID of the TV series
  /// Returns full series details from TMDB
  static Future<Serie?> getSeriesDetails(int tvId) async {
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}tv/$tvId?api_key=${Api.apiKey}&language=en-US'));
      return Serie.fromMap(jsonDecode(response.body));
    } catch (e) { return null; }
  }
}
