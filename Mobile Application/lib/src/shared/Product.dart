class Product
{
  String name,
        price,
        image;
  bool userLiked;
  String discount;

  Product({
    this.name,
    this.price,
    this.discount,
    this.image,
    this.userLiked
  });

  Map toJson() => {"name": name, "price": price, "image":image , "userLiked":userLiked , "discount":discount };

}