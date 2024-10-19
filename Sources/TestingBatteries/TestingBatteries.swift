//  TestBatteries.swift
//
//  Created by AJ Ibraheem on 08/09/2024.
//  Copyright 2024, Ara Intelligence Limited.
   

import Testing

public enum TestIssue: Error {
    case assertionError(message: String)
}

public protocol TestBatteries {}
public extension TestBatteries {
    func assertFail(message: String) -> TestIssue {
        Issue.record(Comment(rawValue: message))
        return .assertionError(message: message)
    }
    
    func verifyFail(message: String) {
        #expect(Bool(false), Comment(rawValue: message))
    }
    
    func verifyTrue(
        _ sut: @autoclosure () throws -> Bool,
        _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
    ) rethrows {
        let sutValue = try sut()
        #expect(sutValue == true, "[Error]: \(message()) occured at \(file), L\(line))")
    }
    
    func verifyFalse(
        _ sut: @autoclosure () throws -> Bool,
        _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
    ) rethrows {
        let sutValue = try sut()
        #expect(sutValue == false, "[Error]: \(message()) occured at \(file), L\(line))")
    }
    
    func verifyEqual<T: Equatable>(
        _ lhs: @autoclosure () throws -> T,
        _ rhs: @autoclosure () throws -> T,
        _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
    ) rethrows {
        let lhsValue = try lhs()
        let rhsValue = try rhs()
        #expect(lhsValue == rhsValue, "[Error]: \(message()) occured at \(file), L\(line))")
    }
    
    func verifyEqual<T: FloatingPoint>(
        _ lhs: @autoclosure () throws -> T,
        _ rhs: @autoclosure () throws -> T,
        tolerance: @autoclosure () throws -> T = 1e-3,
        _ message: @autoclosure () -> String = "", file: StaticString = #filePath, line: UInt = #line
    ) rethrows {
        let lhsValue = try lhs()
        let rhsValue = try rhs()
        let diff = abs(lhsValue - rhsValue)
        let eps = try tolerance()
        #expect(diff < eps, "[Error]: \(message()) occured at \(file), L\(line))")
    }
    
    func verifyNotNil<T>(_ optionalItem: @autoclosure () throws -> T?) rethrows {
        let optionalItem = try optionalItem()
        #expect(optionalItem != nil)
    }
}
