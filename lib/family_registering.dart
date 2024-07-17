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
  String _familyHeadGender = 'Male';

  String _educationLevel =
      'No Schooling'; // Add a state variable to hold the selected education level

  // List of education levels
  final List<String> _educationLevels = [
    'No Schooling',
    'Grade 1-5',
    'Passed Grade 5',
    'Grade 6-11',
    'O/L',
    'Passed O/L',
    'A/L',
    'Passed A/L',
    'Undergraduate',
    'Graduated',
  ];

  String _occupationType =
      'Unemployed'; // Add a state variable to hold the selected occupation type

  // List of occupation types
  final List<String> _occupationTypes = [
    'Unemployed',
    'Self-employed',
    'Government',
    'Private',
    'Semi-Government',
    'Corperations'
        'Retired',
  ];

  bool _isReceivingAid =
      false; // Add a state variable to track the aid checkbox
  String _aidDescription =
      ''; // Add a state variable to hold the aid description

  void _handleGenderChange(String? value) {
    setState(() {
      _familyHeadGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Registering'),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage),
            onPressed: () {
              // Navigate to the FamilyDataScreen
              Navigator.pushNamed(context, '/family-data');
            },
          ),
        ],
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
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                const SizedBox(height: 48.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gender',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: _familyHeadGender,
                          onChanged: _handleGenderChange,
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _familyHeadGender,
                          onChanged: _handleGenderChange,
                        ),
                        const Text(
                          'Female',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Age',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                const SizedBox(height: 32.0),
                const Text(
                  'Education Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, // Change this to your desired color
                  ),
                ),
                Column(
                  children: _educationLevels.map((level) {
                    return RadioListTile(
                      title: Text(
                        level,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: level,
                      groupValue: _educationLevel,
                      onChanged: (value) {
                        setState(() {
                          _educationLevel = value as String;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  'Education Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, // Change this to your desired color
                  ),
                ),
                Column(
                  children: _occupationTypes.map((level) {
                    return RadioListTile(
                      title: Text(
                        level,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: level,
                      groupValue: _occupationType,
                      onChanged: (value) {
                        setState(() {
                          _occupationType = value as String;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Family Head Occupation',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                      labelText: 'Family Head Gross Monthly Income (Rs)',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
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
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    errorStyle: TextStyle(
                      color: Colors.red, // Set your desired color here
                    ),
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
                const SizedBox(height: 32.0),
                CheckboxListTile(
                  title: const Text(
                    'Family Head received any aid currently?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  value: _isReceivingAid,
                  onChanged: (value) {
                    setState(() {
                      _isReceivingAid = value!;
                    });
                  },
                ),
                if (_isReceivingAid)
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Family Head Aid Description',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        errorStyle: TextStyle(
                          color: Colors.red, // Set your desired color here
                        ),
                        contentPadding: EdgeInsets.only(top: 30)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the aid description!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _aidDescription = value!;
                    },
                  ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await _saveFamilyData();

                      // Clear the form fields
                      _formKey.currentState!.reset();
                      setState(() {
                        _familyName = '';
                        _familyRelation = '';
                        _familyHeadID = '';
                        _familyHeadName = '';
                        _familyHeadAge = '';
                        _familyHeadOccupation = '';
                        _familyHeadGrossMonthlyIncome = '';
                        _familyHeadMobileNumber = '';
                        _familyHeadGender = '';
                        _educationLevel = '';
                        _occupationType = '';
                        _isReceivingAid = false;
                        _aidDescription = '';
                      });

                      // Navigate to the FamilyDataScreen
                      Navigator.pushNamed(context, '/family-data');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 19.0),
                  ),
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
      'head_mobile_number': _familyHeadMobileNumber,

      'head_gender': _familyHeadGender,
      'head_education_level': _educationLevel,
      'head_occupation_type': _occupationType,
      'is_family_head_recieved_aid':
          _isReceivingAid ? true : false, // Storing boolean as integer
      'head_recieved_aid_description': _aidDescription,
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
