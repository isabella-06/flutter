import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Recuperar el valor d''un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: <Widget>[

              TextField( 
              controller: myController,
              ),

              Spacer(),

              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Simple Dialog'),
                          children: [
                            SimpleDialogOption(
                                child: Text(myController.text),
                            ),
                          ],
                        );
                      },
                  );
                },
                  child: const Text('Simple Dialog'),
              ),

              const SizedBox(height: 20),

              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Alert Dialog'),
                          content: Text(myController.text),
                          actions: [  
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            )
                          ],
                        );
                      },
                  );
                },
                  child: const Text('Alert Dialog'),
              ),
            
              const SizedBox(height: 20),

              OutlinedButton(
                onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                      content: Text(myController.text),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }, 
                child: Text('SnackBar'), 
              ),

              const SizedBox(height: 20),

              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(myController.text),
                                ElevatedButton(
                                  child: const Text('Close'),
                                  onPressed:() => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                  );
                },
                child: const Text('Modal Bottom Sheet'),
              ),

              Spacer(),
            ]
          ),
      ),
    );
  }
}
