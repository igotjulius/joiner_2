import 'package:go_router/go_router.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'survey_poll_model.dart';

export 'survey_poll_model.dart';

class SurveyPollWidget extends StatefulWidget {
  final String? lobbyId;
  const SurveyPollWidget({
    Key? key,
    this.lobbyId,
  }) : super(key: key);

  @override
  _SurveyPollWidgetState createState() => _SurveyPollWidgetState();
}

class _SurveyPollWidgetState extends State<SurveyPollWidget> {
  late SurveyPollModel _model;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = SurveyPollModel();

    _model.questionController ??= TextEditingController();
    _model.choicesController!.add(TextEditingController());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  controller: _model.questionController,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  validator: isEmpty,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: Text('Add a Choice'),
                      onPressed: () {
                        setState(() {
                          _model.choicesController!
                              .add(TextEditingController());
                        });
                      },
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _model.choicesController!.length,
                      itemBuilder: (context, index) {
                        return CustomTextInput(
                          controller: _model.choicesController![index],
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
                          // final nPoll = await _model.createPoll(widget.lobbyId!);
                          if (_formKey.currentState!.validate()) {
                            List<Map<String, dynamic>> choices = [];
                            _model.choicesController!.forEach((element) {
                              if (element.text.trim().isNotEmpty)
                                return choices.add({
                                  'title': element.text,
                                  'voters': [],
                                });
                            });
                            final nPoll = PollModel(
                              question: _model.questionController?.text,
                              choices: choices,
                              isOpen: true,
                            );
                            context.read<LobbyProvider>().addPoll(nPoll);
                            context.pop();
                          }
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
      ),
    );
  }
}
