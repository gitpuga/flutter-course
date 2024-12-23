import 'package:flutter/material.dart';
import 'package:task_6/mocks/profile.dart';
import 'package:task_6/models/profile.dart';
import 'package:task_6/pages/edit_profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileModel _profile;

  @override
  void initState() {
    super.initState();
    _profile = profile;
  }

  void _updateProfile(ProfileModel newProfile) {
    setState(() {
      _profile = newProfile;
      profile = newProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Мой профиль",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 48, 48, 48),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 200,
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 12,
                  ),
                ),
                child: SvgPicture.network(
                  'https://www.svgrepo.com/show/374012/pug.svg',
                  width: 20,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _profile.name,
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _profile.email,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _profile.phone,
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 240,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          oldProfile: _profile,
                          onProfileCreated: (ProfileModel newProfile) {
                            _updateProfile(newProfile);
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                  child: const Text(
                    'Редактировать',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
