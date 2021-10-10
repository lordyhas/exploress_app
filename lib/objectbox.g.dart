// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes
// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'data/database/model/SettingData.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:5560782510154998477",
        "lastPropertyId": "17:7227740988057721063",
        "name": "SettingAppData",
        "properties": [
          {
            "id": "1:569991136253946938",
            "name": "isNotificationOn",
            "type": 1,
            "dartFieldType": "bool?"
          },
          {
            "id": "2:3288570092514569235",
            "name": "isSync",
            "type": 1,
            "dartFieldType": "bool?"
          },
          {
            "id": "4:5178177050901433786",
            "name": "id",
            "type": 6,
            "flags": 1,
            "dartFieldType": "int"
          },
          {
            "id": "5:4422243250954652685",
            "name": "phoneName",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "6:5820099891889995848",
            "name": "userCode",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "7:8908403977904314126",
            "name": "phoneModel",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "8:7961454477356455795",
            "name": "os",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "9:3388544037187132197",
            "name": "osVersion",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "10:1237651840878710606",
            "name": "email",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "11:3582487987767976074",
            "name": "theme",
            "type": 6,
            "dartFieldType": "int"
          },
          {
            "id": "12:2192075448493512559",
            "name": "language",
            "type": 6,
            "dartFieldType": "int"
          },
          {
            "id": "13:5236154708065849595",
            "name": "userAuthState",
            "type": 6,
            "dartFieldType": "int?"
          },
          {
            "id": "14:3277619871933652792",
            "name": "lastAuthCheck",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "15:3270478675330525529",
            "name": "location",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "16:1485367794502277469",
            "name": "createAt",
            "type": 9,
            "dartFieldType": "String?"
          },
          {
            "id": "17:7227740988057721063",
            "name": "isSyncWithMail",
            "type": 1,
            "dartFieldType": "bool?"
          }
        ],
        "relations": [],
        "backlinks": [],
        "constructorParams": [
          "isNotificationOn named",
          "isSync named",
          "isSyncWithMail named",
          "createAt named",
          "phoneName named",
          "userCode named",
          "phoneModel named",
          "email named",
          "location named",
          "os named",
          "osVersion named",
          "theme named",
          "language named",
          "userAuthState named",
          "lastAuthCheck named"
        ],
        "nullSafetyEnabled": true
      }
    ],
    "lastEntityId": "1:5560782510154998477",
    "lastIndexId": "0:0",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[SettingAppData] = EntityDefinition<SettingAppData>(
      model: model.getEntityByUid(5560782510154998477),
      toOneRelations: (SettingAppData object) => [],
      toManyRelations: (SettingAppData object) => {},
      getId: (SettingAppData object) => object.id,
      setId: (SettingAppData object, int id) {
        object.id = id;
      },
      objectToFB: (SettingAppData object, fb.Builder fbb) {
        final phoneNameOffset = object.phoneName == null
            ? null
            : fbb.writeString(object.phoneName!);
        final userCodeOffset =
            object.userCode == null ? null : fbb.writeString(object.userCode!);
        final phoneModelOffset = object.phoneModel == null
            ? null
            : fbb.writeString(object.phoneModel!);
        final osOffset = object.os == null ? null : fbb.writeString(object.os!);
        final osVersionOffset = object.osVersion == null
            ? null
            : fbb.writeString(object.osVersion!);
        final emailOffset =
            object.email == null ? null : fbb.writeString(object.email!);
        final lastAuthCheckOffset = object.lastAuthCheck == null
            ? null
            : fbb.writeString(object.lastAuthCheck!);
        final locationOffset =
            object.location == null ? null : fbb.writeString(object.location!);
        final createAtOffset =
            object.createAt == null ? null : fbb.writeString(object.createAt!);
        fbb.startTable(18);
        fbb.addBool(0, object.isNotificationOn);
        fbb.addBool(1, object.isSync);
        fbb.addInt64(3, object.id);
        fbb.addOffset(4, phoneNameOffset);
        fbb.addOffset(5, userCodeOffset);
        fbb.addOffset(6, phoneModelOffset);
        fbb.addOffset(7, osOffset);
        fbb.addOffset(8, osVersionOffset);
        fbb.addOffset(9, emailOffset);
        fbb.addInt64(10, object.theme);
        fbb.addInt64(11, object.language);
        fbb.addInt64(12, object.userAuthState);
        fbb.addOffset(13, lastAuthCheckOffset);
        fbb.addOffset(14, locationOffset);
        fbb.addOffset(15, createAtOffset);
        fbb.addBool(16, object.isSyncWithMail);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (Store store, Uint8List fbData) {
        final buffer = fb.BufferContext.fromBytes(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = SettingAppData(
            isNotificationOn:
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 4),
            isSync:
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 6),
            isSyncWithMail:
                const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 36),
            createAt: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 34),
            phoneName: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 12),
            userCode: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 14),
            phoneModel: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 16),
            email: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 22),
            location: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 32),
            os: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 18),
            osVersion: const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 20),
            theme: const fb.Int64Reader().vTableGet(buffer, rootOffset, 24, 0),
            language:
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 26, 0),
            userAuthState:
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 28),
            lastAuthCheck: const fb.StringReader().vTableGetNullable(buffer, rootOffset, 30))
          ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);

        return object;
      });

  return ModelDefinition(model, bindings);
}

class SettingAppData_ {
  static final isNotificationOn =
      QueryBooleanProperty(entityId: 1, propertyId: 1, obxType: 1);
  static final isSync =
      QueryBooleanProperty(entityId: 1, propertyId: 2, obxType: 1);
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 4, obxType: 6);
  static final phoneName =
      QueryStringProperty(entityId: 1, propertyId: 5, obxType: 9);
  static final userCode =
      QueryStringProperty(entityId: 1, propertyId: 6, obxType: 9);
  static final phoneModel =
      QueryStringProperty(entityId: 1, propertyId: 7, obxType: 9);
  static final os = QueryStringProperty(entityId: 1, propertyId: 8, obxType: 9);
  static final osVersion =
      QueryStringProperty(entityId: 1, propertyId: 9, obxType: 9);
  static final email =
      QueryStringProperty(entityId: 1, propertyId: 10, obxType: 9);
  static final theme =
      QueryIntegerProperty(entityId: 1, propertyId: 11, obxType: 6);
  static final language =
      QueryIntegerProperty(entityId: 1, propertyId: 12, obxType: 6);
  static final userAuthState =
      QueryIntegerProperty(entityId: 1, propertyId: 13, obxType: 6);
  static final lastAuthCheck =
      QueryStringProperty(entityId: 1, propertyId: 14, obxType: 9);
  static final location =
      QueryStringProperty(entityId: 1, propertyId: 15, obxType: 9);
  static final createAt =
      QueryStringProperty(entityId: 1, propertyId: 16, obxType: 9);
  static final isSyncWithMail =
      QueryBooleanProperty(entityId: 1, propertyId: 17, obxType: 1);
}
