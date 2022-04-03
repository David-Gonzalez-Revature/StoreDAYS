//
//  DBHelper.swift
//  StoreDAYS
//
//  Created by David Gonzalez on 4/2/22.
//


import Foundation

import SQLite3

class DBHelper {
    
    init() {
        db = openDatabase()
        createUsersDataTable()
    }
    
    let dbPath: String = "shopDAYS.sqlite"
    var db: OpaquePointer?
    //MARK: Open Data Base
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at:::::::::::::::::::::::::::::::::::::::::::::::: \(fileURL.path)")
            return db
        }
    }
    
    //MARK: Functions USERS
 
    func createUsersDataTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Users(Id INTEGER PRIMARY KEY AUTOINCREMENT,UserName TEXT UNIQUE, FirstName TEXT,LastName TEXT, DateOfBirth TEXT,password TEXT, Email TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    
    func insertUsers(UserName: String,FirstName: String, LastName: String , DateOfBirth: String , Password: String, Email: String) {
        let insertStatementString = "INSERT INTO Users( UserName,FirstName, LastName , DateOfBirth , Password, Email) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            //            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 1, (UserName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (FirstName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (LastName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (DateOfBirth as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (Password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (Email as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row, User exist.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getUsersN() -> [UserData] {
        let queryStatementString = "SELECT * FROM users;"
        var queryStatement: OpaquePointer? = nil
        var psns: [UserData] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let UserName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let FirstName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                let email = sqlite3_column_int(queryStatement, 4)
               // psns.append(UserData( Int32(id) as! Decoder  ,UserName,FirstName, password, email))
             //   psns.append(UserData(from: Decoder.self as! Decoder))
                print("Query Result:")
                print("\(id) | \(UserName) | \(password) | \(email)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    



}
