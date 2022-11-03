import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_market_app/model/companies.dart';
import 'package:stock_market_app/model/company_logo.dart';

class CustomListItem extends StatelessWidget {
  final double open;
  final double close;
  final String symbol;
  const CustomListItem({
    Key? key,
    required this.open,
    required this.close,
    required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svg = CompanyLogo.search(companyLogo, symbol);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: symbol,
                child: SvgPicture.asset(
                  'assets/svg/$svg-svgrepo-com.svg',
                  height: 50,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symbol,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        textStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      Companies.search(companies, symbol),
                      style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        textStyle: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                close < open ? 'assets/svg/down.svg' : 'assets/svg/up.svg',
                height: 40,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${close.toStringAsFixed(2)}",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      textStyle: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  buildRow(context, open, close),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildRow(BuildContext context, double open, double close) {
    double diff = close - open;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FaIcon(
          close > open ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
          color: close > open ? Colors.green : Colors.red,
          size: 14,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          diff.toStringAsFixed(2),
          style: GoogleFonts.nunito(
            color: Colors.black54,
            fontWeight: FontWeight.normal,
            textStyle: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
