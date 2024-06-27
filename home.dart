import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plannerapp/authentication/admin.dart';

import 'package:plannerapp/authentication/login.dart';
import 'package:plannerapp/chatbot/chat.dart';

import 'package:plannerapp/home/home_card.dart';
import 'package:plannerapp/home/rsvp.dart';

import 'package:plannerapp/vendors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current Index Var
  int currentPage = 0;

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Navigate to the login screen after signing out
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      log('Error signing out');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 137, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
          IconButton(
            // Add this IconButton for admin login
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              // Navigate to the admin login screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLoginPage()));
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: const [
          HomeScreenCard(
            categoryName: 'Venues',
            vendorName: 'Hotel Mariot',
            location: 'Colombo',
            imageUrl:
                'https://d3a2q5al71qg9.cloudfront.net/sites/2/2021/01/3-5.jpg',
            /*onTap: () {
              // Navigate to the venues screen
             Navigator.pushNamed(context, '/VenuVendor');
            },*/
          ),
          SizedBox(height: 16),
          HomeScreenCard(
            categoryName: 'Photography',
            vendorName: 'Dark Room Photography',
            location: 'Colombo',
            imageUrl:
                'https://marielloydphotography.co.uk/wp-content/uploads/2019/04/WJJ-495.jpg',
            /*onTap: () {
              // Navigate to the photography screen
              Navigator.pushNamed(context, '/photography');
            },*/
          ),
          SizedBox(height: 16),
          HomeScreenCard(
            categoryName: 'Wedding Attire',
            vendorName: 'CK Fashion',
            location: 'Colombo',
            imageUrl:
                'https://i.pinimg.com/originals/1a/a2/55/1aa2552277fb3ac7643456a55f6d1e0f.jpg',
            /*onTap: () {
              // Navigate to the photography screen
              Navigator.pushNamed(context, '/photography');
            },*/
          ),
          SizedBox(height: 16),
          HomeScreenCard(
            categoryName: 'Florist',
            vendorName: 'Lassana Weddings',
            location: 'Colombo 7',
            imageUrl:
                'https://lassanaweddings.com/cdn-cgi/image/width=6000,quality=100/assets/images/gallery5.jpg',
            /*onTap: () {
              // Navigate to the photography screen
              Navigator.pushNamed(context, '/photography');
            },*/
          ),
          SizedBox(height: 16),
          HomeScreenCard(
            categoryName: 'Bridal Salon',
            vendorName: 'Wedding angel bridal botique',
            location: 'Colombo',
            imageUrl:
                'https://d397bfy4gvgcdm.cloudfront.net/192098-599A1195-orig.jpeg',
            /*onTap: () {
              // Navigate to the photography screen
              Navigator.pushNamed(context, '/photography');
            },*/
          ),
          SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() {
            currentPage = value;
          });
          // Perform navigation based on the selected item
          switch (value) {
            case 0:
              // Navigate to HomeScreen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
              break;
            case 1:
              // Navigate to ChatBot screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatBot(
                            messages: [],
                          )));
              break;
            case 2:
              // Navigate to RSVPScreen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GuestListScreen()));
              break;
            case 3:
              // Navigate to VendorListScreen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VendorListView()));
              break;
          }
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: "Chat",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_invitation_outlined),
            label: "Planning",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: "Vendors",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

/*Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: "Search Vendors",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),*/