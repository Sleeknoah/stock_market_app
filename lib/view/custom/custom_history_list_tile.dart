import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_list_tile.dart';

class HistoryListTile extends StatelessWidget {
  final String date;
  final String open;
  final String close;
  final String high;
  final String low;

  const HistoryListTile({
    Key? key,
    required this.date,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        24.0,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                date,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  textStyle: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomListTile(
                    alignment: CrossAxisAlignment.start,
                    title: 'Open',
                    value: '\$$open',
                  ),
                  CustomListTile(
                    alignment: CrossAxisAlignment.end,
                    title: 'Close',
                    value: '\$$close',
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 36.0,
                right: 36.0,
                top: 4.0,
                bottom: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomListTile(
                    alignment: CrossAxisAlignment.start,
                    title: 'High',
                    value: '\$$high',
                  ),
                  CustomListTile(
                    alignment: CrossAxisAlignment.end,
                    title: 'Low',
                    value: '\$$low',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
