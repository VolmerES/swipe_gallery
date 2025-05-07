import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../services/gallery_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AssetEntity> _images = [];
  List<Uint8List?> _thumbnails = [];
  List<AssetEntity> _pendingDeletion = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadImagesAndThumbnails();
  }

  Future<void> _loadImagesAndThumbnails() async {
    final hasPermission = await GalleryService.requestPermission();
    if (!hasPermission) {
      setState(() => _loading = false);
      return;
    }

    final images = await GalleryService.loadAllImages();
    final thumbnails = await Future.wait(
      images.map(
        (image) => image.thumbnailDataWithSize(const ThumbnailSize(800, 800)),
      ),
    );

    setState(() {
      _images = images;
      _thumbnails = thumbnails;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_images.isEmpty || _thumbnails.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No se encontraron imágenes')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe Gallery Cleaner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              // Aquí luego llevaremos a la pantalla de confirmación
              debugPrint('Imágenes marcadas: ${_pendingDeletion.length}');
            },
          )
        ],
      ),
      body: Center(
        child: CardSwiper(
          cardsCount: _images.length,
          numberOfCardsDisplayed: 3,
          backCardOffset: const Offset(0, 40),
          padding: const EdgeInsets.all(16),
          cardBuilder: (context, index, horizontalPercent, verticalPercent) {
            final thumb = _thumbnails[index];
            if (thumb == null) {
              return const Center(child: Text('Error al cargar miniatura'));
            }
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(thumb, fit: BoxFit.cover),
            );
          },
          onSwipe: (previousIndex, currentIndex, direction) {
            if (direction == CardSwiperDirection.left) {
              _pendingDeletion.add(_images[previousIndex]);
              debugPrint('Marcada para borrar: imagen ${previousIndex + 1}');
            }
            return true;
          },
        ),
      ),
    );
  }
}
