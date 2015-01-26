//
//  AppDelegate.swift
//  Mac Simple Bike Computer
//
//  Created by Falko Richter on 16/10/14.
//  Copyright (c) 2014 Falko Richter. All rights reserved.
//

import Cocoa
import CoreBluetooth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CadenceDelegate {

    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var totalDistanceTextField: NSTextField!
    @IBOutlet weak var speedTextField: NSTextField!
    @IBOutlet weak var crankRevolutionsTextField: NSTextField!
    
    var heartBeatPeripheral: HeartBeatPeripheral?
    
    var peripheralManager:CBPeripheralManager!
    
    
    override init() {
        println("init")
        super.init()
    }
    
    var cadenceConnector = CadenceConnector()
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        cadenceConnector.delegate = self
    }
    
    func distanceDidChange(cadence: CadenceConnector!, totalDistance : Double! ){
        dispatch_async(dispatch_get_main_queue(), {
            self.totalDistanceTextField.doubleValue = totalDistance
        });
    }
    
    func speedDidChange(cadence: CadenceConnector!, speed: Double!) {
        dispatch_async(dispatch_get_main_queue(), {
            self.speedTextField.doubleValue = speed
        });
    }
    
    func crankFrequencyDidChange(cadence: CadenceConnector!, crankRevolutionsPerMinute : Double! ){
        dispatch_async(dispatch_get_main_queue(), {
            self.crankRevolutionsTextField.doubleValue = crankRevolutionsPerMinute
        });
    }
    
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        heartBeatPeripheral!.stopBroadcasting()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(theApplication: NSApplication!) -> Bool{
        return true;
    }
    
    
    
    @IBAction func becomeHeartRateSensor(AnyObject){
        heartBeatPeripheral = HeartBeatPeripheral()        
        heartBeatPeripheral!.startBroadcasting();
        
    }
}

