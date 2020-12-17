
import 'package:tunesearch_assignment_2/track_view_model.dart';

class CollectionViewModel {
  CollectionViewModel({this.title, this.tracks});
  final String title;
  List<TrackViewModel> tracks;
}