class Contact {
  final int id;
  final String name;
  final int account;

  Contact(this.id, this.name, this.account);

  Contact.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      account = json['account'];

  Map<String, dynamic> toJsonWithoutId() => {
    'name': name,
    'account': account,
  };

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'account': account,
  };
}