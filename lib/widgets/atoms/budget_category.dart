import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final String lobbyId;
  final String label;
  final double amount;
  final String hostId;
  const BudgetCategoryWidget({
    super.key,
    required this.hostId,
    required this.lobbyId,
    required this.label,
    required this.amount,
  });

  Future<dynamic> confirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure you want to delete $label expense?'),
        actions: [
          TextButton(
            onPressed: () async {
              final provider = context.read<Auth>() as UserController;
              provider.deleteSpecificExpense(lobbyId, label).then((value) {
                if (value)
                  context.pop();
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    showError('Can\'t delete expense',
                        Theme.of(context).colorScheme.error),
                  );
                }
              });
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<Auth>().profile?.id;
    return InkWell(
      onLongPress: currentUserId != hostId
          ? null
          : () async {
              confirmationDialog(context);
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
            withCurrency(
              Text(amount.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
