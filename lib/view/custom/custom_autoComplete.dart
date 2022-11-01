import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_market_app/model/companies.dart';

class CustomAutoCompleteTextField extends ConsumerWidget {
  const CustomAutoCompleteTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: Autocomplete<Companies>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<Companies>.empty();
                  }
                  return companies.where(
                    (Companies company) =>
                        company.name.toLowerCase().startsWith(
                              textEditingValue.text.toLowerCase(),
                            ),
                  );
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onEditingComplete) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
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
                  );
                },
                onSelected: (companies) {
                  print(companies.symbol);
                  FocusManager.instance.primaryFocus?.unfocus();
                },

                ///Build custom list for autocomplete
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<Companies> onSelected,
                    Iterable<Companies> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 5,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Wrap(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              itemCount: options.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final Companies option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(option.name,
                                        style: GoogleFonts.nunito()),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
