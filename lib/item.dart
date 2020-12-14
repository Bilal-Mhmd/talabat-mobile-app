import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Item extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final double rating;

  Item({this.title, this.image, this.rating, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Row(children: [
          Image(
            image: NetworkImage('${this.image}'),
            width: 180,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(this.description),
                    SmoothStarRating(
                        allowHalfRating: true,
                        onRated: (v) {},
                        starCount: 5,
                        rating: this.rating != null ? this.rating / 2 : 3,
                        size: 22.0,
                        isReadOnly: true,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        color: Colors.yellowAccent[700],
                        borderColor: Colors.yellowAccent[700],
                        spacing: 0.0),
                  ]),
            ),
          ),
        ]),
      ]),
    );
  }
}
