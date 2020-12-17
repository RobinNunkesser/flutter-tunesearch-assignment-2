import 'package:tunesearch_assignment_2/collection_view_model.dart';
import 'package:tunesearch_assignment_2/track_view_model.dart';
import 'package:tunesearchexample_core_ports/tunesearchexample_core_ports.dart';

extension CollectionMapping on TrackCollection {
  CollectionViewModel toCollectionViewModel() => CollectionViewModel(
      title: this.name,
      tracks: this.tracks.map((track) => track.toTrackViewModel()).toList());
}

extension TrackMapping on Track {
  TrackViewModel toTrackViewModel() =>
      TrackViewModel('${this.trackNumber} - ${this.trackName}',
          this.artistName, this.artworkUrl);
}