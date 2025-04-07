import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Collection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выберите экран')),
      body: ListView(
        children: [
          _buildListTile(context, 'Popular Menu', PopularMenuScreen()),
          _buildListTile(context, 'Course Details', CourseDetailsScreen()),
          _buildListTile(context, 'E-Wallet', EWalletScreen()),
          _buildListTile(context, 'Event Organizer', EventOrganizerScreen()),
          _buildListTile(context, 'Meditate', MeditateScreen()),
        ],
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}

// 1. Popular Menu Screen
class PopularMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('21 Light Popular Menu'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('9:41'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildMenuItem('Original Salad', 'Lovy Food', '\$8'),
              _buildMenuItem('Fresh Salad', 'Cloudy Resto', '\$10'),
              _buildMenuItem('Yummie Ice Cream', 'Circlo Resto', '\$6'),
              _buildMenuItem('Vegan Special', 'Haty Food', '\$11'),
              _buildMenuItem('Mixed Pasta', 'Recto Food', '\$13'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, String restaurant, String price) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(restaurant),
          trailing: Text(
            price,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Divider(),
      ],
    );
  }
}

// 2. Course Details Screen
class CourseDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('20_Light_Course Details'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('9:41'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text('4.569'),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.amber),
                  Text('4.9'),
                  SizedBox(width: 10),
                  Chip(
                    label: Text('Best Seller'),
                    backgroundColor: Colors.blue[50],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '3D Design Basic',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'In this course you will learn how to build a space to a 3-dimensional product. There are 24 premium learning videos for you.',
              ),
              Divider(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '24 Lessons (20 hours)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See all'),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                title: Text('Introduction to 3D'),
                trailing: Text('20 mins'),
              ),
              Divider(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Enroll - \$24.99', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. E-Wallet Screen
class EWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My E-Wallet'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Andrew Ainsley',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('********** 3629'),
              Divider(height: 30),
              Text(
                'Your balance',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '\$9,379',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Divider(height: 30),
              Text(
                'Transaction History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildTransactionItem('Lawson Chair', 'Dec 15, 2024 | 10:00 AM'),
              _buildTransactionItem('Top Up Wallet', 'Dec 14, 2024 | 16:42 PM'),
              _buildTransactionItem('Parabolic Reflector', 'Dec 14, 2024 | 11:39 AM'),
              _buildTransactionItem('Mini Wooden Table', 'Dec 13, 2024 | 14:46 PM'),
              _buildTransactionItem('Top Up Wallet', 'Dec 12, 2024 | 09:27 AM'),
              Divider(height: 30),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.credit_card),
                label: Text('VISA'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Top Up'),
              ),
              Divider(height: 30),
              TextButton(
                onPressed: () {},
                child: Text('See All'),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildAmountChip('\$120', 'Orders'),
                  _buildAmountChip('\$400', 'Top Up'),
                  _buildAmountChip('\$170', 'Orders'),
                  _buildAmountChip('\$165', 'Orders'),
                  _buildAmountChip('\$300', 'Top Up'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(date),
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildAmountChip(String amount, String label) {
    return Chip(
      label: Column(
        children: [
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(label),
        ],
      ),
    );
  }
}

// 4. Event Organizer Screen
class EventOrganizerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('43.Light_organizer of event about'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('8:41'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Albert Flores',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('Organizer'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Followers', style: TextStyle(color: Colors.grey)),
                      Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Following', style: TextStyle(color: Colors.grey)),
                      Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Events', style: TextStyle(color: Colors.grey)),
                      Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Follow'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Messages'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Events',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              TextButton(
                onPressed: () {},
                child: Text('Read more...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. Meditate Screen
class MeditateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mind Deep Relax',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'A Game Community as we project over 33 days to relax and help you make mind and happiness session across the World.',
              ),
              Divider(height: 30),
              Text(
                'Diagrams',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Play Next Session'),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: 20),
              _buildSessionItem('Sweet Memories', 'December 27 Feb, March'),
              _buildSessionItem('A Day Dream', 'December 27 Mar, March'),
              _buildSessionItem('Mind Explore', 'December 27 Feb, March'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionItem(String title, String date) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(date),
          trailing: Text('+++'),
        ),
        Divider(),
      ],
    );
  }
}