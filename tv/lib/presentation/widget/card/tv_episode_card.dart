import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv/common/config.dart';

class TvEpisodeCard extends StatelessWidget {

  final String? posterPath;
  final String? episodeNumber;
  final String? episodeName;
  final String? overview;

  TvEpisodeCard({this.posterPath, this.episodeName, this.episodeNumber, this.overview});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: [
          Card(
            color: Colors.black,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                left: 22 + 100 + 16,
                bottom: 8,
                right: 8,
                top: 8
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (episodeNumber ?? "") +  ". " +(episodeName ?? '-'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    overview ?? '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL$posterPath',
                width: 120,
                height: overview == "" ? 55 : 76,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  child: Image.asset(
                    "assets/movie-placeholder.png",
                    fit: BoxFit.cover,
                  )
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      )
    ); 
  }

}