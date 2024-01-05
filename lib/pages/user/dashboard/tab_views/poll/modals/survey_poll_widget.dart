import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPollWidget extends StatefulWidget {
  final String lobbyId;
  const SurveyPollWidget({super.key, required this.lobbyId});

  @override
  _SurveyPollWidgetState createState() => _SurveyPollWidgetState();
}

class _SurveyPollWidgetState extends State<SurveyPollWidget> {
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _choicesController = [];
  String? _emptyQuestion;

  @override
  void initState() {
    super.initState();
    _choicesController.add(TextEditingController());
  }

  @override
  void dispose() {
    _questionController.dispose();
    _choicesController.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create a Poll',
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
              CustomTextInput(
                label: 'Question',
                hintText: 'What are you deciding about?',
                controller: _questionController,
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                errorText: _emptyQuestion,
                onChanged: (value) {
                  setState(() {
                    _emptyQuestion = null;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    child: Text('Add a Choice'),
                    onPressed: () {
                      setState(() {
                        _choicesController.add(TextEditingController());
                      });
                    },
                  ),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _choicesController.length,
                    itemBuilder: (context, index) {
                      return CustomTextInput(
                        controller: _choicesController[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ].divide(
                  SizedBox(height: 10),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () async {
                        if (_questionController.text.trim().isEmpty) {
                          setState(() {
                            _emptyQuestion = 'Question is required';
                          });
                          return;
                        }
                        if (!_choicesController
                            .any((element) => element.text.trim().isNotEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            showError('A choice is required',
                                Theme.of(context).colorScheme.error),
                          );
                          return;
                        }
                        List<String> choices = [];
                        _choicesController.forEach((element) {
                          if (element.text.trim().isNotEmpty)
                            choices.add(element.text);
                        });
                        final nPoll = PollModel(
                          question: _questionController.text,
                          choices: choices,
                        );
                        final provider = context.read<Auth>() as UserController;
                        provider
                            .createPoll(nPoll, widget.lobbyId)
                            .then((value) {
                          context.pop();
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              showSuccess('Poll created'),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              showError('Can\'t create',
                                  Theme.of(context).colorScheme.error),
                            );
                          }
                        });
                      },
                      label: Text('Create'),
                      icon: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
