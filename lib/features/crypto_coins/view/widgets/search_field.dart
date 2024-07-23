import 'package:binance_test/ui/app_colors.dart';
import 'package:binance_test/ui/text_styles.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.search,
  });

  final Function(String) search;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightGrey,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search coin pairs',
              ),
              onChanged: (value) => search(value),
              style: TextStyles.regular16(AppColors.grey),
            ),
          )
        ],
      ),
    );
  }
}
