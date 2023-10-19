import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/res/components/widgets/verticalSpacing.dart';
import 'package:citta_23/view/profile/widgets/profileCenterBtn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final double tHeight = 300.0;
  final double top = 130.0;
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

        // Stack(
        //   children: [
        //     Column(
        //       children: [
        //         Positioned(
        //           bottom: 200.0,
        //           top: 20.0,
        //           child: Container(
        //             height: 350.0,
        //             width: double.infinity,
        // decoration: const BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(170.0),
        //     bottomRight: Radius.circular(170.0),
        //   ),
        //   color: AppColor.primaryColor,
        // ),
        //             child: Stack(
        //               children: [
        //                 Positioned(
        //                   top: 50.0,
        //                   left: 50.0,
        //                   child: Column(
        //                     children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Stack(
        //       children: [
        //         const CircleAvatar(
        //           radius: 60,
        //           backgroundImage: NetworkImage(
        //             'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        //           ),
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           left: 80,
        //           right: 0,
        //           child: Container(
        //             height: 34.0,
        //             width: 34.0,
        //             decoration: BoxDecoration(
        //               color: AppColor.whiteColor,
        //               borderRadius: BorderRadius.circular(68),
        //             ),
        //             child: const Center(
        //               child: Icon(
        //                 Icons.camera_alt_outlined,
        //                 size: 20,
        //                 color: AppColor.primaryColor,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        // const SizedBox(width: 20.0),
        // Text.rich(
        //   TextSpan(
        //     text: 'Luna Ghothic \n',
        //     style: GoogleFonts.getFont(
        //       "Gothic A1",
        //       textStyle: const TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.w600,
        //         color: AppColor.whiteColor,
        //       ),
        //     ),
        //     children: const <TextSpan>[
        //       TextSpan(
        //         text: 'ID : 934556',
        //         style: TextStyle(
        //           color: AppColor.whiteColor,
        //           fontWeight: FontWeight.w200,
        //           fontSize: 14.0,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Positioned(
        //                   top: 100,
        //                   child:
        // Container(

        //                   height: 130.0,
        //                   width: 200,
        //                   color: Colors.black,
        //                 ))
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        // Stack(
        //   children: [
        //     Positioned(
        //       top: 150.0,
        //       child:
        // SizedBox(
        //         height: 150,
        //         width: MediaQuery.of(context).size.width * 0.7,
        //         child: Container(
        //           height: 100,
        //           width: 200,
        //           color: AppColor.blackColor,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        //   ],
        // ),
        body: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            _buildCoverBar(),
            Positioned(
              top: 50.0,
              left: 0.0,
              child: _buildProfile(),
            ),
            Positioned(
              top: tHeight - top / 2 - 10,
              child: _builProfileContainer(),
            ),
          ],
        ));
  }

  _buildCoverBar() {
    return Container(
      height: tHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100.0),
          bottomRight: Radius.circular(100.0),
        ),
        color: AppColor.primaryColor,
      ),
    );
  }

  _buildProfile() {
    return Row(
      children: [
        const SizedBox(width: 30.0),
        Stack(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
            ),
            Positioned(
              top: 80.0,
              right: 0,
              child: Container(
                height: 34.0,
                width: 34.0,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(68),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 20,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20.0),
        Text.rich(
          TextSpan(
            text: 'Luna Ghothic \n',
            style: GoogleFonts.getFont(
              "Gothic A1",
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'ID : 934556',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _builProfileContainer() {
    return Container(
      height: top,
      width: 350,
      color: AppColor.whiteColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          profileCenterBtns(
            tColor: Color(0xff6AA9FF),
            bColor: Color(0xff005AD5),
            icon: Icons.local_shipping_outlined,
            title: 'My All',
            subtitle: 'Order',
          ),
          profileCenterBtns(
            tColor: Color(0xffFF6A9F),
            bColor: Color(0xffD50059),
            icon: Icons.card_giftcard_outlined,
            title: 'Offer &',
            subtitle: 'Promos',
          ),
          profileCenterBtns(
            tColor: Color(0xff6DF5FC),
            bColor: Color(0xff3CB6BB),
            icon: Icons.home_outlined,
            title: 'Delivery',
            subtitle: 'Address',
          ),
        ],
      ),
    );
  }
}
