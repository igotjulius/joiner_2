import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:provider/provider.dart';

class BudgetCategoryWidget extends StatelessWidget {
  final String? lobbyId;
  final String? label;
  final double? amount;
  final String? hostId;
  const BudgetCategoryWidget({
    super.key,
    this.hostId,
    this.lobbyId,
    this.label,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<FFAppState>().currentUser?.id;
    return GestureDetector(
      onLongPress: () async {
        if (currentUserId == hostId) {
          showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text('Delete'),
                  content:
                      Text('Are you sure you want to delete $label expense?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // await UserController.deleteSpecificExpense(
                        //     lobbyId!, label!);
                        Fluttertoast.showToast(
                          msg: '$label Expense Deleted.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 10.0,
                        );
                        context.pop();
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
                )),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Only a Host can remove expenses.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 10.0,
          );
        }
      },
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xff9c9c9c),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    label!,
                    style: TextStyle(fontSize: 16),
                  ),
                ].divide(
                  SizedBox(
                    width: 8,
                  ),
                ),
              ),
              Row(
                children: [
                  withCurrency(
                    Text(amount.toString()),
                  ),
                ].divide(
                  SizedBox(
                    width: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
