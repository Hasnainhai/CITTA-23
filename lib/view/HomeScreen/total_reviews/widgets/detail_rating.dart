import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:citta_23/res/components/colors.dart';

class DetailRating extends StatelessWidget {
  final String img;
  final String userName;
  final String rating;
  final String comment;

  const DetailRating({
    super.key,
    required this.img,
    required this.userName,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffECECEC), // You can customize the color
            width: 1, // You can customize the width
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(img)),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.fontColor,
                              ),
                            ),
                            Text(
                              comment,
                              style: const TextStyle(
                                fontFamily: 'CenturyGothic',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: double.parse(rating),
                  minRating: 1,
                  tapOnlyMode: true,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  glowColor: Colors.amber,
                  itemCount: 5,
                  itemSize: 18,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
