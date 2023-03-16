import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'events web scrapa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future<List> getWebsiteData() async {
    List<String> listOfId = [];//list of id's
    for (var pageNum = 1; pageNum <= 5; pageNum++) {//to iterate through 5 pages
      final url = Uri.parse(
          'https://www.eventbrite.com/d/ca--santa-cruz/all-events/?page=$pageNum'); //increments page number in the link
      final response = await http.get(url);
      final html = parser.parse(response.body);
      final spans =
          html.querySelectorAll('span[class^="eds-event-card__actions-id__"]');//gets all span classes that start with name "eds-event-card...."
      for (final name in spans) {//to add to list
        final className = name.className;//get class name for each spans, not its content
        final String ids = className.substring(28, 40);//turns class name into string, and substrings for the event id
        if (listOfId.contains(ids)) {//checks for duplicates
          //nothing
        } else {
          listOfId.add(ids);//add the id string to listOfId if not in there already
        }
      }
    }
    for (String nums in listOfId) {//for testing
      print(nums);
    }
    return listOfId;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: Text(
            'hey this works',
          ),
        ));
  }
}
//ignore this stuff
/*
  Future getWebsiteData() async {
    final url = Uri.parse(
        'https://www.eventbrite.com/d/ca--santa-cruz/all-events/?page=1');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('body > script:nth-child(9)')
        .map((element) => element.innerHtml.trim())
        .toList();


    debugPrint('Count: ${titles.length}');
    for (final title in titles) {
      debugPrint(title);
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'hey this works',
        ),
      ),
    );
  }
}
*/

  
/*
  Future getWebsiteData() async {
    final rawUrl =
        'https://www.google.com/search?q=Events+in+Santa+Cruz&ibp=htl;events&hl=en';
    final eventsPerPage = 10;
    final numResults = 150;
    List<String> titles = [];

    for (int start = 0; start < numResults; start += eventsPerPage) {
      final url = Uri.parse('$rawUrl&start=$start');
      final response = await http.get(url);
      dom.Document html = dom.Document.html(response.body);
      final pageTitles = html
          .querySelectorAll('div > div.fzHfmf > div.YOGjf')
          .map((element) => element.innerHtml.trim())
          .toList();
      titles.addAll(pageTitles);
    }
    print('Count: ${titles.length}');
    for (final title in titles) {
      debugPrint(title);
    }
  }
*/


