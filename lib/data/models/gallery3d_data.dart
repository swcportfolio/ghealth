
class Gallery3dData {
 late String title;
 late String subTitle;
 late String address;
 late String imagePath;
 late double dialogHeight;
 late Uri uri;
 late GalleryType galleryType;

 Gallery3dData(
     this.title,
     this.subTitle,
     this.address,
     this.imagePath,
     this.dialogHeight,
     this.uri,
     this.galleryType);
}

enum GalleryType {
  card1,
  card2,
  card3,
}