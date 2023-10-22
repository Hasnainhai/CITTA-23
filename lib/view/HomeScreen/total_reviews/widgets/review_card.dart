import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/colors.dart';
import '../../../../res/components/widgets/verticalSpacing.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ronti Jordan",
                          style: GoogleFonts.getFont(
                            "Gothic A1",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.fontColor,
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "12 Days ago",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(8),
            Text(
              "Aliqua officia duis occaecat consectetur fugiat nostrud anim dolor commodo officia proident. Voluptate nisi reprehenderit.",
              textAlign: TextAlign.start,
              style: GoogleFonts.getFont(
                "Gothic A1",
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grayColor,
                ),
              ),
            ),
            const VerticalSpeacing(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: AppColor.primaryColor,
                ),
                Text(
                  "24 Like",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.reply_outlined,
                  color: AppColor.grayColor,
                ),
                Text(
                  "Reply",
                  style: GoogleFonts.getFont(
                    "Gothic A1",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
