import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ViewModels/provider/providers.dart';

class CustomAutoCompleteTextField extends ConsumerWidget {
  const CustomAutoCompleteTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = ref.watch(dataProvider);
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey,
                size: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text) {
                    if (text.isEmpty) {
                      ref.read(filterProvider.notifier).state = '';
                    } else {
                      ref.read(filterProvider.notifier).state = text;
                    }
                  },
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.subtitle1,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Find Stocks and bonds',
                    counterText: '',
                    hintStyle: GoogleFonts.nunito().copyWith(
                      color: Colors.grey,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
