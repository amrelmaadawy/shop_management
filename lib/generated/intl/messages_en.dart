// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "TotalSales": MessageLookupByLibrary.simpleMessage("Total Sales Today"),
    "Totalproduct": MessageLookupByLibrary.simpleMessage(
      "Total Products in Stock",
    ),
    "compareTo": MessageLookupByLibrary.simpleMessage(
      "Compared to \$1,100 yesterday",
    ),
    "homeAppBar": MessageLookupByLibrary.simpleMessage("Overview"),
    "itemsInclude": MessageLookupByLibrary.simpleMessage(
      "Including 5 new items",
    ),
    "salesSummary": MessageLookupByLibrary.simpleMessage("Sales Summary"),
    "splashTitel": MessageLookupByLibrary.simpleMessage(
      "Manage your products, track sales, and generate reports with ease.",
    ),
    "splashWelcome": MessageLookupByLibrary.simpleMessage(
      "Welcome To Shope Manager",
    ),
    "thisWeek": MessageLookupByLibrary.simpleMessage("This Week"),
  };
}
