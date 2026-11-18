
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';
import 'package:image/image.dart' as img;
void main() {
  runApp(const AIMagicStudio());
}

class AIMagicStudio extends StatelessWidget {
  const AIMagicStudio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Magic Studio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100D20),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B5CFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    EffectsPage(),
    ProjectsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1C1730),
        indicatorColor: const Color(0xFF6840A8),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'Effects',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome,
                  color: Color(0xFFB77CFF), size: 32),
              SizedBox(width: 10),
              Text(
                'AI Magic Studio',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.notifications_none, size: 27),
            ],
          ),
          const SizedBox(height: 28),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7136C8),
                  Color(0xFF30205D),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CREATE WITHOUT LIMITS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your AI Creative Studio',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Turn your imagination into reality.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => message(
                    context, 'AI Studio is coming soon!',
                  ),
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Explore AI Studio'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
          const Text(
            'Create Something Amazing',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: FeatureCard(
                  title: 'AI Photo Editor',
                  subtitle: 'Edit your photos',
                  icon: Icons.image,
                  color: const Color(0xFF8B54E8),
                  onTap: () => message(
                    context, 'Photo Editor coming soon!',
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: FeatureCard(
                  title: 'AI Video Editor',
                  subtitle: 'Create amazing videos',
                  icon: Icons.video_library,
                  color: const Color(0xFFE04F9B),
                  onTap: () => message(
                    context, 'Video Editor coming soon!',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: FeatureCard(
                  title: 'AI Effects',
                  subtitle: 'Magic effects',
                  icon: Icons.auto_awesome,
                  color: const Color(0xFF278CCB),
                  onTap: () => message(
                    context, 'AI Effects coming soon!',
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: FeatureCard(
                  title: 'Background',
                  subtitle: 'Remove & change',
                  icon: Icons.wallpaper,
                  color: const Color(0xFF249D83),
                  onTap: () => message(
                    context, 'Background tools coming soon!',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),
          const Text(
            'Quick Tools',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          ListTile(
            leading: const Icon(Icons.photo_library,
                color: Color(0xFFB77CFF)),
            title: const Text('Photo Gallery'),
            subtitle: const Text('Choose photos from your device'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => message(
              context, 'Gallery picker will be added next.',
            ),
          ),

          ListTile(
            leading: const Icon(Icons.movie_creation,
                color: Color(0xFFE04F9B)),
            title: const Text('Video Creation'),
            subtitle: const Text('Create videos with AI tools'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => message(
              context, 'Video tools will be added next.',
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF211B35),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EffectsPage extends StatelessWidget {
  const EffectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'AI Effects',
      subtitle: 'Discover creative AI effects',
      icon: Icons.auto_awesome,
      items: [
        'AI Portrait',
        'Cartoon Effect',
        'Cinematic Effect',
        'Background Blur',
        'AI Beauty',
        'Photo Animation',
      ],
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'My Projects',
      subtitle: 'Your saved creations will appear here.',
      icon: Icons.folder_open,
      items: [],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePage(
      title: 'My Profile',
      subtitle: 'Welcome to AI Magic Studio',
      icon: Icons.account_circle,
      items: [
        'Account Settings',
        'App Settings',
        'Privacy Policy',
        'About Us',
      ],
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> items;

  const SimplePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 65, color: Colors.white38),
                        const SizedBox(height: 12),
                        const Text('No projects yet'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
  color: const Color(0xFF211B35),
  child: ListTile(
    leading: Icon(icon, color: Color(0xFFB77CFF)),
    title: Text(items[index]),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EffectDetailPage(
            title: items[index],
          ),
        ),
      );
    },
  ),
);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}


class EffectDetailPage extends StatefulWidget {
  final String title;

  const EffectDetailPage({
    super.key,
    required this.title,
  });

  @override
  State<EffectDetailPage> createState() =>
      _EffectDetailPageState();
}

class _EffectDetailPageState extends State<EffectDetailPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (image != null && mounted) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _applyEffect(String effect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$effect AI processing will be added soon!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effects = [
      'AI Portrait',
      'Cartoon Effect',
      'Background Remove',
      'Background Blur',
      'AI Beauty',
      'Photo Animation',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF100D20),
      ),
      backgroundColor: const Color(0xFF100D20),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(_selectedImage!.path),
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              )
            else
              const Icon(
                Icons.add_a_photo,
                size: 90,
                color: Colors.white54,
              ),

            const SizedBox(height: 20),

            Text(
              _selectedImage == null
                  ? 'Select Your Photo'
                  : 'Photo Selected Successfully!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload),
                label: const Text('Select Photo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CFF),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Your Effect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: effects.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.7,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: _selectedImage == null
                      ? null
                      : () => _applyEffect(effects[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF29213F),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFF29213F),
                  ),
                  child: Text(
                    effects[index],
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
