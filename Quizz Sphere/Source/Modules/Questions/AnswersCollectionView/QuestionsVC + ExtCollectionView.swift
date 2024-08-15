//
//  QuestionsVC + ExtCollectionView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 13.08.24.
//

import UIKit

extension QuestionsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let question = viewModel.quiz.questions?[viewModel.questionIndex]
        
        let answer = question?.answers[indexPath.row]
        
        if viewModel.questionIndex != 11 {
            let nextQuestion = viewModel.quiz.questions?[viewModel.questionIndex + 1]
            animateQuestionAndAnswers() { [weak self] in
                if answer?.isCorrect == true {
                    self?.handleCorrectAnswerTap(withCoins:  self?.viewModel.scoresOnQuiz ?? 0,
                                           question: nextQuestion?.description ?? "",
                                           buttonTitle: LabelValues.Scenes.Questions.next,
                                           questionIsLast: false)
                } else {
                    self?.handleInCorrectAnswerTap(withQuestion: nextQuestion?.description ?? "",
                                             buttonTitle: LabelValues.Scenes.Questions.next,
                                             questionIsLast: false)
                    
                    self?.viewModel.setZeroToScore()
                }
                self?.viewModel.setPropertiesIfAnswerIsNotLast()
            }
        } else {
            handleQuizCompletion(isCorrect: answer?.isCorrect ?? false,
                                 coins: viewModel.scoresOnQuiz,
                                 question: question?.description ?? "")
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension QuestionsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.answersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswersCell.identifier, for: indexPath) as! AnswersCell
        let questionIndex = viewModel.questionIndex
        
        let answer = viewModel.quiz.questions?[questionIndex].answers[indexPath.row]
        
        cell.configure(withAnswer: answer!)
        
        return cell
    }
}

extension QuestionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width / 2 - 10
        let height: CGFloat = collectionView.frame.size.height / 2 - 5
        return CGSize(width: width, height: height)
    }
}
