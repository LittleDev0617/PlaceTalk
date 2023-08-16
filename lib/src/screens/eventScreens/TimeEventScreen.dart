import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placetalk/src/blocs/PlaceInfoblocs/place_info_bloc.dart';
import 'package:placetalk/src/repositories/SessionRepo.dart';

@RoutePage()
class TimeEventScreen extends StatelessWidget {
  const TimeEventScreen({super.key, this.placeID, this.name});

  final int? placeID;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceTimeBloc, PlaceInfoState>(
      builder: (context, state) {
        if (state is PlaceTimeLoaded) {
          return Center(
              child: ListView(children: [
            Image.network(
              SessionRepo().getImageUrl(
                '${state.placeTimeList['images']['image_id']}',
              ),
            )
          ]));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
