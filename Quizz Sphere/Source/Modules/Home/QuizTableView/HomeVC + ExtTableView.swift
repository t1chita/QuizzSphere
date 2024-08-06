//
//  HomeVC + ExtTableView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 05.08.24.
//

import UIKit

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.quizzesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCell.identifier, for: indexPath) as! QuizCell
        cell.configure(withQuizImageUrl: "",
                       quizTitle: homeViewModel.quizzes[indexPath.row].name,
                       quizCategory: homeViewModel.quizzes[indexPath.row].category,
                       quizQuantity: homeViewModel.quizzes[indexPath.row].quantity)
        return cell
    }
}
