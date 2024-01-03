import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class EditLobbyWidget extends StatefulWidget {
  final LobbyModel currentLobby;
  const EditLobbyWidget({super.key, required this.currentLobby});

  @override
  State<EditLobbyWidget> createState() => _EditLobbyWidgetState();
}

class _EditLobbyWidgetState extends State<EditLobbyWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleInput;
  TextEditingController _destInput = TextEditingController();
  DateTimeRange? _datePicked;

  @override
  void initState() {
    super.initState();
    _titleInput = TextEditingController(text: widget.currentLobby.title);
    _destInput = TextEditingController(text: widget.currentLobby.destination);
    if (widget.currentLobby.startDate != null) {
      _datePicked = DateTimeRange(
        start: widget.currentLobby.startDate!,
        end: widget.currentLobby.endDate!,
      );
    }
  }

  @override
  void dispose() {
    _titleInput.dispose();
    _destInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Lobby Details',
                          ),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: CustomTextInput(
                          label: 'Title',
                          controller: _titleInput,
                          validator: isEmpty,
                        ),
                      ),
                      CustomTextInput(
                        label: 'Destination',
                        controller: _destInput,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Trip Date',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () async {
                              _datePicked = await showDateRangePicker(
                                context: context,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                              );
                              if (_datePicked != null) {
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Color(0xFF52B2FA),
                                      size: 24.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _datePicked != null
                                          ? (_datePicked!.duration.inDays == 0
                                              ? "${DateFormat('MMM d').format(_datePicked!.start)}"
                                              : "${DateFormat('MMM d').format(_datePicked!.start)} - ${DateFormat('MMM d').format(_datePicked!.end)}")
                                          : '',
                                    ),
                                  ),
                                  _datePicked != null
                                      ? IconButton(
                                          onPressed: () {
                                            _datePicked = null;
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.close_rounded),
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ].divide(
                      SizedBox(
                        height: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialogLoading(context);
                        final uLobby = LobbyModel(
                          id: widget.currentLobby.id,
                          title: _titleInput.text,
                          destination: _destInput.text,
                          startDate: _datePicked?.start,
                          endDate: _datePicked?.end,
                        );
                        final provider = context.read<Auth>() as UserController;
                        final value = await provider.editLobby(uLobby);
                        if (value) {
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSuccess('Lobby details saved'),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showError('Saving failed',
                                Theme.of(context).colorScheme.error),
                          );
                        }
                        context.pop();
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
