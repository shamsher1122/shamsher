//
//  ViewController.swift
//  Weather
//
//  Created by Apurv Gupta on 25/01/16.
//  Copyright (c) 2016 Apurv Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userCity: UITextField!
    @IBOutlet var resultLabel: UILabel!

    @IBAction func findWeather() {

        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + userCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        println(url)
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
                
                var urlError = false
                var weather = ""
                
                if error == nil {
                    
                    var urlContent = NSString(data: data , encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as! String
                        
                        //for degree symbol
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        
                        
                    } else {
                        self.resultLabel.text = "Was unable to find the weather for" + self.userCity.text + "Please Try Again!!"

                        
                    }
                    
                } else {
                    urlError = true
                    
                }
                dispatch_async(dispatch_get_main_queue()){
                    
                    if urlError == true {
                        self.resultLabel.text = "Was unable to find the weather for" + self.userCity.text + "Please Try Again!!"
                        
                    } else {
                        self.resultLabel.text = weather
                    }
                }
            })
            
            task.resume()
        } else {
            resultLabel.text = "Was unable to find the weather for" + userCity.text + "Please Try Again!!"
        }

        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

