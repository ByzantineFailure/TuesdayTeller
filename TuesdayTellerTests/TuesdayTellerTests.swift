//
//  TuesdayTellerTests.swift
//  TuesdayTellerTests
//
//  Are you being told the right things about Tuesday?  Let's find out.
//
//  Created by Michael Eaton on 12/23/16.
//  Copyright © 2016 Michael Eaton. All rights reserved.
//

import XCTest
@testable import TuesdayTeller
class TuesdayTellerTests: XCTestCase {
    var vc: ViewController!;
    var dateFormat: DateFormatter!;
    
    override func setUp() {
        super.setUp();
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        vc = storyboard.instantiateInitialViewController() as! ViewController;
        
        dateFormat = DateFormatter.init();
        dateFormat.dateFormat = "YYYY-MM-dd";
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNextTuesday() {
        let expectedResult = dateFormat.date(from: "2016-12-27")!;
        let sunday = dateFormat.date(from: "2016-12-25")!;
        let monday = dateFormat.date(from: "2016-12-26")!;
        let tuesday = dateFormat.date(from: "2016-12-27")!;
        let wednesday = dateFormat.date(from: "2016-12-21")!;
        let thursday = dateFormat.date(from: "2016-12-22")!;
        let friday = dateFormat.date(from: "2016-12-23")!;
        let saturday = dateFormat.date(from: "2016-12-24")!;
        
        XCTAssertEqual(vc.getNextTuesday(sunday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(monday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(tuesday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(wednesday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(thursday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(friday), expectedResult);
        XCTAssertEqual(vc.getNextTuesday(saturday), expectedResult);
    }
    
    func testTuesdayNumber() {
        let firstTuesday = dateFormat.date(from: "2016-12-06")!;
        let secondTuesday = dateFormat.date(from: "2016-12-13")!;
        let thirdTuesday = dateFormat.date(from: "2016-12-20")!;
        let fourthTuesday = dateFormat.date(from: "2016-12-27")!;
        let fifthTuesday = dateFormat.date(from: "2016-11-29")!;
        
        XCTAssertEqual(vc.getTuesdayNumber(firstTuesday), 1);
        XCTAssertEqual(vc.getTuesdayNumber(secondTuesday), 2);
        XCTAssertEqual(vc.getTuesdayNumber(thirdTuesday), 3);
        XCTAssertEqual(vc.getTuesdayNumber(fourthTuesday), 4);
        XCTAssertEqual(vc.getTuesdayNumber(fifthTuesday), 5);
    }
    
    func testSideOfStreet() {
        XCTAssertEqual(vc.getParkSide(1), ViewController.PARK_NEAR_HOUSE);
        XCTAssertEqual(vc.getParkSide(2), ViewController.PARK_FAR_SIDE);
        XCTAssertEqual(vc.getParkSide(3), ViewController.PARK_NEAR_HOUSE);
        XCTAssertEqual(vc.getParkSide(4), ViewController.PARK_FAR_SIDE);
        XCTAssertEqual(vc.getParkSide(5), ViewController.PARK_WHEREVER);
    }
}
