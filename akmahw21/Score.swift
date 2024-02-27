//
//  Score.swift
//  akmahw21
//
//  Created by Swift on 26.02.2024.
//

import UIKit

class ScoreLabel: UILabel{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.textColor = .myGreen
        self.text = "Score: 0"
        self.font = .systemFont(ofSize: 20)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
