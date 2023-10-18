import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        title: Text(
          'Profile ',
          style: GoogleFonts.getFont(
            "Gothic A1",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Container(
            height: 350.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120.0),
                bottomRight: Radius.circular(120.0),
              ),
              color: AppColor.primaryColor,
            ),
            child:  Row(
            children: [
              Stack(
                children: [
                  // Circular Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage('https://example.com/profile_image.jpg'),
                  ),

                  // Camera Icon at the Bottom
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 0,
                    child: Icon(
                      Icons.camera_alt,
                      size: 40, // Adjust the size as needed
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ), 
          ),
          const VerticalSpeacing(25.0),
         
        ],
      ),
    );
  }
}
