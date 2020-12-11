import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/pages/transaction_form.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TransferListState {
  const TransferListState();
}

@immutable
class LoadingTransferListState extends TransferListState {
  const LoadingTransferListState();
}

@immutable
class LoadedTransferListState extends TransferListState {
  final List<Contact> contactList;
  const LoadedTransferListState(this.contactList);
}

@immutable
class FatalErrorContactListState extends TransferListState {
  const FatalErrorContactListState();
}

@immutable
class InitContactListState extends TransferListState {
  const InitContactListState();
}

class TransferListCubit extends Cubit<TransferListState> {
  TransferListCubit() : super(InitContactListState());

  void reload(ContactDao contactDao) async {
    emit(LoadingTransferListState());
    List<Contact> contactList = await contactDao.getAll();
    emit(LoadedTransferListState(contactList));
  }
}

class TransferListContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ContactDao contactDao = ContactDao();
    return BlocProvider<TransferListCubit>(
      create: (context) {
        final cubit = TransferListCubit();
        cubit.reload(contactDao);
        return cubit;
      },
      child: TransferList(contactDao: contactDao),
    );
  }
}

class TransferList extends StatelessWidget {
  final ContactDao contactDao;

  const TransferList({Key key, this.contactDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: BlocBuilder<TransferListCubit, TransferListState>(
        builder: (BuildContext context, TransferListState state) {
          if(state is InitContactListState || state is LoadingTransferListState) {
            return ProgressIndicatorWidget();
          }
          if(state is LoadedTransferListState) {
            return _buildcontactList(state.contactList);
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContact(context),
        child: Icon(Icons.add),
      ),
    );
        
  }

  Widget _buildcontactList(List<Contact> contactList) {
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        final Contact contact = contactList[index];
        print('contact: ${contact.toJson()}');

        return ContactTile(
          contact: contact,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TransactionForm(contact: contact))
            );
          },
        );
      },
    );
  }

  void _addContact(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ContactForm())
    );

    context.read<TransferListCubit>().reload(contactDao);
  } 
}
