import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'rick_morty_model.dart';
import 'rick_morty_list.dart';
import 'new_character_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF24282F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF97CE4C),
          secondary: Color(0xFF00B5CC),
        ),
      ),
      home: const MyHomePage(
        title: 'Rick & Morty App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Character> initialCharacters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialCharacters();
  }

  Future<void> _fetchInitialCharacters() async {
    try {
      final url = Uri.parse('https://rickandmortyapi.com/api/character');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];
        
        setState(() {
          initialCharacters = results.map((json) => Character.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future _showNewCharacterForm() async {
    Character? newCharacter = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddCharacterFormPage();
    }));
    
    if (newCharacter != null) {
      initialCharacters.add(newCharacter);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF24282F),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _showNewCharacterForm,
          ),
        ],
      ),
      body: Container(
          color: const Color(0xFF24282F),
          child: Center(
            child: isLoading 
              ? const CircularProgressIndicator(color: Color(0xFF97CE4C)) 
              : CharacterList(initialCharacters),
          )),
    );
  }
}