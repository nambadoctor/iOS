// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: followup.proto
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

struct Nambadoctor_V1_FollowUpObject {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var patientID: String = String()

  var doctorID: String = String()

  var discountedFee: Int32 = 0

  var nofDays: Int32 = 0

  var createdDateTime: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_FollowUpRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var patientID: String = String()

  var doctorID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_FollowUpResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "nambadoctor.v1"

extension Nambadoctor_V1_FollowUpObject: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".FollowUpObject"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "Id"),
    2: .same(proto: "PatientId"),
    3: .same(proto: "DoctorId"),
    4: .same(proto: "DiscountedFee"),
    5: .same(proto: "NofDays"),
    6: .same(proto: "CreatedDateTime"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.patientID) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.doctorID) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.discountedFee) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self.nofDays) }()
      case 6: try { try decoder.decodeSingularInt64Field(value: &self.createdDateTime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.patientID.isEmpty {
      try visitor.visitSingularStringField(value: self.patientID, fieldNumber: 2)
    }
    if !self.doctorID.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorID, fieldNumber: 3)
    }
    if self.discountedFee != 0 {
      try visitor.visitSingularInt32Field(value: self.discountedFee, fieldNumber: 4)
    }
    if self.nofDays != 0 {
      try visitor.visitSingularInt32Field(value: self.nofDays, fieldNumber: 5)
    }
    if self.createdDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.createdDateTime, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_FollowUpObject, rhs: Nambadoctor_V1_FollowUpObject) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.patientID != rhs.patientID {return false}
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.discountedFee != rhs.discountedFee {return false}
    if lhs.nofDays != rhs.nofDays {return false}
    if lhs.createdDateTime != rhs.createdDateTime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_FollowUpRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".FollowUpRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "PatientId"),
    2: .same(proto: "DoctorId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.patientID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.doctorID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.patientID.isEmpty {
      try visitor.visitSingularStringField(value: self.patientID, fieldNumber: 1)
    }
    if !self.doctorID.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_FollowUpRequest, rhs: Nambadoctor_V1_FollowUpRequest) -> Bool {
    if lhs.patientID != rhs.patientID {return false}
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_FollowUpResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".FollowUpResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "Id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_FollowUpResponse, rhs: Nambadoctor_V1_FollowUpResponse) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
