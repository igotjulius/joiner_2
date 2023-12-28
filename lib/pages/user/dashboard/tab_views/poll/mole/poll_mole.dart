import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/poll_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/poll_choices.dart';
import 'package:provider/provider.dart';

class PollMolecule extends StatefulWidget {
  final String lobbyId;
  final PollModel poll;
  const PollMolecule({
    super.key,
    required this.lobbyId,
    required this.poll,
  });

  @override
  State<PollMolecule> createState() => _PollMoleculeState();
}

class _PollMoleculeState extends State<PollMolecule> {
  late PollMoleModel _model;

  Future<dynamic> confirmationDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete'),
        content: Text('Are you sure you want to delete this poll?'),
        actions: [
          TextButton(
            onPressed: () async {
              final provider = context.read<Auth>() as UserController;
              provider
                  .deletePoll(widget.lobbyId, _model.poll.id!)
                  .then((value) {
                if (value)
                  context.pop();
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    showError('Can\'t delete poll :(',
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
    _model = PollMoleModel(
        poll: widget.poll, userId: context.read<Auth>().profile!.id!);
    final provider = context.read<Auth>() as UserController;
    _model.count();
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _model.poll.question!,
            ),
            Divider(),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _model.poll.choices!.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.zero,
                  color: index == _model.selectedIndex
                      ? Theme.of(context).primaryColor
                      : null,
                  child: AbsorbPointer(
                    absorbing: !_model.poll.isOpen!,
                    child: InkWell(
                      customBorder: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onTap: () {
                        provider
                            .votePoll(_model.poll.choices![index]['title'],
                                widget.lobbyId)
                            .then((value) {
                          if (value) {
                            _model.votePoll(index);
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              showError('Can\'t vote :(',
                                  Theme.of(context).colorScheme.error),
                            );
                          }
                        });
                      },
                      child: PollChoices(
                        choice: _model.poll.choices![index]['title'],
                        count: _model.counts[index],
                        textColor:
                            index == _model.selectedIndex ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 24.0,
                  ),
                  onPressed: () {
                    confirmationDialog();
                  },
                ),
                TextButton(
                  onPressed: () {
                    provider
                        .closePoll(widget.lobbyId, _model.poll.id!)
                        .then((value) {
                      if (value) {
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          showError('Can\'t close poll :(',
                              Theme.of(context).colorScheme.error),
                        );
                      }
                    });
                  },
                  child:
                      Text(_model.poll.isOpen! ? 'Close poll' : 'Re-open poll'),
                ),
              ],
            ),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}

class PollMoleModel {
  PollMoleModel({
    required this.poll,
    required this.userId,
    this.selectedIndex,
  });
  final String userId;
  final PollModel poll;
  late List<int> counts;
  int? selectedIndex;

  // Vote to a poll
  void votePoll(int index) {
    selectedIndex == index ? selectedIndex = null : selectedIndex = index;
    var {'title': _, 'voters': voters as List} = poll.choices![
        selectedIndex == null ? index : selectedIndex!]; // Selected choice
    if (hasVoted()) {
      if (voters.any((voter) => voter == userId)) {
        voters.remove(userId);
      } else {
        removeVote();
        voters.add(userId);
      }
    } else {
      voters.add(userId);
    }
    count();
  }

  void removeVote() {
    var choices = poll.choices;
    for (int i = 0; i < choices!.length; i++) {
      final voters = choices[i]['voters'] as List;
      voters.remove(userId);
    }
  }

  // Count voters
  void count() {
    final choices = poll.choices;
    counts = choices!.map((e) => (e['voters'] as List).length).toList();
    for (int i = 0; i < choices.length; i++) {
      final voters = choices[i]['voters'] as List;
      if (voters.any((voter) => voter == userId)) {
        selectedIndex = i;
        break;
      }
    }
  }

  // Check if user has voted
  bool hasVoted() {
    bool alreadyVoted = false;
    final choices = poll.choices;
    for (int i = 0; i < choices!.length; i++) {
      final voters = choices[i]['voters'] as List;
      alreadyVoted = voters.any((voter) => voter == userId);
      if (alreadyVoted) break;
    }
    return alreadyVoted;
  }
}
