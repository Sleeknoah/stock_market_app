import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_market_app/ViewModels/provider/providers.dart';
import 'package:stock_market_app/model/responses/eod/eod.dart';
import 'package:stock_market_app/utils/random_companies.dart';
import 'package:stock_market_app/utils/size_constants.dart';
import 'package:stock_market_app/view/custom/custom_autoComplete.dart';
import 'package:stock_market_app/view/custom/list_item_custom.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.

    ///Retrieve data on start up
    ref.read(eodDataProvider.notifier).retrieveStatus(
          ref,
          RandomSymbols.getRandomArray(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = ref.watch(loadingProvider);
    final data = ref.watch(dataProvider);
    ref.listen<Eod?>(eodDataProvider, (previous, next) {
      ///if there is data set loading to false state
      if (next != null) {
        ref.watch(loadingProvider.notifier).state = false;
      }
    });

    Dimensions.init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            Text(
              'Watchlist',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                textStyle: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0.0,
              ),
              child: CustomAutoCompleteTextField(),
            ),

            ///Circular Progress bar to show loading state
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Visibility(
                  visible: loadingState,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: !loadingState,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(data[index].symbol);
                          },
                          child: CustomListItem(
                            open: data![index].open!,
                            close: data[index].close!,
                            symbol: data[index].symbol!,
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
