//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: patient.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Nambadoctor_V1_PatientWorkerV1Client`, then call methods of this protocol to make API calls.
internal protocol Nambadoctor_V1_PatientWorkerV1ClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Nambadoctor_V1_PatientWorkerV1ClientInterceptorFactoryProtocol? { get }

  func getPatientObject(
    _ request: Nambadoctor_V1_PatientRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>

  func getListOfDoctorsPatients(
    _ request: Nambadoctor_V1_DoctorsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_DoctorsRequest, Nambadoctor_V1_DoctorsResponse>

  func getSpecificPatientOfDoctor(
    _ request: Nambadoctor_V1_PatientRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>

  func writeNewPatientObject(
    _ request: Nambadoctor_V1_PatientObject,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_PatientObject, Nambadoctor_V1_PatientRequest>

  func writeNewPreRegObject(
    _ request: Nambadoctor_V1_PreRegPatientObject,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_PreRegPatientObject, Nambadoctor_V1_PatientRequest>
}

extension Nambadoctor_V1_PatientWorkerV1ClientProtocol {
  internal var serviceName: String {
    return "nambadoctor.v1.PatientWorkerV1"
  }

  /// Unary call to GetPatientObject
  ///
  /// - Parameters:
  ///   - request: Request to send to GetPatientObject.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getPatientObject(
    _ request: Nambadoctor_V1_PatientRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.PatientWorkerV1/GetPatientObject",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetPatientObjectInterceptors() ?? []
    )
  }

  /// Unary call to GetListOfDoctorsPatients
  ///
  /// - Parameters:
  ///   - request: Request to send to GetListOfDoctorsPatients.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getListOfDoctorsPatients(
    _ request: Nambadoctor_V1_DoctorsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_DoctorsRequest, Nambadoctor_V1_DoctorsResponse> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.PatientWorkerV1/GetListOfDoctorsPatients",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetListOfDoctorsPatientsInterceptors() ?? []
    )
  }

  /// Unary call to GetSpecificPatientOfDoctor
  ///
  /// - Parameters:
  ///   - request: Request to send to GetSpecificPatientOfDoctor.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getSpecificPatientOfDoctor(
    _ request: Nambadoctor_V1_PatientRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.PatientWorkerV1/GetSpecificPatientOfDoctor",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetSpecificPatientOfDoctorInterceptors() ?? []
    )
  }

  /// Unary call to WriteNewPatientObject
  ///
  /// - Parameters:
  ///   - request: Request to send to WriteNewPatientObject.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func writeNewPatientObject(
    _ request: Nambadoctor_V1_PatientObject,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_PatientObject, Nambadoctor_V1_PatientRequest> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.PatientWorkerV1/WriteNewPatientObject",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeWriteNewPatientObjectInterceptors() ?? []
    )
  }

  /// Unary call to WriteNewPreRegObject
  ///
  /// - Parameters:
  ///   - request: Request to send to WriteNewPreRegObject.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func writeNewPreRegObject(
    _ request: Nambadoctor_V1_PreRegPatientObject,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_PreRegPatientObject, Nambadoctor_V1_PatientRequest> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.PatientWorkerV1/WriteNewPreRegObject",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeWriteNewPreRegObjectInterceptors() ?? []
    )
  }
}

internal protocol Nambadoctor_V1_PatientWorkerV1ClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getPatientObject'.
  func makeGetPatientObjectInterceptors() -> [ClientInterceptor<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>]

  /// - Returns: Interceptors to use when invoking 'getListOfDoctorsPatients'.
  func makeGetListOfDoctorsPatientsInterceptors() -> [ClientInterceptor<Nambadoctor_V1_DoctorsRequest, Nambadoctor_V1_DoctorsResponse>]

  /// - Returns: Interceptors to use when invoking 'getSpecificPatientOfDoctor'.
  func makeGetSpecificPatientOfDoctorInterceptors() -> [ClientInterceptor<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>]

  /// - Returns: Interceptors to use when invoking 'writeNewPatientObject'.
  func makeWriteNewPatientObjectInterceptors() -> [ClientInterceptor<Nambadoctor_V1_PatientObject, Nambadoctor_V1_PatientRequest>]

  /// - Returns: Interceptors to use when invoking 'writeNewPreRegObject'.
  func makeWriteNewPreRegObjectInterceptors() -> [ClientInterceptor<Nambadoctor_V1_PreRegPatientObject, Nambadoctor_V1_PatientRequest>]
}

