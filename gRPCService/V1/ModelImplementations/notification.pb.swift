// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: notification.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Nambadoctor_V1_NotificationRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var receiverDeviceToken: String = String()

  var title: String = String()

  var body: String = String()

  var idIfAny: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_NotificationResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var serverResponse: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "nambadoctor.v1"

extension Nambadoctor_V1_NotificationRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NotificationRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ReceiverDeviceToken"),
    2: .same(proto: "Title"),
    3: .same(proto: "Body"),
    4: .same(proto: "IdIfAny"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.receiverDeviceToken) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.title) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.body) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.idIfAny) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.receiverDeviceToken.isEmpty {
      try visitor.visitSingularStringField(value: self.receiverDeviceToken, fieldNumber: 1)
    }
    if !self.title.isEmpty {
      try visitor.visitSingularStringField(value: self.title, fieldNumber: 2)
    }
    if !self.body.isEmpty {
      try visitor.visitSingularStringField(value: self.body, fieldNumber: 3)
    }
    if !self.idIfAny.isEmpty {
      try visitor.visitSingularStringField(value: self.idIfAny, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_NotificationRequest, rhs: Nambadoctor_V1_NotificationRequest) -> Bool {
    if lhs.receiverDeviceToken != rhs.receiverDeviceToken {return false}
    if lhs.title != rhs.title {return false}
    if lhs.body != rhs.body {return false}
    if lhs.idIfAny != rhs.idIfAny {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_NotificationResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".NotificationResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "serverResponse"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.serverResponse) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.serverResponse != false {
      try visitor.visitSingularBoolField(value: self.serverResponse, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_NotificationResponse, rhs: Nambadoctor_V1_NotificationResponse) -> Bool {
    if lhs.serverResponse != rhs.serverResponse {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}