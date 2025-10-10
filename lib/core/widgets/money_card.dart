import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class MoneyCard extends StatelessWidget {
  final String balance;
  final String cardName;
  final String income;
  final String expense;
  final String expenseName;
  final String incomeName;
  final HugeIcon incomeIcon;
  final HugeIcon expenseIcon;

  const MoneyCard({
    super.key,
    required this.balance,
    required this.expense,
    required this.income,
    required this.expenseName,
    required this.incomeName,
    required this.incomeIcon,
    required this.expenseIcon,
    required this.cardName,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              offset: const Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),

              Text(
                cardName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: screenWidth / 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'YER $balance',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: incomeIcon,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              incomeName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              income,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              expenseName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              expense,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          child: expenseIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
