//
//  ProtobufToVarConverters.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 17/03/21.
//

import Foundation
import SwiftProtobuf

extension SwiftProtobuf.Google_Protobuf_StringValue {
    var toString:String {return "\(self)"}
}

extension Array where Element == SwiftProtobuf.Google_Protobuf_StringValue {
    func convert() -> [String] {
        var arr:[String] = [String]()
        for val in self {
            arr.append(val.toString)
        }
        return arr
    }
}

extension SwiftProtobuf.Google_Protobuf_BoolValue {
    var toBool:Bool {
        if self == true {
            return true
        } else {
            return false
        }
    }
}

extension SwiftProtobuf.Google_Protobuf_Int64Value {
    var toInt64:Int64 {return Int64("\(self)") ?? 0}
}

extension SwiftProtobuf.Google_Protobuf_Int32Value {
    var toInt32:Int32 {return Int32("\(self)") ?? 0}
}

extension SwiftProtobuf.Google_Protobuf_BytesValue {
    var toString:String {return "\(self)"}
}

extension SwiftProtobuf.Google_Protobuf_DoubleValue {
    var toDouble:Double {return Double("\(self)") ?? 0}
}

extension String {
    var toProto:SwiftProtobuf.Google_Protobuf_StringValue {return SwiftProtobuf.Google_Protobuf_StringValue(self)}
}

extension Array where Element == String {
    func convert() -> [SwiftProtobuf.Google_Protobuf_StringValue] {
        var arr:[SwiftProtobuf.Google_Protobuf_StringValue] = [SwiftProtobuf.Google_Protobuf_StringValue]()
        for val in self {
            arr.append(val.toProto)
        }
        return arr
    }
}

extension Int32 {
    var toProto:SwiftProtobuf.Google_Protobuf_Int32Value {return SwiftProtobuf.Google_Protobuf_Int32Value(self)}
}

extension Int64 {
    var toProto:SwiftProtobuf.Google_Protobuf_Int64Value {return SwiftProtobuf.Google_Protobuf_Int64Value(self)}
}

extension Double {
    var toProto:SwiftProtobuf.Google_Protobuf_DoubleValue {return SwiftProtobuf.Google_Protobuf_DoubleValue(self)}
}

extension Bool {
    var toProto:SwiftProtobuf.Google_Protobuf_BoolValue {return SwiftProtobuf.Google_Protobuf_BoolValue(self)}
}

