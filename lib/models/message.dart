class Message{
 final String message;
 final String id;
 final String name;
  Message(this.message, this.id,this.name);

 factory Message.fromJson(jsonData){
 return Message(jsonData['message'],jsonData['id'],jsonData['name']);
}
}