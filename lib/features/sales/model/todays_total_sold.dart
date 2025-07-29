

import 'package:hive_flutter/adapters.dart';
part 'todays_total_sold.g.dart';

@HiveType(typeId:4)
class TodaysTotalSold {
  @HiveField(0)
  int totalSalesToday;
    @HiveField(1)

  int totalProductSoldToday;
    @HiveField(2)

  int totalProfitToday;
  TodaysTotalSold({
    required this.totalProductSoldToday,
    required this.totalSalesToday,
    required this.totalProfitToday,
  });
}
