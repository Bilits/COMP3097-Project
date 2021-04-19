
import Foundation
import SQLite3
import Foundation

class Restaurant
{
    
   // var name: String = ""
    var nameRestaurant: String = ""
    var descriptionRestaurant: String = ""
    var addressRestaurant: String = ""
    var phoneNumberRestaurant: String = ""
    var tagsRestaurant: String = ""
    var rate: String = ""

    

  //  var answers: [String] = []
    var id: Int = 0
    
    init(id:Int, nameRestaurant:String, descriptionRestaurant:String, addressRestaurant:String, phoneNumberRestaurant:String, tagsRestaurant:String,
        rate:String)
    {
        self.id = id
       // self.name = name
        self.nameRestaurant = nameRestaurant
        self.descriptionRestaurant = descriptionRestaurant
        self.addressRestaurant = addressRestaurant
        self.phoneNumberRestaurant = phoneNumberRestaurant
        self.tagsRestaurant = tagsRestaurant
        self.rate = rate

        
     //   self.answers = answers
    }
    
}


class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "Talk2Alex"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Restaurant(Id INTEGER PRIMARY KEY,nameRestaurant TEXT,descriptionRestaurant TEXT,addressRestaurant TEXT,phoneNumberRestaurant TEXT,tagsRestaurant TEXT,rate TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Restaurant table created.")
            } else {
                print("Restaurant table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
  
    
    
    func insert(nameRestaurant:String, descriptionRestaurant:String, addressRestaurant:String, phoneNumberRestaurant:String, tagsRestaurant:String,
        rate:String)
    {
        let restaurant = read()
 
        let insertStatementString = "INSERT INTO Restaurant (Id, nameRestaurant, descriptionRestaurant, addressRestaurant, phoneNumberRestaurant, tagsRestaurant, rate  ) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(restaurant.count))
            sqlite3_bind_text(insertStatement, 2, (nameRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (descriptionRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (addressRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (phoneNumberRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (tagsRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (rate as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
 
    func read() -> [Restaurant] {
        let queryStatementString = "SELECT * FROM Restaurant;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Restaurant] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let nameRestaurant = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let descriptionRestaurant = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let addressRestaurant = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let phoneNumberRestaurant = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let tagsRestaurant = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let rate = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                

                

                psns.append(Restaurant(id: Int(id), nameRestaurant: nameRestaurant, descriptionRestaurant: descriptionRestaurant, addressRestaurant: addressRestaurant, phoneNumberRestaurant: phoneNumberRestaurant, tagsRestaurant: tagsRestaurant,rate: rate))
                print("Query Result:")
                print("\(id) | \(nameRestaurant) | \(descriptionRestaurant)| \(addressRestaurant) | \(phoneNumberRestaurant) | \(tagsRestaurant) | \(rate)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
  
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM Restaurant WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func update(id: Int, newValue: Restaurant) {
        let updateStatementString = "UPDATE Restaurant SET nameRestaurant = ?, descriptionRestaurant = ?, addressRestaurant = ?, phoneNumberRestaurant = ?, tagsRestaurant = ?, rate = ? WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (newValue.nameRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (newValue.descriptionRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (newValue.addressRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (newValue.phoneNumberRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (newValue.tagsRestaurant as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (newValue.rate as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 7, Int32(id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully update row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }
   
}
