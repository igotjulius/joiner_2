import 'package:flutter/material.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class EditLobbyWidget extends StatefulWidget {
  final LobbyModel? currentLobby;
  const EditLobbyWidget({super.key, this.currentLobby});

  @override
  State<EditLobbyWidget> createState() => _EditLobbyWidgetState();
}

class _EditLobbyWidgetState extends State<EditLobbyWidget> {
  late EditLobbyModel _model;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = EditLobbyModel(widget.currentLobby!);
    if (widget.currentLobby!.startDate != null) {
      _model.datePicked = DateTimeRange(
        start: widget.currentLobby!.startDate!,
        end: widget.currentLobby!.endDate!,
      );
    }
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
                          controller: _model.titleInput,
                          validator: isEmpty,
                        ),
                      ),
                      CustomTextInput(
                        label: 'Destination',
                        controller: _model.destInput,
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
                              _model.datePicked = await showDateRangePicker(
                                context: context,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                              );
                              if (_model.datePicked != null) {
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
                                      _model.datePicked != null
                                          ? (_model.datePicked!.duration
                                                      .inDays ==
                                                  0
                                              ? "${DateFormat('MMM d').format(_model.datePicked!.start)}"
                                              : "${DateFormat('MMM d').format(_model.datePicked!.start)} - ${DateFormat('MMM d').format(_model.datePicked!.end)}")
                                          : '',
                                    ),
                                  ),
                                  _model.datePicked != null
                                      ? IconButton(
                                          onPressed: () {
                                            _model.datePicked = null;
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

                        _model.editLobby().then(
                          (value) {
                            if (value != null) {
                              Provider.of<LobbyProvider>(context, listen: false)
                                  .setCurrentLobby(value);
                              Provider.of<FFAppState>(context, listen: false)
                                  .updateCachedLobby(value);
                              ScaffoldMessenger.of(context).showSnackBar(
                                showSuccess('Lobby details saved'),
                              );
                              context.pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                showError('Saving failed',
                                    Theme.of(context).colorScheme.error),
                              );
                            }
                          },
                        );
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

class EditLobbyModel {
  TextEditingController? titleInput;
  TextEditingController? destInput;
  DateTimeRange? datePicked;
  LobbyModel? currentLobby;

  EditLobbyModel(LobbyModel currentLobby) {
    this.currentLobby = currentLobby;
    titleInput ??= TextEditingController(text: this.currentLobby?.title);
    destInput ??= TextEditingController(text: this.currentLobby?.destination);
  }

  void dispose() {
    titleInput?.dispose();
    destInput?.dispose();
  }

  Future<LobbyModel?> editLobby() async {
    final uLobby = LobbyModel(
      id: currentLobby?.id,
      title: titleInput.text,
      destination: destInput.text,
      startDate: datePicked?.start,
      endDate: datePicked?.end,
    );
    return await UserController.editLobby(uLobby);
  }
}
