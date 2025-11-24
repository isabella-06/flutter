import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salesians Sarrià 25/26 - Isabella Gomez',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade300),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  final String title = 'Salesians Sarrià 25/26 - Isabella Gomez';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  int textFieldLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //---------------------------------------
                    // Choice Chips
                    //---------------------------------------
                    FormBuilderChoiceChips<String>(
                      name: 'choice_chips',
                      initialValue: 'Flutter',
                      decoration: InputDecoration(
                        labelText: 'Choice Chips',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      options: const [
                        FormBuilderChipOption(
                          value: 'Flutter',
                          child: Text('Flutter', style: TextStyle(fontSize: 16)),
                        ),
                        FormBuilderChipOption(
                          value: 'Android',
                          child: Text('Android', style: TextStyle(fontSize: 16)),
                        ),
                        FormBuilderChipOption(
                          value: 'Chrome OS',
                          child: Text('Chrome OS', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      selectedColor: Colors.grey[400],
                      backgroundColor: Colors.purple[300],
                      labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    const SizedBox(height: 20),

                    //---------------------------------------
                    // Switch
                    //---------------------------------------
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Switch', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          FormBuilderSwitch(
                            name: 'switch',
                            title: const Text('This is a switch'),
                            initialValue: false,
                            decoration: const InputDecoration(  
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    //---------------------------------------
                    // Text Field with validation
                    //---------------------------------------
                    FormBuilderTextField(
                      name: 'text_field',
                      onChanged: (value) {
                        setState(() {
                          textFieldLength = value?.length ?? 0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Text Field',
                        helperText: 'Value must have a length less than or ... $textFieldLength/15',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(15),
                      ]),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20),

                    //---------------------------------------
                    // Dropdown Field
                    //---------------------------------------
                    FormBuilderDropdown(
                      name: 'dropdown_field',
                      decoration: const InputDecoration(
                        labelText: 'Dropdown Field',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),

                    //---------------------------------------
                    // Radio Group
                    //---------------------------------------
                    FormBuilderRadioGroup(
                      name: 'radio_group',
                      orientation: OptionsOrientation.vertical,
                      decoration: const InputDecoration(
                        labelText: 'Radio Group Model',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      options: const [
                        FormBuilderFieldOption(value: 'option1', child: Text('Option 1')),
                        FormBuilderFieldOption(value: 'option2', child: Text('Option 2')),
                        FormBuilderFieldOption(value: 'option3', child: Text('Option 3')),
                        FormBuilderFieldOption(value: 'option4', child: Text('Option 4')),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () {
          _formKey.currentState?.save();
          final formData = _formKey.currentState?.value ?? {};
          
          String formString = '''
          Choice Chips: ${formData['choice_chips'] ?? ''}
          Switch: ${formData['switch'] ?? false}
          Text Field: ${formData['text_field'] ?? ''}
          Dropdown Field: ${formData['dropdown_field'] ?? ''}
          Radio Group: ${formData['radio_group'] ?? ''}''';
          
          alertDialog(context, formString);
        },
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Submission Completed'),
      icon: const Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}