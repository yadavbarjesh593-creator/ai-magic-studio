import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const AiMagicStudioApp());

const Color bg = Color(0xFF100D1C);
const Color panel = Color(0xFF211B35);
const Color purple = Color(0xFF8B5CF6);
const Color pink = Color(0xFFEC4899);

class AiMagicStudioApp extends StatelessWidget {
  const AiMagicStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Magic Studio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const StudioHome(),
    );
  }
}

class StudioHome extends StatefulWidget {
  const StudioHome({super.key});

  @override
  State<StudioHome> createState() => _StudioHomeState();
}

class _StudioHomeState extends State<StudioHome> {
  int tab = 0;
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> chooseImage() async {
    try {
      final XFile? result = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
      );
      if (result != null && mounted) {
        setState(() => selectedImage = File(result.path));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo selected successfully')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open gallery: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      effectsPage(),
      projectsPage(),
      profilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF191428),
        indicatorColor: purple.withOpacity(.25),
        selectedIndex: tab,
        onDestinationSelected: (value) => setState(() => tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Effects'),
          NavigationDestination(icon: Icon(Icons.folder_open_outlined), selectedIcon: Icon(Icons.folder), label: 'Projects'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget homePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text('AI Magic Studio', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
            ),
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.workspace_premium, color: Color(0xFFFFC857)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF39235F), Color(0xFF251A42), Color(0xFF17243C)]),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Something Amazing ✨', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 7),
              Text('AI-powered photo & video editing', style: TextStyle(color: Colors.white.withOpacity(.72))),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: chooseImage,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Choose Photo'),
                  style: FilledButton.styleFrom(backgroundColor: purple, padding: const EdgeInsets.symmetric(vertical: 15)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (selectedImage != null) ...[
          const Text('Selected Photo', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.file(selectedImage!, height: 210, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 18),
        ],
        const Text('Create with AI', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.45,
          children: [
            featureCard(Icons.image_outlined, 'Photo Editor', 'Crop, filters & enhance', chooseImage),
            featureCard(Icons.movie_creation_outlined, 'Video Editor', 'Edit short videos', () => showComingSoon('Video Editor')),
            featureCard(Icons.auto_awesome, 'AI Effects', 'Cinematic & creative looks', () => setState(() => tab = 1)),
            featureCard(Icons.video_camera_back_outlined, 'Photo to Video', 'Animate your photos', () => showComingSoon('Photo to Video')),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Popular styles', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Cinematic', 'Drone View', 'DSLR Look', 'Anime', 'AI Background', 'Devotional Art']
              .map((s) => Chip(label: Text(s), backgroundColor: panel, side: BorderSide.none))
              .toList(),
        ),
      ],
    );
  }

  Widget effectsPage() {
    final effects = [
      ['Cinematic Portrait', Icons.movie_filter_outlined],
      ['Drone View', Icons.flight_outlined],
      ['DSLR Look', Icons.camera_alt_outlined],
      ['Anime Style', Icons face_retouching_natural],
      ['AI Background', Icons.wallpaper_outlined],
      ['Devotional Art', Icons.temple_hindu_outlined],
    ];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('AI Effects ✨', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Choose a style to get started.', style: TextStyle(color: Colors.white.withOpacity(.65))),
        const SizedBox(height: 18),
        ...effects.map((item) => Card(
          color: panel,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: purple.withOpacity(.2), child: Icon(item[1] as IconData, color: Colors.white)),
            title: Text(item[0] as String),
            subtitle: const Text('AI service connection required'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showComingSoon(item[0] as String),
          ),
        )),
      ],
    );
  }

  Widget projectsPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.folder_open, size: 64, color: purple),
            const SizedBox(height: 14),
            const Text('My Projects', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(selectedImage == null ? 'Your edited projects will appear here.' : 'A photo is selected. Project saving will be added in the next version.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.65))),
            const SizedBox(height: 18),
            OutlinedButton.icon(onPressed: chooseImage, icon: const Icon(Icons.add), label: const Text('Choose a Photo')),
          ],
        ),
      ),
    );
  }

  Widget profilePage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        const CircleAvatar(radius: 38, backgroundColor: panel, child: Icon(Icons.person, size: 42)),
        const SizedBox(height: 12),
        const Center(child: Text('Guest User', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
        const Center(child: Text('Free plan', style: TextStyle(color: Colors.white70))),
        const SizedBox(height: 24),
        Card(color: panel, child: const ListTile(leading: Icon(Icons.language), title: Text('Language'), subtitle: Text('Hindi / English'))),
        Card(color: panel, child: const ListTile(leading: Icon(Icons.privacy_tip_outlined), title: Text('Privacy'), subtitle: Text('Your photos should stay under your control'))),
        Card(color: panel, child: const ListTile(leading: Icon(Icons.info_outline), title: Text('About'), subtitle: Text('AI Magic Studio — Starter Version'))),
      ],
    );
  }

  Widget featureCard(IconData icon, String title, String subtitle, VoidCallback action) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withOpacity(.05))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFC4A7FF), size: 27),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(.6))),
          ],
        ),
      ),
    );
  }

  void showComingSoon(String feature) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: panel,
        title: Text(feature),
        content: const Text('This feature is planned for the next version. AI processing is not connected yet.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}