import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/lobby_model.dart';
import 'package:provider/provider.dart';

class ArchivedLobbies extends StatelessWidget {
  final DateFormat dateFormat = DateFormat('MMM dd');
  ArchivedLobbies({super.key});

  Widget displayLobbies(List<LobbyModel> lobbies) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: lobbies.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsetsDirectional.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/lambug-beach-badian.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lobbies[index].title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lobbies[index].startDate != null
                                ? "${dateFormat.format(lobbies[index].startDate!)} - ${dateFormat.format(lobbies[index].endDate!)}"
                                : '-',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '${lobbies[index].participants!.length} people involved',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final lobbies = (context.watch<Auth>() as UserController).archivedLobbies;
    return Scaffold(
      appBar: AppBar(
        title: Text('Archived lobbies'),
      ),
      body: lobbies.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.archive_rounded,
                    size: 52,
                    color: Colors.grey,
                  ),
                  Text('No lobbies in the archive'),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: displayLobbies(lobbies),
              ),
            ),
    );
  }
}
