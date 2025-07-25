import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStoriesSection(),
            _buildFilterTabs(),
            _buildPost(
              userName: "David Morel",
              userImage: "assets/images/user1.png",
              postImage: "assets/images/post1.png",
              caption: "The game in Japan was amazing and I want to share some photos.",
              views: "30",
              arViews: "45",
              comments: "77",
              likes: "craig_love and 44,685 others",
            ),
            _buildPost(
              userName: "David Morel",
              userImage: "assets/images/user1.png",
              postImage: "assets/images/post2.png",
              caption: "The game in Japan was amazing and I want to share some photos.",
              views: "20",
              arViews: "40",
              comments: "58",
              likes: "craig_love and 44,685 others",
            ),
            _buildSponsoredPost(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Ai", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: const [
        Icon(Icons.favorite_border, color: Colors.black),
        SizedBox(width: 16),
        Icon(Icons.send, color: Colors.black),
        SizedBox(width: 12),
      ],
    );
  }

  Widget _buildStoriesSection() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("assets/images/user${index % 3 + 1}.jpg"),
                ),
                const SizedBox(height: 4),
                Text("User ${index + 1}", style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ["Live", "Popular", "Following", "3D Art", "Animation"];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: filters.map((filter) {
          final isActive = filter == "Popular";
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.red : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              filter,
              style: TextStyle(color: isActive ? Colors.white : Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPost({
    required String userName,
    required String userImage,
    required String postImage,
    required String caption,
    required String views,
    required String arViews,
    required String comments,
    required String likes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(userImage)),
          title: Text(userName),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text("Follow"),
          ),
        ),
        Image.asset(postImage, width: double.infinity, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _buildViewType("AR View", arViews),
              const SizedBox(width: 20),
              _buildViewType("3D View", views),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: const [
              Icon(Icons.favorite_border),
              SizedBox(width: 16),
              Icon(Icons.comment_outlined),
              SizedBox(width: 16),
              Icon(Icons.send),
              Spacer(),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text("Liked by $likes", style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("joshua_l $caption"),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSponsoredPost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text("TV", style: TextStyle(color: Colors.white)),
          ),
          title: Text("TVSVehicles", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Sponsored"),
          trailing: Icon(Icons.more_vert),
        ),
        Image.asset("assets/images/post3.png", width: double.infinity, fit: BoxFit.cover),
      ],
    );
  }

  Widget _buildViewType(String label, String count) {
    return Row(
      children: [
        const Icon(Icons.visibility, size: 18),
        const SizedBox(width: 4),
        Text("$count View", style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
