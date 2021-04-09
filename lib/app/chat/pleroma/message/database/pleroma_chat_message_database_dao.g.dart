// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pleroma_chat_message_database_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ChatMessageDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbChatMessagesTable get dbChatMessages => attachedDatabase.dbChatMessages;
  Selectable<DbChatMessage> findById(int? id) {
    return customSelect('SELECT * FROM db_chat_messages WHERE id = :id;',
        variables: [Variable<int?>(id)],
        readsFrom: {dbChatMessages}).map(dbChatMessages.mapFromRow);
  }

  Selectable<DbChatMessage> findByRemoteId(String remoteId) {
    return customSelect(
        'SELECT * FROM db_chat_messages WHERE remote_id LIKE :remoteId;',
        variables: [Variable<String>(remoteId)],
        readsFrom: {dbChatMessages}).map(dbChatMessages.mapFromRow);
  }

  Selectable<DbChatMessage> getAll() {
    return customSelect('SELECT * FROM db_chat_messages',
        variables: [],
        readsFrom: {dbChatMessages}).map(dbChatMessages.mapFromRow);
  }

  Selectable<int> countAll() {
    return customSelect('SELECT Count(*) FROM db_chat_messages;',
            variables: [], readsFrom: {dbChatMessages})
        .map((QueryRow row) => row.readInt('Count(*)'));
  }

  Selectable<int> countById(int? id) {
    return customSelect('SELECT COUNT(*) FROM db_chat_messages WHERE id = :id;',
            variables: [Variable<int?>(id)], readsFrom: {dbChatMessages})
        .map((QueryRow row) => row.readInt('COUNT(*)'));
  }

  Future<int> deleteById(int? id) {
    return customUpdate(
      'DELETE FROM db_chat_messages WHERE id = :id;',
      variables: [Variable<int?>(id)],
      updates: {dbChatMessages},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteByRemoteId(String remoteId) {
    return customUpdate(
      'DELETE FROM db_chat_messages WHERE remote_id = :remoteId;',
      variables: [Variable<String>(remoteId)],
      updates: {dbChatMessages},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> clear() {
    return customUpdate(
      'DELETE FROM db_chat_messages',
      variables: [],
      updates: {dbChatMessages},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<DbChatMessage> oldest() {
    return customSelect(
        'SELECT * FROM db_chat_messages ORDER BY created_at ASC LIMIT 1;',
        variables: [],
        readsFrom: {dbChatMessages}).map(dbChatMessages.mapFromRow);
  }

  Selectable<int?> findLocalIdByRemoteId(String remoteId) {
    return customSelect(
        'SELECT id FROM db_chat_messages WHERE remote_id = :remoteId;',
        variables: [Variable<String>(remoteId)],
        readsFrom: {dbChatMessages}).map((QueryRow row) => row.readInt('id'));
  }

  Future<int> deleteOlderThanDate(DateTime createdAt) {
    return customUpdate(
      'DELETE FROM db_chat_messages WHERE created_at < :createdAt',
      variables: [Variable<DateTime>(createdAt)],
      updates: {dbChatMessages},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteOlderThanLocalId(int? localId) {
    return customUpdate(
      'DELETE FROM db_chat_messages WHERE id = :localId;',
      variables: [Variable<int?>(localId)],
      updates: {dbChatMessages},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<DbChatMessage> getNewestByLocalIdWithOffset(int offset) {
    return customSelect(
        'SELECT * FROM db_chat_messages ORDER BY id DESC LIMIT 1 OFFSET :offset',
        variables: [Variable<int>(offset)],
        readsFrom: {dbChatMessages}).map(dbChatMessages.mapFromRow);
  }
}
