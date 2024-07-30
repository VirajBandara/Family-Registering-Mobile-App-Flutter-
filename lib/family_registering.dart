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
  String _familyHeadGender = 'Male';
  String _familyHeadAge = '';
  String _familyHeadEducationLevel = 'No Schooling';

  // List of education levels
  final List<String> _familyHeadEducationLevels = [
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
  final List<String> _familyHeadOccupationTypes = [
    'Unemployed',
    'Self-employed',
    'Government',
    'Private',
    'Semi-Government',
    'Corperations',
    'Retired',
  ];

  String _familyHeadOccupation = '';
  String _familyHeadGrossMonthlyIncome = '';
  String _familyHeadMobileNumber = '';

  // Controller for member count input
  final _memberCountController = TextEditingController();

  int _memberCount = 0; // Track the number of family members

  bool _isReceivingAid =
      false; // Add a state variable to track the aid checkbox
  String _aidDescription =
      ''; // Add a state variable to hold the aid description

  String _idMember = '';
  String _nameMember = '';
  String _genderMember = 'Male';
  String _ageMember = '';

  String _educationLevelMember = 'No Schooling';

  // List of education levels
  final List<String> _educationLevelsMember = [
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

  String _occupationTypeMember = 'Unemployed';

  final List<String> _occupationTypesMember = [
    'Unemployed',
    'Self-employed',
    'Government',
    'Private',
    'Semi-Government',
    'Corperations',
    'Retired',
  ];

  String _occupationMember = '';
  String _grossMonthlyIncomeMember = '';
  String _mobileNumberMember = '';
  bool _isRecievedAidMember = false;
  String _recievedAidDescriptionMember = '';

  List<Map<String, dynamic>> _familyMembers =
      []; // List to store family member details

  @override
  void dispose() {
    _memberCountController.dispose();
    super.dispose();
  }

  void _handleGenderChangeFamilyHead(String? value) {
    setState(() {
      _familyHeadGender = value!;
    });
  }

  void _handleGenderChangeMember(String? value) {
    setState(() {
      _genderMember = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Family Registering',
          style: TextStyle(fontSize: 22),
        ),
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

                const Center(
                  child: Text(
                    "Family Head",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),

                const SizedBox(height: 32.0),

                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'ID',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the ID!';
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
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the name!';
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
                                  onChanged: _handleGenderChangeFamilyHead,
                                ),
                                const Text('Male'),
                                Radio<String>(
                                  value: 'Female',
                                  groupValue: _familyHeadGender,
                                  onChanged: _handleGenderChangeFamilyHead,
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
                            labelText: 'Age',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the age!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _familyHeadAge = value!;
                          },
                        ),
                        const SizedBox(height: 48.0),
                        const Text(
                          'Education Level',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors
                                .black, // Change this to your desired color
                          ),
                        ),
                        Column(
                          children: _familyHeadEducationLevels.map((level) {
                            return RadioListTile(
                              title: Text(
                                level,
                                style: const TextStyle(fontSize: 14),
                              ),
                              value: level,
                              groupValue: _familyHeadEducationLevel,
                              onChanged: (value) {
                                setState(() {
                                  _familyHeadEducationLevel = value as String;
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32.0),
                        const Text(
                          'Occupation Type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors
                                .black, // Change this to your desired color
                          ),
                        ),
                        Column(
                          children: _familyHeadOccupationTypes.map((level) {
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
                            labelText: 'Occupation',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the occupation!';
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
                            labelText: 'Gross Monthly Income',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the gross monthly income!';
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
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            errorStyle: TextStyle(
                              color: Colors.red, // Set your desired color here
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the mobile number!';
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
                            'Is receiving any Aid?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          value: _isReceivingAid,
                          onChanged: (value) {
                            setState(() {
                              _isReceivingAid = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        if (_isReceivingAid)
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Description of Aid',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              errorStyle: TextStyle(
                                color:
                                    Colors.red, // Set your desired color here
                              ),
                            ),
                            onSaved: (value) {
                              _aidDescription = value!;
                            },
                          ),

                        // Input for Number of Family Members
                        const SizedBox(height: 32.0),
                        // Card containing TextFormField and ElevatedButton
                        Card(
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Input for Number of Family Members
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _memberCountController,
                                  decoration: const InputDecoration(
                                    labelText: 'Number of Family Members',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the number of family members!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _memberCount = int.parse(value!);
                                    _familyMembers = List.generate(
                                        _memberCount, (index) => {});
                                  },
                                ),
                                const SizedBox(height: 48.0),
                                // Button to add member detail cards
                                SizedBox(
                                  width: double
                                      .infinity, // Set the width to take up the entire available width
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Confirm'),
                                            content: Text(
                                                'Do you need to add ${_memberCountController.text} other members?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    setState(() {
                                                      _familyMembers =
                                                          List.generate(
                                                              _memberCount,
                                                              (index) => {});
                                                    });
                                                  }
                                                },
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8.0),
                // Display family member detail cards
                if (_familyMembers.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      _memberCount,
                      (index) => _buildMemberCard(index),
                    ),
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
                        _familyHeadEducationLevel = '';
                        _occupationType = '';
                        _isReceivingAid = false;
                        _aidDescription = '';
                        _memberCount = 0;
                        _familyMembers = [];

                        _idMember = '';
                        _nameMember = '';
                        _ageMember = '';
                        _occupationMember = '';
                        _educationLevelMember = '';
                        _occupationTypeMember = '';
                        _grossMonthlyIncomeMember = '';
                        _mobileNumberMember = '';
                        _genderMember = '';
                        _isRecievedAidMember = false;
                        _recievedAidDescriptionMember = '';
                      });

                      // Navigate to the FamilyDataScreen
                      Navigator.pushNamed(context, '/family-data');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _saveFamilyData() async {
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
      'head_education_level': _familyHeadEducationLevel,
      'head_occupation_type': _occupationType,
      'is_family_head_recieved_aid': _isReceivingAid ? true : false,
      'head_recieved_aid_description': _aidDescription,
      'member_count': _familyMembers.length,
      'members': _familyMembers,
    };

    try {
      await _databaseHelper.insertFamily(familyData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Family data saved successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pushNamed(context, '/family-data');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving family data: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
      if (kDebugMode) {
        print('Error in saving family data: $e');
      }
    }
  }

  Widget _buildMemberCard(int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Family Member ${index + 2}',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 48.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ID',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ID!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['idMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the name!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['nameMember'] = value;
              },
            ),
            const SizedBox(height: 48.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _genderMember,
                      onChanged: _handleGenderChangeMember,
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _genderMember,
                      onChanged: _handleGenderChangeMember,
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
                labelText: 'Age',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the age!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['ageMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Relationship',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the relationship!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['relationshipMember'] = value;
              },
            ),
            const SizedBox(height: 48.0),
            const Text(
              'Education Level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black, // Change this to your desired color
              ),
            ),
            Column(
              children: _educationLevelsMember.map((level) {
                return RadioListTile(
                  title: Text(
                    level,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: level,
                  groupValue: _educationLevelMember,
                  onChanged: (value) {
                    setState(() {
                      _educationLevelMember = value as String;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Occupation Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black, // Change this to your desired color
              ),
            ),
            Column(
              children: _occupationTypesMember.map((level) {
                return RadioListTile(
                  title: Text(
                    level,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: level,
                  groupValue: _occupationTypeMember,
                  onChanged: (value) {
                    setState(() {
                      _occupationTypeMember = value as String;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Occupation',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the occupation!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['occupationMember'] = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Gross Monthly Income',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the gross monthly income!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['grossMonthlyIncomeMember'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                errorStyle: TextStyle(
                  color: Colors.red, // Set your desired color here
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the mobile number!';
                }
                return null;
              },
              onChanged: (value) {
                _familyMembers[index]['mobileNumberMember'] = value;
              },
            ),
            const SizedBox(height: 32.0),
            CheckboxListTile(
              title: const Text(
                'Is receiving any Aid?',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              value: _isRecievedAidMember,
              onChanged: (value) {
                setState(() {
                  _isRecievedAidMember = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_isRecievedAidMember)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description of Aid',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  errorStyle: TextStyle(
                    color: Colors.red, // Set your desired color here
                  ),
                ),
                onChanged: (value) {
                  _familyMembers[index]['recievedAidDescriptionMember'] = value;
                },
              ),
            const SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}
