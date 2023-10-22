import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentSearchTile extends StatelessWidget {
  final String searchHistory;
  const RecentSearchTile({super.key, required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                searchHistory,
                style: GoogleFonts.getFont(
                  "Gothic A1",
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grayColor,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_outward,
                color: AppColor.primaryColor,
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}