import 'package:flutter/cupertino.dart';

class CupertinoFormExample extends StatefulWidget {
  const CupertinoFormExample({super.key});

  @override
  State<CupertinoFormExample> createState() => _CupertinoFormExampleState();
}

class _CupertinoFormExampleState extends State<CupertinoFormExample> {
  // 1. Establish the global key to manage form state validation
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  bool _agreeToTerms = false;

  void _submitForm() {
    // 2. Trigger validation across all fields
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Handle your validated data submission here
      print('Saved Username: $_username');
      print('Agreed to terms: $_agreeToTerms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Account Setup'),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey, // Attach your state key
          child: ListView(
            children: [
              // 3. Group layout elements natively using inset styling
              CupertinoFormSection.insetGrouped(
                header: const Text('PROFILE DETAILS'),
                footer: const Text('Please enter your unique system username.'),
                children: [
                  // 4. Use specialized Row fields for inline labeling and validation
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Username'),
                    placeholder: 'Required',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username cannot be blank';
                      }
                      return null;
                    },
                    onSaved: (value) => _username = value ?? '',
                  ),
                ],
              ),

              CupertinoFormSection.insetGrouped(
                header: const Text('PREFERENCES'),
                children: [
                  // 5. Wrap miscellaneous fields using CupertinoFormRow
                  CupertinoFormRow(
                    prefix: const Text('Agree to Terms'),
                    child: CupertinoSwitch(
                      value: _agreeToTerms,
                      onChanged: (bool value) {
                        setState(() {
                          _agreeToTerms = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Action Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CupertinoButton.filled(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
