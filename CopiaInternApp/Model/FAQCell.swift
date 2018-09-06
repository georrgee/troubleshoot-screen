//
//  FAQCell.swift
//  CopiaInternApp
//  Created by George Garcia on 9/4/18.
//  Copyright © 2018 GeeTeam. All rights reserved.
//
//  Description: With the FAQCell.swift file, here is where the cell is created and what attributes it holds for each cell

import UIKit

class FAQCell: UITableViewCell {
    
    // Creating the cell
    let cellView: UIView = {
        let cView = UIView()
        cView.backgroundColor = UIColor.white
        cView.setCellShadow()
        return cView
    }()
    
    // Creating the label for the question
    let questionLabel: UILabel = {
        let qt = UILabel()
        qt.text = "Yo Testing"
        qt.textColor = .black
        qt.font = UIFont.systemFont(ofSize: 16)
        return qt
    }()
    
    // Creating the answer label
    let answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Under Testing!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // Creating Image Views for an up arrow and down arrow
    let upArrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "arrowUpiOS")
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let downArrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "arrowDowniOS")
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setDownArrow()
        setupCellView()
        setupQuestionLabel()
        setupAnswerLabel()
    }
    
    func setLabels(content: CellContent){
        self.questionLabel.text = content.question
        self.answerLabel.text = content.expanded ? content.answer : ""
    }
    
    //All functions below adds all views to TroubleShootViewController and setups constraints to position it perfectly
    func setupCellView(){
        addSubview(cellView)
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
    }
    //
    func setDownArrow(){
        addSubview(downArrowImageView)
        downArrowImageView.setAnchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        downArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true // positioning in the center
    }
    
    func setupQuestionLabel(){
        
        addSubview(questionLabel)
        questionLabel.setAnchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 66.8, paddingLeft: 40, paddingBottom: 0, paddingRight: 40)
        //questionTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupAnswerLabel(){
        addSubview(answerLabel)
        answerLabel.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 80, paddingRight: 65)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemnted")
    }
}
