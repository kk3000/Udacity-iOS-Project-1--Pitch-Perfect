//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Karthik Kannan on 3/17/15.
//  Copyright (c) 2015 Karthik Kannan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String){
        self.title = title
        self.filePathUrl = filePathUrl        
    }
}
