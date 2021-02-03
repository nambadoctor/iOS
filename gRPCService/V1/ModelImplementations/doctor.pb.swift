// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: doctor.proto
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

struct Nambadoctor_V1_GroupOfDoctors {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var doctorResponse: [Nambadoctor_V1_DoctorResponse] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_DoctorResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var doctorID: String {
    get {return _storage._doctorID}
    set {_uniqueStorage()._doctorID = newValue}
  }

  var fullName: String {
    get {return _storage._fullName}
    set {_uniqueStorage()._fullName = newValue}
  }

  var loginPhoneNumber: String {
    get {return _storage._loginPhoneNumber}
    set {_uniqueStorage()._loginPhoneNumber = newValue}
  }

  var profilePic: String {
    get {return _storage._profilePic}
    set {_uniqueStorage()._profilePic = newValue}
  }

  var createdDateTime: Int64 {
    get {return _storage._createdDateTime}
    set {_uniqueStorage()._createdDateTime = newValue}
  }

  var consultationFee: Int32 {
    get {return _storage._consultationFee}
    set {_uniqueStorage()._consultationFee = newValue}
  }

  var registrationNumber: String {
    get {return _storage._registrationNumber}
    set {_uniqueStorage()._registrationNumber = newValue}
  }

  var specialities: [String] {
    get {return _storage._specialities}
    set {_uniqueStorage()._specialities = newValue}
  }

  var languages: [String] {
    get {return _storage._languages}
    set {_uniqueStorage()._languages = newValue}
  }

  var deviceTokenID: String {
    get {return _storage._deviceTokenID}
    set {_uniqueStorage()._deviceTokenID = newValue}
  }

  var upiid: String {
    get {return _storage._upiid}
    set {_uniqueStorage()._upiid = newValue}
  }

  var contactInfos: [Nambadoctor_V1_DoctorsContactInfo] {
    get {return _storage._contactInfos}
    set {_uniqueStorage()._contactInfos = newValue}
  }

  var educationInfos: [Nambadoctor_V1_DoctorsEducationInfo] {
    get {return _storage._educationInfos}
    set {_uniqueStorage()._educationInfos = newValue}
  }

  var experiences: [Nambadoctor_V1_DoctorsExperience] {
    get {return _storage._experiences}
    set {_uniqueStorage()._experiences = newValue}
  }

