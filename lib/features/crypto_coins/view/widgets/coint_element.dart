import 'package:binance_test/repositories/websockets/models/mini_ticker_model.dart';
import 'package:binance_test/ui/app_colors.dart';
import 'package:binance_test/ui/text_styles.dart';
import 'package:flutter/material.dart';

class CointElement extends StatelessWidget {
  const CointElement({
    super.key,
    required this.miniTickerModel,
  });

  final MiniTickerModel? miniTickerModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: '${miniTickerModel?.tickerName?.substring(0, 3)}',
                style: TextStyles.bold22(AppColors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: ' /USDT',
                    style: TextStyles.bold16(AppColors.grey),
                  ),
                ],
              ),
            ),
            Text(
              'Vol ${miniTickerModel?.roundMillions()}M',
              style: TextStyles.bold16(AppColors.grey),
            ),
          ],
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${miniTickerModel?.currentValue?.substring(0, 8)}',
                style: TextStyles.bold16(
                  miniTickerModel?.greenDiff ?? false
                      ? AppColors.green
                      : AppColors.red,
                ),
              ),
              Text(
                '${miniTickerModel?.openValue?.substring(0, 8)}\$',
                style: TextStyles.bold16(AppColors.grey),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: miniTickerModel?.greenDiff ?? false
                ? AppColors.green
                : AppColors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          height: 45,
          width: 103,
          child: Center(
            child: Text(
              '${miniTickerModel?.percentDiff}%',
              style: TextStyles.bold18(AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
