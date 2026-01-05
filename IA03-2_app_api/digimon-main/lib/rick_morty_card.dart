import 'package:flutter/material.dart';
import 'rick_morty_model.dart';
import 'rick_morty_detail_page.dart';

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard(this.character, {super.key});

  @override
  _CharacterCardState createState() => _CharacterCardState(character);
}

class _CharacterCardState extends State<CharacterCard> {
  Character character;

  _CharacterCardState(this.character);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.greenAccent;
      case 'dead':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Widget get characterImage {
    var characterAvatar = Hero(
      tag: character.id,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(character.image)
          ),
        ),
      ),
    );

    return characterAvatar;
  }

  Widget get characterCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color(0xFF3C3E44), 
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.character.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.character.status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.character.status,
                      style: const TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
                Text(
                  widget.character.species,
                  style: const TextStyle(color: Colors.white70, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCharacterDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CharacterDetailPage(character);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showCharacterDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              characterCard,
              Positioned(top: 7.5, child: characterImage),
            ],
          ),
        ),
      ),
    );
  }
}