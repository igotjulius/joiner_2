import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/participant_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ParticipantBudget extends StatefulWidget {
  final ParticipantModel participant;
  final String lobbyId;
  final double totalExpense;
  const ParticipantBudget({
    super.key,
    required this.participant,
    required this.lobbyId,
    required this.totalExpense,
  });

  @override
  State<ParticipantBudget> createState() => _ParticipantBudgetState();
}

class _ParticipantBudgetState extends State<ParticipantBudget> {
  final _formKey = GlobalKey<FormState>();

  Widget mainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            '${widget.participant.firstName} ${widget.participant.lastName}',
          ),
          Spacer(),
          withCurrency(
            Text(
              widget.participant.contribution!['amount'].toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text((widget.participant.contribution!['inPercent']! * 100)
                  .toString() +
              '%'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<Auth>().profile?.id;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: userId == widget.participant.userId
          ? InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final _amountController = TextEditingController(
                      text:
                          widget.participant.contribution?['amount'].toString(),
                    );
                    final _percentController = TextEditingController(
                      text:
                          (widget.participant.contribution!['inPercent']! * 100)
                              .toString(),
                    );
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 32,
                        ),
                        child: Wrap(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextInput(
                                    label: 'Amount',
                                    direction: TextInputDirection.row,
                                    controller: _amountController,
                                    validator: isEmpty,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    prefixIcon: Icon(
                                      MdiIcons.currencyPhp,
                                      color: Colors.black38,
                                      size: 14,
                                    ),
                                    inputFormatters:
                                        FilteringTextInputFormatter.digitsOnly,
                                    onChanged: (value) {
                                      if (value.trim().isNotEmpty) {
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue != null)
                                          _percentController.text =
                                              '${(parsedValue / widget.totalExpense) * 100}';
                                      }
                                    },
                                  ),
                                  CustomTextInput(
                                    label: 'Percentage based on total expenses',
                                    direction: TextInputDirection.row,
                                    controller: _percentController,
                                    validator: isEmpty,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    inputFormatters:
                                        FilteringTextInputFormatter.allow(
                                      RegExp(r'^([0-9]*\.?[0-9]*)'),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.percent_rounded,
                                      color: Colors.black38,
                                      size: 16,
                                    ),
                                    onChanged: (value) {
                                      if (value.trim().isNotEmpty) {
                                        final parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue != null)
                                          _amountController.text =
                                              '${widget.totalExpense * (parsedValue / 100)}';
                                      }
                                    },
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialogLoading(context);
                                      if (_formKey.currentState!.validate()) {
                                        (context.read<Auth?>()
                                                as UserController)
                                            .increaseContribution(
                                          widget.lobbyId,
                                          double.parse(_amountController.text),
                                          double.parse(_percentController.text),
                                        )
                                            .then((value) {
                                          context.pop();
                                          context.pop();
                                          if (value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              showSuccess(
                                                  'Contribution increased'),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              showError(
                                                  'Can\'t increase :(',
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            );
                                          }
                                        });
                                      }
                                    },
                                    child: Text('Increase contribution'),
                                  ),
                                ].divide(
                                  SizedBox(
                                    height: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: mainContent(),
            )
          : mainContent(),
    );
  }
}
