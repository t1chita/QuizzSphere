//
//  HomeVC + ExtTableView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 05.08.24.
//

import UIKit

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quiz = homeViewModel.quizzes[indexPath.row]
        didSendEventClosure?(.quizTapped, quiz)
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.quizzesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCell.identifier, for: indexPath) as! QuizCell
        let quiz = homeViewModel.quizzes[indexPath.row]
        cell.configure(withQuiz: quiz)
        return cell
    }
}
