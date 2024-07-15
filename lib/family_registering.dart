import 'package:family_reg/database_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class FamilyRegistering extends StatefulWidget {
  const FamilyRegistering({super.key});

  @override
  _FamilyRegisteringState createState() => _FamilyRegisteringState();
}

class _FamilyRegisteringState extends State<FamilyRegistering> {
  final _formKey = GlobalKey<FormState>();
  final _databaseHelper = DatabaseHelper();

  String _familyName = '';
  String _familyRelation = '';
  String _familyHeadID = '';
  String _familyHeadName = '';
  String _familyHeadAge = '';
  String _familyHeadOccupation = '';
  String _familyHeadGrossMonthlyIncome = '';
  String _familyHeadMobileNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Registering'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Household Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family Household Number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family Address!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyRelation = value!;
                  },
                ),
                const SizedBox(height: 48.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head ID!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadID = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head name!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadName = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head age!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadAge = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Occupation',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head occupation!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadOccupation = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Gross Monthly Income',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head gross monthly income!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadGrossMonthlyIncome = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Mobile Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the family head mobile number!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _familyHeadMobileNumber = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await _saveFamilyData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Family data saved successfully!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      // Navigate to the FamilyDataScreen
                      Navigator.pushNamed(context, '/family-data');
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveFamilyData() async {
    final familyData = {
      'name': _familyName,
      'relation': _familyRelation,
      'head_id': _familyHeadID,
      'head_name': _familyHeadName,
      'head_age': _familyHeadAge,
      'head_occupation': _familyHeadOccupation,
      'head_gross_monthly_income': _familyHeadGrossMonthlyIncome,
      'head_mobile_number': _familyHeadMobileNumber
    };
    try {
      await _databaseHelper.insertFamily(familyData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Family data saved successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
      // Navigate to the FamilyDataScreen
      Navigator.pushNamed(context, '/family-data');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving family data: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
      if (kDebugMode) {
        print('Error saving family data: $e');
      }
    }
  }
}
