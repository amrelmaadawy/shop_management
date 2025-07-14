
import 'package:flutter/material.dart';
import 'package:small_managements/generated/l10n.dart';

class TopSellingItem extends StatelessWidget {
  const TopSellingItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Image.asset('assets/images/apple.png'),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${S.of(context).product} Apple'),
              SizedBox(height: 5),
              Text('1231  ${S.of(context).sold}'),
            ],
          ),
        ],
      ),
    );
  }
}
