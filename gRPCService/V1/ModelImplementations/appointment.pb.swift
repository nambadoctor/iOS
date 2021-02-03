// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: appointment.proto
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

struct Nambadoctor_V1_AppointmentRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var appointmentID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_AppointmentDoctorRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var doctorID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_AppointmentPatientRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var patientID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_AppointmentObject {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var appointmentID: String = String()

  var preferredLanguage: String = String()

  var status: String = String()

  var doctorID: String = String()

  var doctorName: String = String()

  var requestedBy: String = String()

  var patientName: String = String()

  var consultationFee: Int32 = 0

  var paymentStatus: String = String()

  var problemDetails: String = String()

  var createdDateTime: Int64 = 0

  var slotID: String = String()

  var discountedConsultationFee: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_BulkAppointmentsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var appointmentResponse: [Nambadoctor_V1_AppointmentObject] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "nambadoctor.v1"

extension Nambadoctor_V1_AppointmentRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AppointmentRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "AppointmentId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.appointmentID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.appointmentID.isEmpty {
      try visitor.visitSingularStringField(value: self.appointmentID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_AppointmentRequest, rhs: Nambadoctor_V1_AppointmentRequest) -> Bool {
    if lhs.appointmentID != rhs.appointmentID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_AppointmentDoctorRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AppointmentDoctorRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "DoctorId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.doctorID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.doctorID.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_AppointmentDoctorRequest, rhs: Nambadoctor_V1_AppointmentDoctorRequest) -> Bool {
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_AppointmentPatientRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AppointmentPatientRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "PatientId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.patientID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.patientID.isEmpty {
      try visitor.visitSingularStringField(value: self.patientID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_AppointmentPatientRequest, rhs: Nambadoctor_V1_AppointmentPatientRequest) -> Bool {
    if lhs.patientID != rhs.patientID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_AppointmentObject: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".AppointmentObject"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "AppointmentId"),
    2: .same(proto: "PreferredLanguage"),
    3: .same(proto: "Status"),
    4: .same(proto: "DoctorId"),
    5: .same(proto: "DoctorName"),
    6: .same(proto: "RequestedBy"),
    7: .same(proto: "PatientName"),
    8: .same(proto: "ConsultationFee"),
    9: .same(proto: "PaymentStatus"),
    10: .same(proto: "ProblemDetails"),
    11: .same(proto: "CreatedDateTime"),
    12: .same(proto: "SlotId"),
    13: .same(proto: "DiscountedConsultationFee"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.appointmentID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.preferredLanguage) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.status) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.doctorID) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.doctorName) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.requestedBy) }()
      case 7: try { try decoder.decodeSingularStringField(value: &self.patientName) }()
      case 8: try { try decoder.decodeSingularInt32Field(value: &self.consultationFee) }()
      case 9: try { try decoder.decodeSingularStringField(value: &self.paymentStatus) }()
      case 10: try { try decoder.decodeSingularStringField(value: &self.problemDetails) }()
      case 11: try { try decoder.decodeSingularInt64Field(value: &self.createdDateTime) }()
      case 12: try { try decoder.decodeSingularStringField(value: &self.slotID) }()
      case 13: try { try decoder.decodeSingularInt32Field(value: &self.discountedConsultationFee) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.appointmentID.isEmpty {
      try visitor.visitSingularStringField(value: self.appointmentID, fieldNumber: 1)
    }
    if !self.preferredLanguage.isEmpty {
      try visitor.visitSingularStringField(value: self.preferredLanguage, fieldNumber: 2)
    }
    if !self.status.isEmpty {
      try visitor.visitSingularStringField(value: self.status, fieldNumber: 3)
    }
    if !self.doctorID.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorID, fieldNumber: 4)
    }
    if !self.doctorName.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorName, fieldNumber: 5)
    }
    if !self.requestedBy.isEmpty {
      try visitor.visitSingularStringField(value: self.requestedBy, fieldNumber: 6)
    }
    if !self.patientName.isEmpty {
      try visitor.visitSingularStringField(value: self.patientName, fieldNumber: 7)
    }
    if self.consultationFee != 0 {
      try visitor.visitSingularInt32Field(value: self.consultationFee, fieldNumber: 8)
    }
    if !self.paymentStatus.isEmpty {
      try visitor.visitSingularStringField(value: self.paymentStatus, fieldNumber: 9)
    }
    if !self.problemDetails.isEmpty {
      try visitor.visitSingularStringField(value: self.problemDetails, fieldNumber: 10)
    }
    if self.createdDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.createdDateTime, fieldNumber: 11)
    }
    if !self.slotID.isEmpty {
      try visitor.visitSingularStringField(value: self.slotID, fieldNumber: 12)
    }
    if self.discountedConsultationFee != 0 {
      try visitor.visitSingularInt32Field(value: self.discountedConsultationFee, fieldNumber: 13)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_AppointmentObject, rhs: Nambadoctor_V1_AppointmentObject) -> Bool {
    if lhs.appointmentID != rhs.appointmentID {return false}
    if lhs.preferredLanguage != rhs.preferredLanguage {return false}
    if lhs.status != rhs.status {return false}
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.doctorName != rhs.doctorName {return false}
    if lhs.requestedBy != rhs.requestedBy {return false}
    if lhs.patientName != rhs.patientName {return false}
    if lhs.consultationFee != rhs.consultationFee {return false}
    if lhs.paymentStatus != rhs.paymentStatus {return false}
    if lhs.problemDetails != rhs.problemDetails {return false}
    if lhs.createdDateTime != rhs.createdDateTime {return false}
    if lhs.slotID != rhs.slotID {return false}
    if lhs.discountedConsultationFee != rhs.discountedConsultationFee {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_BulkAppointmentsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BulkAppointmentsResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "AppointmentResponse"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.appointmentResponse) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.appointmentResponse.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.appointmentResponse, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_BulkAppointmentsResponse, rhs: Nambadoctor_V1_BulkAppointmentsResponse) -> Bool {
    if lhs.appointmentResponse != rhs.appointmentResponse {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}