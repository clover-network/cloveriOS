// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Zilliqa.proto
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

/// Input data necessary to create a signed transaction.
public struct TW_Zilliqa_Proto_SigningInput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Transaction version
  public var version: UInt32 = 0

  /// Nonce
  public var nonce: UInt64 = 0

  /// Recipient's address.
  public var toAddress: String = String()

  /// Amount to send (256-bit number)
  public var amount: Data = SwiftProtobuf.Internal.emptyData

  /// GasPrice (256-bit number)
  public var gasPrice: Data = SwiftProtobuf.Internal.emptyData

  /// GasLimit
  public var gasLimit: UInt64 = 0

  /// Private Key
  public var privateKey: Data = SwiftProtobuf.Internal.emptyData

  /// Smart contract code
  public var code: Data = SwiftProtobuf.Internal.emptyData

  /// String-ified JSON object specifying the transition parameter
  public var data: Data = SwiftProtobuf.Internal.emptyData

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// Transaction signing output.
public struct TW_Zilliqa_Proto_SigningOutput {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Signed signature bytes.
  public var signature: Data = SwiftProtobuf.Internal.emptyData

  /// JSON transaction with signature
  public var json: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "TW.Zilliqa.Proto"

extension TW_Zilliqa_Proto_SigningInput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningInput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "version"),
    2: .same(proto: "nonce"),
    3: .standard(proto: "to_address"),
    4: .same(proto: "amount"),
    5: .standard(proto: "gas_price"),
    6: .standard(proto: "gas_limit"),
    7: .standard(proto: "private_key"),
    10: .same(proto: "code"),
    11: .same(proto: "data"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt32Field(value: &self.version)
      case 2: try decoder.decodeSingularUInt64Field(value: &self.nonce)
      case 3: try decoder.decodeSingularStringField(value: &self.toAddress)
      case 4: try decoder.decodeSingularBytesField(value: &self.amount)
      case 5: try decoder.decodeSingularBytesField(value: &self.gasPrice)
      case 6: try decoder.decodeSingularUInt64Field(value: &self.gasLimit)
      case 7: try decoder.decodeSingularBytesField(value: &self.privateKey)
      case 10: try decoder.decodeSingularBytesField(value: &self.code)
      case 11: try decoder.decodeSingularBytesField(value: &self.data)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.version != 0 {
      try visitor.visitSingularUInt32Field(value: self.version, fieldNumber: 1)
    }
    if self.nonce != 0 {
      try visitor.visitSingularUInt64Field(value: self.nonce, fieldNumber: 2)
    }
    if !self.toAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.toAddress, fieldNumber: 3)
    }
    if !self.amount.isEmpty {
      try visitor.visitSingularBytesField(value: self.amount, fieldNumber: 4)
    }
    if !self.gasPrice.isEmpty {
      try visitor.visitSingularBytesField(value: self.gasPrice, fieldNumber: 5)
    }
    if self.gasLimit != 0 {
      try visitor.visitSingularUInt64Field(value: self.gasLimit, fieldNumber: 6)
    }
    if !self.privateKey.isEmpty {
      try visitor.visitSingularBytesField(value: self.privateKey, fieldNumber: 7)
    }
    if !self.code.isEmpty {
      try visitor.visitSingularBytesField(value: self.code, fieldNumber: 10)
    }
    if !self.data.isEmpty {
      try visitor.visitSingularBytesField(value: self.data, fieldNumber: 11)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Zilliqa_Proto_SigningInput, rhs: TW_Zilliqa_Proto_SigningInput) -> Bool {
    if lhs.version != rhs.version {return false}
    if lhs.nonce != rhs.nonce {return false}
    if lhs.toAddress != rhs.toAddress {return false}
    if lhs.amount != rhs.amount {return false}
    if lhs.gasPrice != rhs.gasPrice {return false}
    if lhs.gasLimit != rhs.gasLimit {return false}
    if lhs.privateKey != rhs.privateKey {return false}
    if lhs.code != rhs.code {return false}
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension TW_Zilliqa_Proto_SigningOutput: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".SigningOutput"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "signature"),
    2: .same(proto: "json"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.signature)
      case 2: try decoder.decodeSingularStringField(value: &self.json)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.signature.isEmpty {
      try visitor.visitSingularBytesField(value: self.signature, fieldNumber: 1)
    }
    if !self.json.isEmpty {
      try visitor.visitSingularStringField(value: self.json, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: TW_Zilliqa_Proto_SigningOutput, rhs: TW_Zilliqa_Proto_SigningOutput) -> Bool {
    if lhs.signature != rhs.signature {return false}
    if lhs.json != rhs.json {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
