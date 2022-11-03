import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_market_app/model/responses/eod/data.dart';
import 'package:stock_market_app/utils/size_constants.dart';
import 'package:stock_market_app/view/custom/custom_list_tile.dart';
import 'package:stock_market_app/view/custom/error_screen.dart';

import '../../ViewModels/provider/providers.dart';
import '../../model/companies.dart';
import '../../model/company_logo.dart';
import '../../model/responses/intraday/intraday.dart';
import '../../utils/format_date.dart';
import '../custom/custom_history_list_tile.dart';

class MarketDetails extends ConsumerStatefulWidget {
  final Data dataSet;
  const MarketDetails({
    Key? key,
    required this.dataSet,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MarketDetailsState();
}

class _MarketDetailsState extends ConsumerState<MarketDetails> {
  @override
  void initState() {
    super.initState();
    ref
        .read(intradayDataProvider.notifier)
        .retrieveIntraday(widget.dataSet.symbol!, ref);
  }

  @override
  Widget build(BuildContext context) {
    final intradayData = ref.watch(intradayDataProvider)?.data;

    final startDate = ref.watch(dateTimeStart);
    final endDate = ref.watch(endTimeStart);
    final errorText = ref.watch(errorDetailsProvider);
    final AsyncValue<ConnectivityResult> connection =
        ref.watch(internetProvider);

    final loading = ref.watch(loadingDetailsProvider);
    ref.listen<Intraday?>(intradayDataProvider, (previous, next) {
      ///if there is data set loading to false state
      if (next != null) {
        ref.watch(loadingDetailsProvider.notifier).state = false;
      }
    });

    ref.listen<String>(errorDetailsProvider, (previous, next) {
      ///if there is an error use snackbar here
      if (next.isNotEmpty) {
        ref.watch(loadingDetailsProvider.notifier).state = false;
        final snackBar = SnackBar(
          content: Text(
            next,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              textStyle: Theme.of(context).textTheme.caption,
            ),
          ),
          backgroundColor: (Colors.black),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.amberAccent,
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    Dimensions.init(context: context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            connection.value == ConnectivityResult.none
                ? Container(
                    color: Colors.red,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Please check internet connection',
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            textStyle: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.dataSet.symbol!,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    Companies.search(companies, widget.dataSet.symbol!),
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      textStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight * 0.1,
                  ),
                  Center(
                    child: Hero(
                      tag: widget.dataSet.symbol!,
                      child: SvgPicture.asset(
                        'assets/svg/${CompanyLogo.search(companyLogo, widget.dataSet.symbol!)}-svgrepo-com.svg',
                        height: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.05,
                  ),
                  buildDetailsRow(
                    context,
                    widget.dataSet.open!,
                    widget.dataSet.close!,
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.01,
                  ),

                  ///Price of Stock
                  Center(
                    child: Text(
                      '\$${widget.dataSet.close?.toStringAsFixed(2)}',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        textStyle: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),

                  ///Rows of Market Report
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
                          value: '\$${widget.dataSet.open?.toStringAsFixed(2)}',
                        ),
                        CustomListTile(
                          alignment: CrossAxisAlignment.end,
                          title: 'Close',
                          value:
                              '\$${widget.dataSet.close?.toStringAsFixed(2)}',
                        )
                      ],
                    ),
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
                          title: 'High',
                          value: '\$${widget.dataSet.high?.toStringAsFixed(2)}',
                        ),
                        CustomListTile(
                          alignment: CrossAxisAlignment.end,
                          title: 'Low',
                          value: '\$${widget.dataSet.low?.toStringAsFixed(2)}',
                        )
                      ],
                    ),
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
                          title: 'Split Factor',
                          value:
                              '${widget.dataSet.splitFactor?.toStringAsFixed(1)}%',
                        ),
                        CustomListTile(
                          alignment: CrossAxisAlignment.end,
                          title: 'Vol.',
                          value: '${widget.dataSet.volume?.toStringAsFixed(0)}',
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Historic Market Report',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),

                  ///Date Range filter
                  dateRangeRow(context, startDate, endDate),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Visibility(
                      visible: loading,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///Date range picker
                  intradayData != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          reverse: true,
                          itemCount: intradayData.length,
                          itemBuilder: (context, index) {
                            final data = intradayData[index];
                            return HistoryListTile(
                              open: '${data.open?.toStringAsFixed(2)}',
                              date: '${data.date?.substring(0, 10)}',
                              close: '${data.close?.toStringAsFixed(2)}',
                              high: '${data.high?.toStringAsFixed(2)}',
                              low: '${data.low?.toStringAsFixed(2)}',
                            );
                          },
                        )
                      : ErrorScreen(
                          error: errorText,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row dateRangeRow(
    BuildContext context,
    DateTime startDate,
    DateTime endDate,
  ) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            var result = await showDateRangePicker(
              context: context,
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
              currentDate: DateTime.now(),
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              builder: (context, Widget? child) => Theme(
                data: Theme.of(context).copyWith(
                  appBarTheme: Theme.of(context).appBarTheme.copyWith(
                        backgroundColor: Colors.blue,
                        iconTheme: Theme.of(context)
                            .appBarTheme
                            .iconTheme
                            ?.copyWith(color: Colors.white),
                      ),
                  colorScheme: const ColorScheme.light(
                      onPrimary: Colors.white, primary: Colors.blue),
                ),
                child: child!,
              ),
            );

            ///Save strings and make Call
            performSearch(result?.start, result?.end);
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    DateTimeFormat.format(startDate),
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      textStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.arrowDown,
                    size: 14,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),

        ///Second date display
        Container(
          margin: const EdgeInsets.only(
            left: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateTimeFormat.format(endDate),
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                textStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDetailsRow(BuildContext context, double open, double close) {
    double diff = close - open;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          close > open ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
          color: close > open ? Colors.green : Colors.red,
          size: 14,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          diff.toStringAsFixed(2),
          style: GoogleFonts.nunito(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            textStyle: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }

  ///Call endpoint here

  void performSearch(DateTime? start, DateTime? end) {
    ref.read(dateTimeStart.notifier).state = start!;
    ref.read(endTimeStart.notifier).state = end!;
    ref.read(loadingDetailsProvider.notifier).state = true;
    ref
        .read(intradayDataProvider.notifier)
        .retrieveIntraday(widget.dataSet.symbol!, ref);
  }
}
