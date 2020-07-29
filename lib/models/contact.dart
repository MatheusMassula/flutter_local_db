class Contact {
  final String name;
  final int account;

  Contact(this.name, this.account);

  Contact.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      account = json['account'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'account': account,
  };
}