internal final class Nambadoctor_V1_PatientWorkerV1Client: Nambadoctor_V1_PatientWorkerV1ClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Nambadoctor_V1_PatientWorkerV1ClientInterceptorFactoryProtocol?

  /// Creates a client for the nambadoctor.v1.PatientWorkerV1 service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nambadoctor_V1_PatientWorkerV1ClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Nambadoctor_V1_PatientWorkerV1Provider: CallHandlerProvider {
  var interceptors: Nambadoctor_V1_PatientWorkerV1ServerInterceptorFactoryProtocol? { get }

  func getPatientObject(request: Nambadoctor_V1_PatientRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_PatientObject>

  func getListOfDoctorsPatients(request: Nambadoctor_V1_DoctorsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_DoctorsResponse>

  func getSpecificPatientOfDoctor(request: Nambadoctor_V1_PatientRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_PatientObject>

  func writeNewPatientObject(request: Nambadoctor_V1_PatientObject, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_PatientRequest>

  func writeNewPreRegObject(request: Nambadoctor_V1_PreRegPatientObject, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_PatientRequest>
}

extension Nambadoctor_V1_PatientWorkerV1Provider {
  internal var serviceName: Substring { return "nambadoctor.v1.PatientWorkerV1" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetPatientObject":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_PatientRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_PatientObject>(),
        interceptors: self.interceptors?.makeGetPatientObjectInterceptors() ?? [],
        userFunction: self.getPatientObject(request:context:)
      )

    case "GetListOfDoctorsPatients":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_DoctorsRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_DoctorsResponse>(),
        interceptors: self.interceptors?.makeGetListOfDoctorsPatientsInterceptors() ?? [],
        userFunction: self.getListOfDoctorsPatients(request:context:)
      )

    case "GetSpecificPatientOfDoctor":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_PatientRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_PatientObject>(),
        interceptors: self.interceptors?.makeGetSpecificPatientOfDoctorInterceptors() ?? [],
        userFunction: self.getSpecificPatientOfDoctor(request:context:)
      )

    case "WriteNewPatientObject":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_PatientObject>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_PatientRequest>(),
        interceptors: self.interceptors?.makeWriteNewPatientObjectInterceptors() ?? [],
        userFunction: self.writeNewPatientObject(request:context:)
      )

    case "WriteNewPreRegObject":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_PreRegPatientObject>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_PatientRequest>(),
        interceptors: self.interceptors?.makeWriteNewPreRegObjectInterceptors() ?? [],
        userFunction: self.writeNewPreRegObject(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Nambadoctor_V1_PatientWorkerV1ServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'getPatientObject'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetPatientObjectInterceptors() -> [ServerInterceptor<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>]

  /// - Returns: Interceptors to use when handling 'getListOfDoctorsPatients'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetListOfDoctorsPatientsInterceptors() -> [ServerInterceptor<Nambadoctor_V1_DoctorsRequest, Nambadoctor_V1_DoctorsResponse>]

  /// - Returns: Interceptors to use when handling 'getSpecificPatientOfDoctor'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetSpecificPatientOfDoctorInterceptors() -> [ServerInterceptor<Nambadoctor_V1_PatientRequest, Nambadoctor_V1_PatientObject>]

  /// - Returns: Interceptors to use when handling 'writeNewPatientObject'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeWriteNewPatientObjectInterceptors() -> [ServerInterceptor<Nambadoctor_V1_PatientObject, Nambadoctor_V1_PatientRequest>]

  /// - Returns: Interceptors to use when handling 'writeNewPreRegObject'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeWriteNewPreRegObjectInterceptors() -> [ServerInterceptor<Nambadoctor_V1_PreRegPatientObject, Nambadoctor_V1_PatientRequest>]
}
