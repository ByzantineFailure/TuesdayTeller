//
//  ViewController.swift
//  Tuesday Teller
//
//  Created by Michael Eaton on 12/22/16.
//  Copyright © 2016 Michael Eaton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let calendar = Calendar(identifier: Calendar.Identifier.gregorian);
    
    static let PARK_NEAR_HOUSE = "Park on the house side of the street";
    static let PARK_FAR_SIDE = "Park on the far side of the street";
    static let PARK_WHEREVER = "Park wherever.  Maybe the woods?";
    
    //MARK: Properties
    @IBOutlet weak var tuesdayNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var parkOnLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    //MARK: Actions
    @IBAction func refreshClicked(_ sender: Any) {
        print("Refresh clicked");
        updateUI();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        updateUI();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func updateUI() {
        let today = Date();
        let nextTuesday = getNextTuesday(today);
        let tuesdayNumber = getTuesdayNumber(nextTuesday);
        let parkMessage = getParkSide(tuesdayNumber);
        dateLabel.text = getDateString(nextTuesday);
        tuesdayNumberLabel.text = String(tuesdayNumber);
        parkOnLabel.text = parkMessage;
    }
    
    // (Intentionally) Returns today if it is a Tuesday
    func getNextTuesday(_ startDate: Date) -> Date{
        let dayOfWeek = getDayOfWeek(startDate);
        
        let diff = dayOfWeek - 3;
        let delta = diff < 0 ? diff * -1 : 7 - diff;
        
        return addDays(startDate, number: delta);
    }
    
    func addDays(_ date: Date, number: Int) -> Date {
        return ViewController.calendar.date(byAdding: Calendar.Component.day, value: number, to: date)!;
    }
    
    func getDayOfWeek(_ date: Date) -> Int {
        return ViewController.calendar.component(.weekday, from: date);
    }
    
    func getMonth(_ date: Date) -> Int {
        return ViewController.calendar.component(.month, from: date);
    }
    
    func getDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "MMMM dd";
        return dateFormatter.string(from: date);
    }
    
    // There is probably a better way to do this.  Whatever, it's 4 iterations max.
    func getTuesdayNumber(_ tuesdayDate: Date) -> Int {
        var tuesdayCount = 1;
        var testDate = addDays(tuesdayDate, number: -7);
        let month = getMonth(tuesdayDate);
        
        while(getMonth(testDate) == month) {
            tuesdayCount += 1;
            testDate = addDays(testDate, number: -7);
        }
        
        return tuesdayCount;
    }
    
    func getParkSide(_ tuesdayNumber: Int) -> String {
        if (tuesdayNumber == 5) {
            return ViewController.PARK_WHEREVER;
        }
        return tuesdayNumber % 2 == 1 ? ViewController.PARK_NEAR_HOUSE : ViewController.PARK_FAR_SIDE;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

