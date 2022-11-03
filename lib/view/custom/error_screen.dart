import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(
            'assets/png/error.png',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            error,
            style: GoogleFonts.nunito(
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              textStyle: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ],
    );
  }
}
