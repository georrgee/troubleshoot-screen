//
//  FAQCell.swift
//  CopiaInternApp
//  Created by George Garcia on 9/4/18.
//  Copyright © 2018 GeeTeam. All rights reserved.
//
//  Description: With the FAQCell.swift file, here is where the cell is created and what attributes it holds for each cell

import UIKit

class FAQCell: UITableViewCell {
    var contentItem: CellContent? {
        didSet {
            self.updateUI()
        }
    }
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
        //qt.text = "Yo Testing"
        qt.textColor = .black
        qt.font = UIFont.systemFont(ofSize: 16)
        return qt
    }()
    
    // Creating the answer label
    let answerLabel: UILabel = {
        let label = UILabel()
        //label.text = "Under Testing!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // Creating Image Views for an up arrow and down arrow
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
        
        self.questionLabel.bottomAnchor.constraint(equalTo: self.answerLabel.topAnchor, constant: -20).isActive = true
        self.backgroundColor = UIColor(displayP3Red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        self.selectionStyle = .none
    }
    
    func updateUI() {
        guard let content = self.contentItem else { return }
        self.questionLabel.text = content.question
        self.answerLabel.text = content.expanded ? content.answer : ""
        setDownArrow()
        self.downArrowImageView.transform = content.expanded ? CGAffineTransform(rotationAngle: .pi) : .identity // spins the arrow 180 degrees when tapped
    }
    
    //All functions below adds all views to TroubleShootViewController and setups constraints to position it perfectly
    func setupCellView(){
        addSubview(cellView)
        cellView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
    func setDownArrow(){
        addSubview(downArrowImageView)
        downArrowImageView.setAnchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        downArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true // positioning in the center
    }
    
    func setupQuestionLabel(){
        questionLabel.numberOfLines = 0 // That way text can be wrapped around
        addSubview(questionLabel)
        questionLabel.setAnchor(top: cellView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 80, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
    }
    
    func setupAnswerLabel(){
        answerLabel.numberOfLines = 0
        addSubview(answerLabel)
        answerLabel.setAnchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 80, paddingRight: 65, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemnted")
    }
}
