import 'package:flutter/material.dart';

void main() {
  runApp(BeachesApp());
}

class Beach {
  final String name;
  final String description;
  final String picture;

  Beach(this.name, this.description, this.picture);
}

class BeachesApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BeachesAppState();
}

class _BeachesAppState extends State<BeachesApp> {
  Beach _selectedBeach;

  List<Beach> beaches = [
    Beach(
        'Praia da Marinha',
        'Praia da Marinha is one of the most beautiful beaches in Portugal and all of Europe. It is located in the central Algarve near the towns of Lagoa and Carvoeiro and is known for its stunning cliff formations, golden sand, and clear blue water.',
        'assets/images/portugal-praia-marinha.jpeg'),
    Beach(
        'Benagil Cave',
        'Pleasant as this little beach is it is the sea cave at Benagil that really sets it apart. Falling squarely into the weird and wonderful category Benagil sea cave was actually voted one of the 10 Coolest Caves in the World by Huffington Post readers. Only accessible by a quick boat trip,  the cave is actually a self contained sandy beach within a circular grotto complete with triple arched entrance.',
        'assets/images/portugal-benagil-caves.jpeg'),
    Beach(
        'Praia do Carvalho',
        'Completely surrounded by high cliffs, this small beach is known for its soft, golden sand and crystal clear water. Sheltered from the wind, Praia do Carvalho is perfect for unwinding, swimming, snorkeling, and cliff diving! Because there is a risk of falling rocks from the cliffs, be sure to keep yourself safe by sitting a small distance away from the cliff face. It is also worth noting that there are no lifeguards on duty.',
        'assets/images/portugal-praia-do-carvalho.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beaches App',
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('BeachesListPage'),
            child: BeachesListScreen(
              beaches: beaches,
              onTapped: _handleBeachTapped,
            ),
          ),
          if (_selectedBeach != null) BeachDetailsPage(beach: _selectedBeach)
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          // Update the list of pages by setting _selectedBeach to null
          setState(() {
            _selectedBeach = null;
          });

          return true;
        },
      ),
    );
  }

  void _handleBeachTapped(Beach beach) {
    setState(() {
      _selectedBeach = beach;
    });
  }
}

class BeachDetailsPage extends Page {
  final Beach beach;

  BeachDetailsPage({
    this.beach,
  }) : super(key: ValueKey(beach));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BeachDetailsScreen(beach: beach);
      },
    );
  }
}

class BeachesListScreen extends StatelessWidget {
  final List<Beach> beaches;
  final ValueChanged<Beach> onTapped;

  BeachesListScreen({
    @required this.beaches,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portugal Beaches',
            style: TextStyle(fontSize: 22, fontFamily: 'Loro')),
        actions: [IconButton(icon: Icon(Icons.emoji_emotions_rounded))],
      ),
      body: ListView(
        children: [
          for (var beach in beaches)
            ListTile(
              title: Text(beach.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Loro',
                      fontStyle: FontStyle.italic)),
              subtitle: Text(beach.description,
                  style: TextStyle(fontSize: 16, fontFamily: 'Loro')),
              onTap: () => onTapped(beach),
            )
        ],
      ),
    );
  }
}

class BeachDetailsScreen extends StatelessWidget {
  final Beach beach;

  BeachDetailsScreen({
    @required this.beach,
    
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beach :heart:')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (beach != null) ...[
              Text(beach.name, style: Theme.of(context).textTheme.headline6),
              Image.asset(beach.picture),
              
            ],
          ],
        ),
      ),
    );
  }
}
