import 'package:flutter/material.dart';
import 'rick_morty_model.dart';
import 'rick_morty_card.dart';

class CharacterList extends StatelessWidget {
  final List<Character> characters;
  const CharacterList(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return CharacterCard(characters[index]);
      },
    );
  }
}

