//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: allergy.proto
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


/// Usage: instantiate `Nambadoctor_V1_AllergyWorkerv1Client`, then call methods of this protocol to make API calls.
internal protocol Nambadoctor_V1_AllergyWorkerv1ClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Nambadoctor_V1_AllergyWorkerv1ClientInterceptorFactoryProtocol? { get }

  func getAllergyofAppointment(
    _ request: Nambadoctor_V1_AllergyForAppointmentRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_AllergyForAppointmentRequest, Nambadoctor_V1_AllergyObject>

  func getAllergyofPatient(
    _ request: Nambadoctor_V1_AllergyPat,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_AllergyPat, Nambadoctor_V1_AllergyObject>

  func saveNewAllergy(
    _ request: Nambadoctor_V1_AllergyObject,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_AllergyObject, Nambadoctor_V1_AllergyResponse>
}

extension Nambadoctor_V1_AllergyWorkerv1ClientProtocol {
  internal var serviceName: String {
    return "nambadoctor.v1.AllergyWorkerv1"
  }

  /// Unary call to GetAllergyofAppointment
  ///
  /// - Parameters:
  ///   - request: Request to send to GetAllergyofAppointment.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getAllergyofAppointment(
    _ request: Nambadoctor_V1_AllergyForAppointmentRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_AllergyForAppointmentRequest, Nambadoctor_V1_AllergyObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.AllergyWorkerv1/GetAllergyofAppointment",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetAllergyofAppointmentInterceptors() ?? []
    )
  }

  /// Unary call to GetAllergyofPatient
  ///
  /// - Parameters:
  ///   - request: Request to send to GetAllergyofPatient.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getAllergyofPatient(
    _ request: Nambadoctor_V1_AllergyPat,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_AllergyPat, Nambadoctor_V1_AllergyObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.AllergyWorkerv1/GetAllergyofPatient",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetAllergyofPatientInterceptors() ?? []
    )
  }

  /// Unary call to SaveNewAllergy
  ///
  /// - Parameters:
  ///   - request: Request to send to SaveNewAllergy.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func saveNewAllergy(
    _ request: Nambadoctor_V1_AllergyObject,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_AllergyObject, Nambadoctor_V1_AllergyResponse> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.AllergyWorkerv1/SaveNewAllergy",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSaveNewAllergyInterceptors() ?? []
    )
  }
}

internal protocol Nambadoctor_V1_AllergyWorkerv1ClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getAllergyofAppointment'.
  func makeGetAllergyofAppointmentInterceptors() -> [ClientInterceptor<Nambadoctor_V1_AllergyForAppointmentRequest, Nambadoctor_V1_AllergyObject>]

  /// - Returns: Interceptors to use when invoking 'getAllergyofPatient'.
  func makeGetAllergyofPatientInterceptors() -> [ClientInterceptor<Nambadoctor_V1_AllergyPat, Nambadoctor_V1_AllergyObject>]

  /// - Returns: Interceptors to use when invoking 'saveNewAllergy'.
  func makeSaveNewAllergyInterceptors() -> [ClientInterceptor<Nambadoctor_V1_AllergyObject, Nambadoctor_V1_AllergyResponse>]
}

internal final class Nambadoctor_V1_AllergyWorkerv1Client: Nambadoctor_V1_AllergyWorkerv1ClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Nambadoctor_V1_AllergyWorkerv1ClientInterceptorFactoryProtocol?

  /// Creates a client for the nambadoctor.v1.AllergyWorkerv1 service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nambadoctor_V1_AllergyWorkerv1ClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Nambadoctor_V1_AllergyWorkerv1Provider: CallHandlerProvider {
  var interceptors: Nambadoctor_V1_AllergyWorkerv1ServerInterceptorFactoryProtocol? { get }

  func getAllergyofAppointment(request: Nambadoctor_V1_AllergyForAppointmentRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_AllergyObject>

  func getAllergyofPatient(request: Nambadoctor_V1_AllergyPat, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_AllergyObject>

  func saveNewAllergy(request: Nambadoctor_V1_AllergyObject, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_AllergyResponse>
}

extension Nambadoctor_V1_AllergyWorkerv1Provider {
  internal var serviceName: Substring { return "nambadoctor.v1.AllergyWorkerv1" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetAllergyofAppointment":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_AllergyForAppointmentRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_AllergyObject>(),
        interceptors: self.interceptors?.makeGetAllergyofAppointmentInterceptors() ?? [],
        userFunction: self.getAllergyofAppointment(request:context:)
      )

    case "GetAllergyofPatient":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_AllergyPat>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_AllergyObject>(),
        interceptors: self.interceptors?.makeGetAllergyofPatientInterceptors() ?? [],
        userFunction: self.getAllergyofPatient(request:context:)
      )

    case "SaveNewAllergy":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_AllergyObject>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_AllergyResponse>(),
        interceptors: self.interceptors?.makeSaveNewAllergyInterceptors() ?? [],
        userFunction: self.saveNewAllergy(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Nambadoctor_V1_AllergyWorkerv1ServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'getAllergyofAppointment'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetAllergyofAppointmentInterceptors() -> [ServerInterceptor<Nambadoctor_V1_AllergyForAppointmentRequest, Nambadoctor_V1_AllergyObject>]

  /// - Returns: Interceptors to use when handling 'getAllergyofPatient'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetAllergyofPatientInterceptors() -> [ServerInterceptor<Nambadoctor_V1_AllergyPat, Nambadoctor_V1_AllergyObject>]

  /// - Returns: Interceptors to use when handling 'saveNewAllergy'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSaveNewAllergyInterceptors() -> [ServerInterceptor<Nambadoctor_V1_AllergyObject, Nambadoctor_V1_AllergyResponse>]
}
