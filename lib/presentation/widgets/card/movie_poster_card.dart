import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviePosterCard extends StatelessWidget {
  final String imagePath;
  final Function() onTap;
  final bool? showRank;
  final int index;
  MoviePosterCard({required this.imagePath, required this.onTap, this.showRank, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            showRank != null ?
            Positioned(
              bottom: -25,
              child: Text((index + 1).toString(), 
                style: TextStyle(
                  fontSize: 70 ,
                  color: Colors.black,
                  shadows: [
                    Shadow( // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.white
                    ),
                    Shadow( // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.white
                    ),
                    Shadow( // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.white
                    ),
                    Shadow( // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: Colors.white
                    ),
                  ]
                ),
              )
            ) : Container()
          ]
        ),
      ),
    );
  }
}