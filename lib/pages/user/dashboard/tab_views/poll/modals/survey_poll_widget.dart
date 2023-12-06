import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import '/flutter_flow/flutter_flow_util.dart';
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

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SurveyPollModel());

    _model.questionController ??= TextEditingController();
    _model.choicesController!.add(TextEditingController());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Text('Add a Choice'),
                  onPressed: () {
                    setState(() {
                      _model.choicesController!.add(TextEditingController());
                    });
                  },
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
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
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      final nPoll = await _model.createPoll(widget.lobbyId!);
                      Provider.of<LobbyProvider>(context, listen: false)
                          .addPoll(nPoll!);
                      context.pop();
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
    );
  }
}
