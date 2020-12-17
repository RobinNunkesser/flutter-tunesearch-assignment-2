import 'package:flutter/material.dart';
import 'package:tunesearch_assignment_2/search_term_dto.dart';
import 'package:tunesearch_assignment_2/tunes_list_page.dart';
import 'package:tunesearch_assignment_2/entity_mappings.dart';
import 'package:tunesearchexample_mockcore/tunesearchexample_mockcore.dart';
import 'package:tunesearchexample_core_ports/tunesearchexample_core_ports.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _searchview = TextEditingController();
  bool _areButtonsDisabled = false;
  var searchCommand = MockSearchTracksCommand();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [IconButton(icon: Icon(Icons.info),
            onPressed: () => showLicensePage(context: context))],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchview,
              decoration: InputDecoration(
                hintText: 'Search term',
                hintStyle: TextStyle(color: Colors.grey[300]),
              ),
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              child: Text('Search'),
              onPressed: _areButtonsDisabled ? null : _search,
            )
          ],
        ),
      ),
    );
  }

  void _search() {
    searchCommand
        .execute(
        inDTO: SearchTermDTO(term: _searchview.text))
        .then(success)
        .catchError((error) => failure(error));
    setState(() => _areButtonsDisabled = true);
  }

  void success(List<TrackCollection> collections) {
    setState(() => _areButtonsDisabled = false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          TunesListPage(collections: collections.map((collection) =>
              collection.toCollectionViewModel()).toList())),
    );
  }

  void failure(Exception error) {
    showError(context, error);
  }

  Future<void> showError(BuildContext context, Exception e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(e.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}