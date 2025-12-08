import 'package:flutter/material.dart';
import 'rick_morty_model.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;
  const CharacterDetailPage(this.character, {super.key});

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  final double characterAvatarSize = 150.0;

  Widget get characterImage {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Center(
              child: Hero(
                tag: widget.character.id,
                child: InteractiveViewer(
                  child: Image.network(widget.character.image),
                ),
              ),
            ),
          );
        }));
      },
      child: Hero(
        tag: widget.character.id,
        child: Container(
          height: characterAvatarSize,
          width: characterAvatarSize,
          constraints: const BoxConstraints(),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
                BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
                BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
              ],
              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.character.image))),
        ),
      ),
    );
  }

  Widget get characterProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xFF24282F), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          characterImage,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.character.name, 
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold)
            ),
          ),
          Text(
            '${widget.character.status} - ${widget.character.species}', 
            style: const TextStyle(color: Color(0xFF97CE4C), fontSize: 20.0)
          ),
          const SizedBox(height: 10),
          Text(
            'Last known location:', 
            style: const TextStyle(color: Colors.grey, fontSize: 14.0)
          ),
          Text(
            widget.character.location, 
            style: const TextStyle(color: Colors.white, fontSize: 16.0)
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24282F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24282F), 
        elevation: 0,
        title: Text('Meet ${widget.character.name}', style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[characterProfile],
      ),
    );
  }
}