class Comic{
  late String id;
  late String title;
  late String description;
  late String image;
  late String character_list;
  Comic(this.id,this.title,this.description,this.image,this.character_list);
}
class Character{
  late String name="";
  late String id = "";
  late String description = "";
  late String image = "";
  late List<String> comic_list = [""];

}