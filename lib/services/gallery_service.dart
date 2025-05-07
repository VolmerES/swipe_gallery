import 'package:photo_manager/photo_manager.dart';

class GalleryService {
  // TODO: Solicita permiso al usuario para acceder a las fotos
  static Future<bool> requestPermission() async {
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    return result.isAuth; // TODO: Retorna true si el usuario dio acceso
  }

  // TODO: Obtiene todas las fotos del dispositivo
  static Future<List<AssetEntity>> loadAllImages() async {
    // TODO: Obtiene álbumes que contienen imágenes
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image, // Solo imágenes
      hasAll: true,            // Incluye "Todas las fotos"
    );

    if (albums.isEmpty) return [];

    // TODO: Carga hasta 1000 imágenes del álbum principal
    final List<AssetEntity> photos = await albums[0].getAssetListPaged(
      page: 0,
      size: 1000,
    );

    return photos;
  }
}
