//
//  Question.swift
//  EQTest
//
//  Created by 刘铭 on 2018/1/27.
//  Copyright © 2018年 刘铭. All rights reserved.
//

import Foundation

class Question {
  let questionText: String
  let questionOption: [String]
  let questionScore: [Int]
  
  init(text: String, option: [String], score: [Int]) {
    questionText = text
    questionOption = option
    questionScore = score
  }
  
}
