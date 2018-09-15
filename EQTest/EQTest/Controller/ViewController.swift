//
//  ViewController.swift
//  EQTest
//
//  Created by 刘铭 on 2018/1/27.
//  Copyright © 2018年 刘铭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerOneButton: UIButton!
  @IBOutlet weak var answerTwoButton: UIButton!
  @IBOutlet weak var answerThreeButton: UIButton!
  @IBOutlet weak var progressBar: UIView!
  @IBOutlet weak var progressLabel: UILabel!
  
  let allQuestions = QuestionBank()
  var pickedAnswer: Int = 0
  var questionNumber: Int = 0
  var score: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    answerOneButton.layer.cornerRadius = 25
    answerTwoButton.layer.cornerRadius = 25
    answerThreeButton.layer.cornerRadius = 25
    
    nextQuestion()
  }

  @IBAction func answerPressed(_ sender: UIButton) {
    
    pickedAnswer = sender.tag - 1

    checkAnswer()
    
    questionNumber += 1
    
    nextQuestion()
  }
  
  
  func nextQuestion() {
    if questionNumber <= 28 {
      questionLabel.text = allQuestions.list[questionNumber].questionText
      
      answerOneButton.isHidden = true
      answerTwoButton.isHidden = true
      answerThreeButton.isHidden = true
      
      for (index, option) in allQuestions.list[questionNumber].questionOption.enumerated() {
        if index == 0 {
          answerOneButton.isHidden = false
          answerOneButton.setTitle(option, for: UIControlState.normal)
        }else if index == 1 {
          answerTwoButton.isHidden = false
          answerTwoButton.setTitle(option, for: UIControlState.normal)
        }else if index == 2 {
          answerThreeButton.isHidden = false
          answerThreeButton.setTitle(option, for: UIControlState.normal)
        }
      }
      
      updateUI()
    }else {
      var title = ""
      var message = ""
      if score < 70 {
        title = "你的EQ较低"
        message = "你常常不能控制自己，你极易被自己的情绪所影响。很多时候，你轻易被击怒、动火、发脾气，这是非常危险的信号 ── 你的事业可能会毁于你的暴躁。对于此最好的解决办法是能够给不好的东西一个好的解释保持头脑冷静使自己心情开朗。"
      }else if score >= 70 && score < 109 {
        title = "你的EQ一般"
        message = "对于一件事，你不同时候的表现可能不一，这与你的意识有关，你比前者更具有EQ意识，但这种意识不是常常都有，因此需要你多加注重、时时提醒。"
      }else if score >= 110 && score < 129 {
        title = "你的EQ较高"
        message = "你是一个快乐的人，不易恐惊担忧，对于工作你热情投入、敢于负责，你为人更是正义正直、同情关怀，这是你的长处，应该努力保持。"
      }else if score >= 130 {
        title = "你就是个EQ高手"
        message = "你的情绪聪明不但是你事业的阻碍，更是你事业有成的一个重要前提条件。"
      }
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      let restartAction = UIAlertAction(title: "重新开始", style: .default, handler: { (alertAction) in self.startOver() })
      
      alert.addAction(restartAction)
      present(alert, animated: true, completion: nil)
    }
  }
  
  func updateUI() {
    progressLabel.text = "\(questionNumber + 1) / 29"
    
    progressBar.frame.size.width = (view.frame.size.width / 29) * CGFloat(questionNumber + 1)
  }
  
  func checkAnswer() {
    score = score + allQuestions.list[questionNumber].questionScore[pickedAnswer]
  }
  
  func startOver() {
    score = 0
    questionNumber = 0
    nextQuestion()
  }
}

