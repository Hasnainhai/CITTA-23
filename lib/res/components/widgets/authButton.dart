// ignore_for_file: file_names, use_build_context_synchronously, unnecessary_null_comparison
import 'package:citta_23/res/components/colors.dart';
import 'package:citta_23/utils/utils.dart';
import 'package:citta_23/view/HomeScreen/DashBoard/tapBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
  });
  final String buttonText;
  @override
  State<AuthButton> createState() => _AuthButtonState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _authInstance = FirebaseAuth.instance;
Future<void> signUp(BuildContext context) async {
  try {
    _googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
          await _authInstance.signInWithCredential(authCredential);

      if (result.user != null) {
        await _setupUserData(result.user!);
        // Show success message and navigate to the dashboard
        _showSuccessMessage(context);
        _navigateToDashboard(context);
      }
    }
  } on FirebaseAuthException catch (e) {
    _handleFirebaseAuthException(e, context);
  } catch (e) {
    _handleGenericError(e, context);
  }
}

Future<void> _setupUserData(User user) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'createdAt': FieldValue.serverTimestamp(),
    'email': user.email,
    'id': user.uid,
    'name': user.displayName,
    'profilePic': user.photoURL,
  });
}

void _showSuccessMessage(BuildContext context) {
  Utils.flushBarErrorMessage('SuccessFully SignIn', context);
}

void _navigateToDashboard(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const DashBoardScreen()),
  );
}

void _handleFirebaseAuthException(
    FirebaseAuthException e, BuildContext context) {
  // Handle FirebaseAuthException,
  _showErrorMessage('${e.message}', context);
}

void _handleGenericError(dynamic e, BuildContext context) {
  // Handle generic errors,
  _showErrorMessage(e.toString(), context);
}

void _showErrorMessage(String message, BuildContext context) {
  Utils.flushBarErrorMessage(message, context);
}

class _AuthButtonState extends State<AuthButton> {
  // Future<void> signup(BuildContext context) async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //   if (googleSignInAccount != null) {
  //     try {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(
  //           idToken: googleSignInAuthentication.idToken,
  //           accessToken: googleSignInAuthentication.accessToken);

  //       // Getting users credential
  //       UserCredential result =
  //           await authInstance.signInWithCredential(authCredential);

  //       if (result != null) {
  //         // setup google credentials in firebase Firestore
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(result.user!.uid)
  //             .set({
  //           'createdAt': Timestamp.now(),
  //           'email': result.user!.email,
  //           'id': result.user!.uid,
  //           'name': result.user!.displayName,
  //           'profilePic': result.user!.photoURL,
  //         });
  //         Utils.toastMessage('Successfully SignIn');
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) => const DashBoardScreen()));
  //       }
  //     } on FirebaseException catch (e) {
  //       Utils.flushBarErrorMessage('${e.message}', context);
  //     } catch (e) {
  //       Utils.flushBarErrorMessage(e.toString(), context);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signUp(context);
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
            Text(
              widget.buttonText,
              style: const TextStyle(
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
