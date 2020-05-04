//
//  FormValidator.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 16.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//
import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case requiredField(field: String)
    case dateOfBirth
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .dateOfBirth: return DateOfBirthValidator()
        }
    }
}


struct DateOfBirthValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        let calendar = Calendar.current
        let rightNow = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: value) else {
            throw ValidationError("Неправильный формат даты")
        }
        if let yearsInterval = calendar.dateComponents([.year], from: date, to: rightNow).year {
            if yearsInterval >= 18 {
                return value
            } else {
                throw ValidationError("Вам должно быть больше 18 лет, чтобы зарегестрироваться на сервисе")
            }
        } else {
            print("ERROR TO COUNT INTERVAL BETWEEN GIVEN DATE AND CURRENT DATE")
        }
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Обязательное поле " + fieldName)
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: #"^[a-zA-Z\d\_]{6,20}$"#,  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Неправильный логин: логин может содержать следующие символы: a-z, A-Z, 0-9, _,и должен быть не короче 6 символов")
            }
        } catch {
            throw ValidationError("Неправильный логин: логин может содержать следующие символы: a-z, A-Z, 0-9, _,и должен быть не короче 6 символов")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Поле 'Пароль' обязательно!")}
        do {
            if try NSRegularExpression(pattern: #"^(?=.*[\d])(?=.*[a-z])(?=.*[A-Z])[\da-zA-Z\W]{8,30}$"#,  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Неправильный пароль: допускаются спецсимволы, но не обязательны. длина от 8 до 30 символов: должна быть хотя бы одна цифра, хотя бы одна малая буква, хотя бы одна большая буква")
            }
        } catch {
            throw ValidationError("Неправильный пароль: допускаются спецсимволы, но не обязательны. длина от 8 до 30 символов: должна быть хотя бы одна цифра, хотя бы одна малая буква, хотя бы одна большая буква")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Поле 'Email' Обязательно!")}
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Неправильный формат Email")
            }
        } catch {
            throw ValidationError("Неправильный формат Email")
        }
        return value
    }
}