  var latestSlot: Nambadoctor_V1_LatestSlot {
    get {return _storage._latestSlot ?? Nambadoctor_V1_LatestSlot()}
    set {_uniqueStorage()._latestSlot = newValue}
  }
  /// Returns true if `latestSlot` has been explicitly set.
  var hasLatestSlot: Bool {return _storage._latestSlot != nil}
  /// Clears the value of `latestSlot`. Subsequent reads from it will return its default value.
  mutating func clearLatestSlot() {_uniqueStorage()._latestSlot = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct Nambadoctor_V1_DoctorsContactInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var zipCode: String = String()

  var phoneNumber: String = String()

  var emailID: String = String()

  var streetAddress: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_DoctorsEducationInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var collegeName: String = String()

  var course: String = String()

  var yearPassed: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_DoctorsExperience {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var currentlyWorking: Bool = false

  var startDateTime: Int64 = 0

  var endDateTime: Int64 = 0

  var company: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_DoctorRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var doctorID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_LatestSlot {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: String = String()

  var doctorID: String = String()

  var bookedBy: String = String()

  var duration: Int32 = 0

  var startDateTime: Int64 = 0

  var status: String = String()

  var createdDateTime: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_PatientsRequestForMultipleDoctors {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var patientID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Nambadoctor_V1_PatientsRequestForSingleDoctor {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var patientID: String = String()

  var doctorID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "nambadoctor.v1"

extension Nambadoctor_V1_GroupOfDoctors: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GroupOfDoctors"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "doctorResponse"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.doctorResponse) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.doctorResponse.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.doctorResponse, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_GroupOfDoctors, rhs: Nambadoctor_V1_GroupOfDoctors) -> Bool {
    if lhs.doctorResponse != rhs.doctorResponse {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_DoctorResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "DoctorId"),
    2: .same(proto: "FullName"),
    3: .same(proto: "LoginPhoneNumber"),
    4: .same(proto: "ProfilePic"),
    5: .same(proto: "CreatedDateTime"),
    6: .same(proto: "ConsultationFee"),
    7: .same(proto: "RegistrationNumber"),
    8: .same(proto: "Specialities"),
    9: .same(proto: "Languages"),
    10: .same(proto: "DeviceTokenId"),
    11: .same(proto: "UPIId"),
    12: .same(proto: "ContactInfos"),
    13: .same(proto: "EducationInfos"),
    14: .same(proto: "Experiences"),
    15: .same(proto: "latestSlot"),
  ]

  fileprivate class _StorageClass {
    var _doctorID: String = String()
    var _fullName: String = String()
    var _loginPhoneNumber: String = String()
    var _profilePic: String = String()
    var _createdDateTime: Int64 = 0
    var _consultationFee: Int32 = 0
    var _registrationNumber: String = String()
    var _specialities: [String] = []
    var _languages: [String] = []
    var _deviceTokenID: String = String()
    var _upiid: String = String()
    var _contactInfos: [Nambadoctor_V1_DoctorsContactInfo] = []
    var _educationInfos: [Nambadoctor_V1_DoctorsEducationInfo] = []
    var _experiences: [Nambadoctor_V1_DoctorsExperience] = []
    var _latestSlot: Nambadoctor_V1_LatestSlot? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _doctorID = source._doctorID
      _fullName = source._fullName
      _loginPhoneNumber = source._loginPhoneNumber
      _profilePic = source._profilePic
      _createdDateTime = source._createdDateTime
      _consultationFee = source._consultationFee
      _registrationNumber = source._registrationNumber
      _specialities = source._specialities
      _languages = source._languages
      _deviceTokenID = source._deviceTokenID
      _upiid = source._upiid
      _contactInfos = source._contactInfos
      _educationInfos = source._educationInfos
      _experiences = source._experiences
      _latestSlot = source._latestSlot
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularStringField(value: &_storage._doctorID) }()
        case 2: try { try decoder.decodeSingularStringField(value: &_storage._fullName) }()
        case 3: try { try decoder.decodeSingularStringField(value: &_storage._loginPhoneNumber) }()
        case 4: try { try decoder.decodeSingularStringField(value: &_storage._profilePic) }()
        case 5: try { try decoder.decodeSingularInt64Field(value: &_storage._createdDateTime) }()
        case 6: try { try decoder.decodeSingularInt32Field(value: &_storage._consultationFee) }()
        case 7: try { try decoder.decodeSingularStringField(value: &_storage._registrationNumber) }()
        case 8: try { try decoder.decodeRepeatedStringField(value: &_storage._specialities) }()
        case 9: try { try decoder.decodeRepeatedStringField(value: &_storage._languages) }()
        case 10: try { try decoder.decodeSingularStringField(value: &_storage._deviceTokenID) }()
        case 11: try { try decoder.decodeSingularStringField(value: &_storage._upiid) }()
        case 12: try { try decoder.decodeRepeatedMessageField(value: &_storage._contactInfos) }()
        case 13: try { try decoder.decodeRepeatedMessageField(value: &_storage._educationInfos) }()
        case 14: try { try decoder.decodeRepeatedMessageField(value: &_storage._experiences) }()
        case 15: try { try decoder.decodeSingularMessageField(value: &_storage._latestSlot) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if !_storage._doctorID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._doctorID, fieldNumber: 1)
      }
      if !_storage._fullName.isEmpty {
        try visitor.visitSingularStringField(value: _storage._fullName, fieldNumber: 2)
      }
      if !_storage._loginPhoneNumber.isEmpty {
        try visitor.visitSingularStringField(value: _storage._loginPhoneNumber, fieldNumber: 3)
      }
      if !_storage._profilePic.isEmpty {
        try visitor.visitSingularStringField(value: _storage._profilePic, fieldNumber: 4)
      }
      if _storage._createdDateTime != 0 {
        try visitor.visitSingularInt64Field(value: _storage._createdDateTime, fieldNumber: 5)
      }
      if _storage._consultationFee != 0 {
        try visitor.visitSingularInt32Field(value: _storage._consultationFee, fieldNumber: 6)
      }
      if !_storage._registrationNumber.isEmpty {
        try visitor.visitSingularStringField(value: _storage._registrationNumber, fieldNumber: 7)
      }
      if !_storage._specialities.isEmpty {
        try visitor.visitRepeatedStringField(value: _storage._specialities, fieldNumber: 8)
      }
      if !_storage._languages.isEmpty {
        try visitor.visitRepeatedStringField(value: _storage._languages, fieldNumber: 9)
      }
      if !_storage._deviceTokenID.isEmpty {
        try visitor.visitSingularStringField(value: _storage._deviceTokenID, fieldNumber: 10)
      }
      if !_storage._upiid.isEmpty {
        try visitor.visitSingularStringField(value: _storage._upiid, fieldNumber: 11)
      }
      if !_storage._contactInfos.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._contactInfos, fieldNumber: 12)
      }
      if !_storage._educationInfos.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._educationInfos, fieldNumber: 13)
      }
      if !_storage._experiences.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._experiences, fieldNumber: 14)
      }
      if let v = _storage._latestSlot {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 15)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_DoctorResponse, rhs: Nambadoctor_V1_DoctorResponse) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._doctorID != rhs_storage._doctorID {return false}
        if _storage._fullName != rhs_storage._fullName {return false}
        if _storage._loginPhoneNumber != rhs_storage._loginPhoneNumber {return false}
        if _storage._profilePic != rhs_storage._profilePic {return false}
        if _storage._createdDateTime != rhs_storage._createdDateTime {return false}
        if _storage._consultationFee != rhs_storage._consultationFee {return false}
        if _storage._registrationNumber != rhs_storage._registrationNumber {return false}
        if _storage._specialities != rhs_storage._specialities {return false}
        if _storage._languages != rhs_storage._languages {return false}
        if _storage._deviceTokenID != rhs_storage._deviceTokenID {return false}
        if _storage._upiid != rhs_storage._upiid {return false}
        if _storage._contactInfos != rhs_storage._contactInfos {return false}
        if _storage._educationInfos != rhs_storage._educationInfos {return false}
        if _storage._experiences != rhs_storage._experiences {return false}
        if _storage._latestSlot != rhs_storage._latestSlot {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_DoctorsContactInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorsContactInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "ZipCode"),
    2: .same(proto: "PhoneNumber"),
    3: .same(proto: "EmailId"),
    4: .same(proto: "StreetAddress"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.zipCode) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.phoneNumber) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.emailID) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.streetAddress) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.zipCode.isEmpty {
      try visitor.visitSingularStringField(value: self.zipCode, fieldNumber: 1)
    }
    if !self.phoneNumber.isEmpty {
      try visitor.visitSingularStringField(value: self.phoneNumber, fieldNumber: 2)
    }
    if !self.emailID.isEmpty {
      try visitor.visitSingularStringField(value: self.emailID, fieldNumber: 3)
    }
    if !self.streetAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.streetAddress, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_DoctorsContactInfo, rhs: Nambadoctor_V1_DoctorsContactInfo) -> Bool {
    if lhs.zipCode != rhs.zipCode {return false}
    if lhs.phoneNumber != rhs.phoneNumber {return false}
    if lhs.emailID != rhs.emailID {return false}
    if lhs.streetAddress != rhs.streetAddress {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_DoctorsEducationInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorsEducationInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "CollegeName"),
    2: .same(proto: "Course"),
    3: .same(proto: "YearPassed"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.collegeName) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.course) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.yearPassed) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.collegeName.isEmpty {
      try visitor.visitSingularStringField(value: self.collegeName, fieldNumber: 1)
    }
    if !self.course.isEmpty {
      try visitor.visitSingularStringField(value: self.course, fieldNumber: 2)
    }
    if self.yearPassed != 0 {
      try visitor.visitSingularInt32Field(value: self.yearPassed, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_DoctorsEducationInfo, rhs: Nambadoctor_V1_DoctorsEducationInfo) -> Bool {
    if lhs.collegeName != rhs.collegeName {return false}
    if lhs.course != rhs.course {return false}
    if lhs.yearPassed != rhs.yearPassed {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_DoctorsExperience: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorsExperience"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "CurrentlyWorking"),
    2: .same(proto: "StartDateTime"),
    3: .same(proto: "EndDateTime"),
    4: .same(proto: "Company"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.currentlyWorking) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.startDateTime) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.endDateTime) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.company) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.currentlyWorking != false {
      try visitor.visitSingularBoolField(value: self.currentlyWorking, fieldNumber: 1)
    }
    if self.startDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.startDateTime, fieldNumber: 2)
    }
    if self.endDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.endDateTime, fieldNumber: 3)
    }
    if !self.company.isEmpty {
      try visitor.visitSingularStringField(value: self.company, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_DoctorsExperience, rhs: Nambadoctor_V1_DoctorsExperience) -> Bool {
    if lhs.currentlyWorking != rhs.currentlyWorking {return false}
    if lhs.startDateTime != rhs.startDateTime {return false}
    if lhs.endDateTime != rhs.endDateTime {return false}
    if lhs.company != rhs.company {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_DoctorRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DoctorRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "doctorId"),
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

  static func ==(lhs: Nambadoctor_V1_DoctorRequest, rhs: Nambadoctor_V1_DoctorRequest) -> Bool {
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_LatestSlot: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LatestSlot"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "Id"),
    2: .same(proto: "DoctorId"),
    3: .same(proto: "BookedBy"),
    4: .same(proto: "Duration"),
    5: .same(proto: "StartDateTime"),
    6: .same(proto: "Status"),
    7: .same(proto: "CreatedDateTime"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.doctorID) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.bookedBy) }()
      case 4: try { try decoder.decodeSingularInt32Field(value: &self.duration) }()
      case 5: try { try decoder.decodeSingularInt64Field(value: &self.startDateTime) }()
      case 6: try { try decoder.decodeSingularStringField(value: &self.status) }()
      case 7: try { try decoder.decodeSingularInt64Field(value: &self.createdDateTime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.id.isEmpty {
      try visitor.visitSingularStringField(value: self.id, fieldNumber: 1)
    }
    if !self.doctorID.isEmpty {
      try visitor.visitSingularStringField(value: self.doctorID, fieldNumber: 2)
    }
    if !self.bookedBy.isEmpty {
      try visitor.visitSingularStringField(value: self.bookedBy, fieldNumber: 3)
    }
    if self.duration != 0 {
      try visitor.visitSingularInt32Field(value: self.duration, fieldNumber: 4)
    }
    if self.startDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.startDateTime, fieldNumber: 5)
    }
    if !self.status.isEmpty {
      try visitor.visitSingularStringField(value: self.status, fieldNumber: 6)
    }
    if self.createdDateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.createdDateTime, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Nambadoctor_V1_LatestSlot, rhs: Nambadoctor_V1_LatestSlot) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.bookedBy != rhs.bookedBy {return false}
    if lhs.duration != rhs.duration {return false}
    if lhs.startDateTime != rhs.startDateTime {return false}
    if lhs.status != rhs.status {return false}
    if lhs.createdDateTime != rhs.createdDateTime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_PatientsRequestForMultipleDoctors: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".PatientsRequestForMultipleDoctors"
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

  static func ==(lhs: Nambadoctor_V1_PatientsRequestForMultipleDoctors, rhs: Nambadoctor_V1_PatientsRequestForMultipleDoctors) -> Bool {
    if lhs.patientID != rhs.patientID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Nambadoctor_V1_PatientsRequestForSingleDoctor: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".PatientsRequestForSingleDoctor"
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

  static func ==(lhs: Nambadoctor_V1_PatientsRequestForSingleDoctor, rhs: Nambadoctor_V1_PatientsRequestForSingleDoctor) -> Bool {
    if lhs.patientID != rhs.patientID {return false}
    if lhs.doctorID != rhs.doctorID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}