//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: followup.proto
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


/// Usage: instantiate `Nambadoctor_V1_FollowUpWorkerV1Client`, then call methods of this protocol to make API calls.
internal protocol Nambadoctor_V1_FollowUpWorkerV1ClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Nambadoctor_V1_FollowUpWorkerV1ClientInterceptorFactoryProtocol? { get }

  func getNextFollowUpWithPatient(
    _ request: Nambadoctor_V1_FollowUpRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>

  func getNextFollowUpWithDoctor(
    _ request: Nambadoctor_V1_FollowUpRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>

  func writeNewFollowUp(
    _ request: Nambadoctor_V1_FollowUpObject,
    callOptions: CallOptions?
  ) -> UnaryCall<Nambadoctor_V1_FollowUpObject, Nambadoctor_V1_FollowUpResponse>
}

extension Nambadoctor_V1_FollowUpWorkerV1ClientProtocol {
  internal var serviceName: String {
    return "nambadoctor.v1.FollowUpWorkerV1"
  }

  /// Unary call to GetNextFollowUpWithPatient
  ///
  /// - Parameters:
  ///   - request: Request to send to GetNextFollowUpWithPatient.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getNextFollowUpWithPatient(
    _ request: Nambadoctor_V1_FollowUpRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.FollowUpWorkerV1/GetNextFollowUpWithPatient",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNextFollowUpWithPatientInterceptors() ?? []
    )
  }

  /// Unary call to GetNextFollowUpWithDoctor
  ///
  /// - Parameters:
  ///   - request: Request to send to GetNextFollowUpWithDoctor.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getNextFollowUpWithDoctor(
    _ request: Nambadoctor_V1_FollowUpRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.FollowUpWorkerV1/GetNextFollowUpWithDoctor",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNextFollowUpWithDoctorInterceptors() ?? []
    )
  }

  /// Unary call to WriteNewFollowUp
  ///
  /// - Parameters:
  ///   - request: Request to send to WriteNewFollowUp.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func writeNewFollowUp(
    _ request: Nambadoctor_V1_FollowUpObject,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nambadoctor_V1_FollowUpObject, Nambadoctor_V1_FollowUpResponse> {
    return self.makeUnaryCall(
      path: "/nambadoctor.v1.FollowUpWorkerV1/WriteNewFollowUp",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeWriteNewFollowUpInterceptors() ?? []
    )
  }
}

internal protocol Nambadoctor_V1_FollowUpWorkerV1ClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getNextFollowUpWithPatient'.
  func makeGetNextFollowUpWithPatientInterceptors() -> [ClientInterceptor<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>]

  /// - Returns: Interceptors to use when invoking 'getNextFollowUpWithDoctor'.
  func makeGetNextFollowUpWithDoctorInterceptors() -> [ClientInterceptor<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>]

  /// - Returns: Interceptors to use when invoking 'writeNewFollowUp'.
  func makeWriteNewFollowUpInterceptors() -> [ClientInterceptor<Nambadoctor_V1_FollowUpObject, Nambadoctor_V1_FollowUpResponse>]
}

internal final class Nambadoctor_V1_FollowUpWorkerV1Client: Nambadoctor_V1_FollowUpWorkerV1ClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Nambadoctor_V1_FollowUpWorkerV1ClientInterceptorFactoryProtocol?

  /// Creates a client for the nambadoctor.v1.FollowUpWorkerV1 service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nambadoctor_V1_FollowUpWorkerV1ClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Nambadoctor_V1_FollowUpWorkerV1Provider: CallHandlerProvider {
  var interceptors: Nambadoctor_V1_FollowUpWorkerV1ServerInterceptorFactoryProtocol? { get }

  func getNextFollowUpWithPatient(request: Nambadoctor_V1_FollowUpRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_FollowUpObject>

  func getNextFollowUpWithDoctor(request: Nambadoctor_V1_FollowUpRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_FollowUpObject>

  func writeNewFollowUp(request: Nambadoctor_V1_FollowUpObject, context: StatusOnlyCallContext) -> EventLoopFuture<Nambadoctor_V1_FollowUpResponse>
}

extension Nambadoctor_V1_FollowUpWorkerV1Provider {
  internal var serviceName: Substring { return "nambadoctor.v1.FollowUpWorkerV1" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetNextFollowUpWithPatient":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_FollowUpRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_FollowUpObject>(),
        interceptors: self.interceptors?.makeGetNextFollowUpWithPatientInterceptors() ?? [],
        userFunction: self.getNextFollowUpWithPatient(request:context:)
      )

    case "GetNextFollowUpWithDoctor":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_FollowUpRequest>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_FollowUpObject>(),
        interceptors: self.interceptors?.makeGetNextFollowUpWithDoctorInterceptors() ?? [],
        userFunction: self.getNextFollowUpWithDoctor(request:context:)
      )

    case "WriteNewFollowUp":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Nambadoctor_V1_FollowUpObject>(),
        responseSerializer: ProtobufSerializer<Nambadoctor_V1_FollowUpResponse>(),
        interceptors: self.interceptors?.makeWriteNewFollowUpInterceptors() ?? [],
        userFunction: self.writeNewFollowUp(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Nambadoctor_V1_FollowUpWorkerV1ServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'getNextFollowUpWithPatient'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetNextFollowUpWithPatientInterceptors() -> [ServerInterceptor<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>]

  /// - Returns: Interceptors to use when handling 'getNextFollowUpWithDoctor'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetNextFollowUpWithDoctorInterceptors() -> [ServerInterceptor<Nambadoctor_V1_FollowUpRequest, Nambadoctor_V1_FollowUpObject>]

  /// - Returns: Interceptors to use when handling 'writeNewFollowUp'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeWriteNewFollowUpInterceptors() -> [ServerInterceptor<Nambadoctor_V1_FollowUpObject, Nambadoctor_V1_FollowUpResponse>]
}