import 'package:prog_lazy_f/configuration/configuration.dart'
    show Configuration;

class ImageDownloader {
  static String imageUrl(String pathSrc) {
    return Configuration.imageUrl + pathSrc;
  }
}
