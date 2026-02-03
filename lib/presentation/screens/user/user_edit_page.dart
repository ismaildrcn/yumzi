import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumzi/data/models/entity/user_entity.dart';
import 'package:yumzi/data/models/enums/user_gender.dart';
import 'package:yumzi/presentation/providers/user_provider.dart';
import 'package:yumzi/presentation/screens/user/gender_widget.dart';
import 'package:yumzi/presentation/widgets/message_box.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({super.key});

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  UserGender? selectedGender;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        context.read<UserProvider>().fetchUser();
        _isInitialized = true;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (userProvider.errorMessage != null) {
                  return Center(
                    child: Text('Error: ${userProvider.errorMessage}'),
                  );
                } else {
                  loadUserFromProvider(userProvider);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(150),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: IconButton(
                              iconSize: 28,
                              icon: Icon(Icons.chevron_left_sharp),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Text("Edit Profile", style: TextStyle(fontSize: 17)),
                        ],
                      ),

                      Container(
                        width: 130,
                        height: 130,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondary.withAlpha(150),
                          borderRadius: BorderRadius.circular(65),
                        ),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            iconSize: 20,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // TODO: Implement edit avatar functionality
                            },
                          ),
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                          TextField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(32),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(128),
                              ),
                              errorText: userProvider.getFieldError('fullName'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(32),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(128),
                              ),
                              errorText: userProvider.getFieldError('email'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                          TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(32),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(128),
                              ),
                              errorText: userProvider.getFieldError(
                                'phoneNumber',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            "Birth of Date",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),

                          TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              filled: true,
                              fillColor: Theme.of(
                                context,
                              ).colorScheme.onSecondary.withAlpha(32),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(128),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffix: SizedBox(
                                width: 20,
                                height: 20,
                                child: GestureDetector(
                                  onTap: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(1990, 1, 1),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                    if (picked != null) {
                                      _birthDateController.text =
                                          '${picked.month}/${picked.day}/${picked.year}';
                                    }
                                  },
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 20,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary.withAlpha(128),
                                  ),
                                ),
                              ),
                            ),
                            controller: _birthDateController,
                          ),
                        ],
                      ),

                      SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                          GenderWidget(
                            selectedGender: selectedGender!,
                            onGenderChanged: (gender) {
                              setState(() {
                                selectedGender = gender;
                              });
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => updateUserProfile(userProvider),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width,
                            56,
                          ),
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('SAVE'),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void loadUserFromProvider(UserProvider userProvider) {
    final user = userProvider.user;
    if (user != null && !_isInitialized) {
      selectedGender = user.gender ?? UserGender.male;
      _emailController.text = user.email;
      _fullNameController.text = user.fullName;
      _phoneNumberController.text = user.phoneNumber ?? 'N/A';
      _birthDateController.text = user.birthOfDate != null
          ? user.birthOfDate!.toLocal().toString().split(' ')[0]
          : '';
      _isInitialized = true;
    }
  }

  void updateUserProfile(UserProvider userProvider) async {
    final user = userProvider.user;
    if (user == null) {
      MessageBox.error(context, "User data is not available.");
      return;
    }
    if (user.fullName == _fullNameController.text &&
        user.email == _emailController.text &&
        (user.phoneNumber ?? '') == _phoneNumberController.text &&
        (user.birthOfDate != null
                ? user.birthOfDate!.toLocal().toString().split(' ')[0]
                : '') ==
            _birthDateController.text) {
      Navigator.pop(context);
      return;
    }
    UserEntity updatedUser = UserEntity(
      uniqueId: user.uniqueId,
      email: _emailController.text,
      fullName: _fullNameController.text,
      phoneNumber: _phoneNumberController.text,
      birthOfDate: DateTime.tryParse(_birthDateController.text),
      gender: selectedGender,
      emailVerified: user.emailVerified,
      phoneNumberVerified: user.phoneNumberVerified,
    );

    UserEntity? result = await userProvider.updateUser(updatedUser);
    if (!mounted) return;

    if (result != null) {
      MessageBox.success(context, "Profile updated successfully");
      Navigator.pop(context);
    } else if (userProvider.errorMessage != null) {
      MessageBox.error(context, userProvider.errorMessage!);
    }
  }
}
