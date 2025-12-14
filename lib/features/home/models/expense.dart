import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
final formatterNumber = NumberFormat('#,###,##0');

const uuid = Uuid();

final items = [
  const HugeIcon(icon: HugeIcons.strokeRoundedUser03),
  const HugeIcon(icon: HugeIcons.strokeRoundedHome03),
  const HugeIcon(icon: HugeIcons.strokeRoundedSettings03),
];

class Expense {
  final String id;
  final String title;
  final String note;
  final String amount;
  final String date;
  final bool isStudent;
  final bool isExpense;

  Expense({
    required this.id,
    required this.isStudent,
    required this.isExpense,
    required this.title,
    required this.note,
    required this.amount,
    required this.date,
  });

  factory Expense.formFirebase(json) {
    return Expense(
      isStudent: json['isStudent'],
      isExpense: json['isExpense'],
      title: json['title'],
      id: json['id'],
      note: json['note'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.substring(0, 10),
      'note': note,
      'isExpense': isExpense,
      'isStudent': isStudent,
    };
  }
}
