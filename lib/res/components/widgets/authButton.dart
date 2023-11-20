// ignore_for_file: file_names
import 'package:citta_23/res/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../utils/utils.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  Future<void> _googleSignIn(context) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        Utils.toastMessage('Google Account is not null');

        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          try {
            await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken,
              ),
            );
            Utils.toastMessage('Successfully Google Signin');
          } on FirebaseAuthException catch (e) {
            Utils.flushBarErrorMessage('${e.message}', context);
          } catch (e) {
            Utils.flushBarErrorMessage('$e', context);
          }
        } else {
          Utils.flushBarErrorMessage(
            'Google Sign-In failed. Please try again.',
            context,
          );
        }
      } else {
        // User canceled Google Sign-In
        Utils.flushBarErrorMessage('Google Sign-In canceled.', context);
      }
    } catch (error) {
      // Handle other errors if necessary
      Utils.flushBarErrorMessage('$error', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Sucessfully pressed');
        _googleSignIn(context);
      },
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: AppColor.primaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/google.png'),
            ),
            // const SizedBox(width: 20.0),
            const Text(
              'Signup with Google',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
