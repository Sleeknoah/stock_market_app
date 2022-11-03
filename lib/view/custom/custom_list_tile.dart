import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment alignment;
  const CustomListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            textStyle: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Text(
          value == 'null%' ? '0.0%' : value,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            textStyle: Theme.of(context).textTheme.headline6,
            color: title == 'Low'
                ? Colors.red
                : title == 'High'
                    ? Colors.green
                    : Colors.black,
          ),
        ),
      ],
    );
  }
}
