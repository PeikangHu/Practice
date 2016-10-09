//: Playground - noun: a place where people can play

import UIKit

// NSNumber is a flyweight pattern.
let num1 = NSNumber(value: 10)
let num2 = NSNumber(value: 10)

print("Comparison: \(num1 == num2)")
print("Identity: \(num1 === num2)")

class LogItem
{
    var from:String?
    @NSCopying var data:NSArray?
}

var dataArray = NSMutableArray(array: [1,2,3,4]);

var logItem = LogItem()
logItem.from = "Alice"
logItem.data = dataArray

dataArray[1] = 10
print("Value: \(logItem.data![1])")

class Person: NSObject, NSCopying
{
    var name:String
    var country:String
    
    init(name:String, country:String)
    {
        self.name = name
        self.country = country
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Person(name: self.name, country: self.country)
    }
}

var data = NSMutableArray(objects: 10, "iOS", Person(name:"Joe", country:"USA"))
var copiedData = data;
data[0] = 20
data[1] = "MacOS"
(data[2] as! Person).name = "Alice"

print("Identity: \(data === copiedData)")
print("0: \(copiedData[0]) 1: \(copiedData[1]) 2: \((copiedData[2] as AnyObject).name)")



func deepCopy(data:[Any]) -> [Any]
{
    return data.map(
        {
            item -> Any in
            if (item is NSCopying && item is NSObject)
            {
                return (item as! NSObject).copy()
            }
            else
            {
                return item
            }
    })
}

var people = [Person(name:"Joe", country:"France"),
              Person(name:"Bob", country:"USA")]

var otherpeople = deepCopy(data: people as [Person])

people[0].country = "UK"
print("Country: \(((otherpeople[0] as Any) as AnyObject).country)")

struct Appointment
{
    var name:String
    var day:String
    var place:String
    
    func printDetails(label:String)
    {
        print("\(label) with \(name) on \(day) at \(place)")
    }
}

var beerMeeting = Appointment(name:"Bob", day:"Mon", place:"Joe's Bar")

var workingMeeting = beerMeeting
workingMeeting.name = "Alice"
workingMeeting.day = "Fri"
workingMeeting.place = "Conference Rm 2"

beerMeeting.printDetails(label: "Social")
workingMeeting.printDetails(label: "Work")

class AppointmentClass: NSObject, NSCopying
{
    var name:String
    var day:String
    var place:String
    
    init(name:String, day:String, place:String)
    {
        self.name = name
        self.day = day
        self.place = place
    }
    
    func printDetails(label:String)
    {
        print("\(label) with \(name) on \(day) at \(place)")
    }
    
    func copy(with zone: NSZone?) -> Any {
        return Appointment(name:self.name, day:self.day, place:self.place)
    }
}



var beerMeetingClass = AppointmentClass(name: "Bob", day: "Mon", place: "Joe's Bar");
var workingMeetingClass = beerMeetingClass.copy() as! Appointment

workingMeetingClass.name = "Alice"
workingMeetingClass.day = "Fri"
workingMeetingClass.place = "Conference Rm 2"

beerMeetingClass.printDetails(label: "Social")
workingMeetingClass.printDetails(label: "Work")




