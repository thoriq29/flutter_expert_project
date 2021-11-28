import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final testTvModel = TvModel(
    backdropPath: "/backdropPath.jpg", 
    firstAirDate: "firstAirDate", 
    genreIds: [10765, 35,80], 
    id: 1, 
    name: "name", 
    originCountry: ["US"], 
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 99,
    posterPath: "/posterPath.jpg",
    voteAverage:8,
    voteCount: 987
  );

  final tTvResponseModel =
      TvResponse(tvList: <TvModel>[testTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummyData/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
       "results":[
          {
            "backdrop_path":"/backdropPath.jpg",
            "first_air_date":"firstAirDate",
            "genre_ids":[
                10765,
                35,
                80
            ],
            "id": 1,
            "name":"name",
            "origin_country":[
                "US"
            ],
            "original_language":"originalLanguage",
            "original_name":"originalName",
            "overview":"overview",
            "popularity":99,
            "poster_path":"/posterPath.jpg",
            "vote_average":8,
            "vote_count":987
          },
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
