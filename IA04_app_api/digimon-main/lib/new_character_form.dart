import 'package:flutter/material.dart';
import 'rick_morty_model.dart';

class AddCharacterFormPage extends StatefulWidget {
  const AddCharacterFormPage({super.key});

  @override
  _AddCharacterFormPageState createState() => _AddCharacterFormPageState();
}

class _AddCharacterFormPageState extends State<AddCharacterFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  
  String status = 'Alive';
  final List<String> statusOptions = ['Alive', 'Dead', 'unknown'];

  void submitCharacter(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the character name'),
      ));
    } else {
      var newCharacter = Character(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        status: status,
        species: speciesController.text.isNotEmpty ? speciesController.text : 'Unknown',
        location: 'Unknown',
        image: 'https://rickandmortyapi.com/api/character/avatar/19.jpeg', 
      );
      Navigator.of(context).pop(newCharacter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new character', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF24282F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF24282F),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Character Name',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: speciesController,
                style: const TextStyle(decoration: TextDecoration.none, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Species',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: DropdownButtonFormField<String>(
                value: status,
                dropdownColor: const Color(0xFF3C3E44),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(color: Color(0xFF97CE4C)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF97CE4C))),
                ),
                items: statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF97CE4C),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => submitCharacter(context),
                  child: const Text('Submit Character'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}