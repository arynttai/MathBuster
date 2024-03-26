import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var timer:Timer?
    var maxTime: Float = 30
//    lazy var num1 = Int.random(in: 1...10)
//    lazy var signs = ["+", "-", "/", "*"]
//    lazy var randomIndex = Int.random(in: 0..<signs.count)
//    lazy var sign = signs[randomIndex]
//    lazy var  num2 = Int.random(in: 1...10)
    var firstRandom: Int = 0
    var secondRandom: Int = 0
    var correctAnswer: Int = 0
    var scoreValue: Int = 0
    lazy var score = ScoreLabel()
    
    lazy var welcome: UILabel = {
        let label =  UILabel()
        label.text = "< Добро пожаловать!"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .myGreen
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label =  UILabel()
        label.text = "Math Buster"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .myGreen
        return label
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Easy🤩", "Medium🥲", "Hard🥵"])
        view.selectedSegmentIndex = 0
        view.selectedSegmentIndex = 1
        view.selectedSegmentIndex = 2
        view.selectedSegmentTintColor = .myGreen
        view.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], for: .normal)
        view.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return view
    }()

//    lazy var score: UILabel = {
//        let label =  UILabel()
//        label.text = "Score: 0"
//        label.font = .systemFont(ofSize: 20)
//        label.textColor = .myGreen
//        return label
//    }()
//
    lazy var emoji: UILabel = {
        let label =  UILabel()
        label.text = "👾"
        label.font = .systemFont(ofSize: 50)
        label.textColor = .black
        return label
    }()
    
    lazy var timer1: UILabel = {
        let label =  UILabel()
        label.text = "00:0"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .myGreen
        return label
    }()
    
    
    lazy var oper: UILabel = {
        let label =  UILabel()
//        label.text = String(num1) + sign + String(num2) + "="
        label.text = "нажмите на'Restart'"

        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .myGreen
        return label
    }()

    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .init(UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 1))
        view.setProgress(0.3, animated: true)
        return view
    }()
    
    lazy var result: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "                     Result"
        field.font = .systemFont(ofSize: 30)
        return field
    }()
    
    lazy var submit: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .myGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(checkCorrect), for: .touchUpInside)
        return button
    }()
    
    lazy var restart: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.myGreen, for: .normal)
        button.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)
        return button
    }()



    lazy var voidView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 0.3)
        view.layer.cornerRadius = 4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 236/255, green: 227/255, blue: 206/255, alpha: 1)
        startTime()
        setUI()
        
    }
    
    func setUI(){
        view.addSubview(nameLabel)
        view.addSubview(segmentControl)
        view.addSubview(emoji)
        view.addSubview(score)
        view.addSubview(progressView)
        view.addSubview(result)
        view.addSubview(oper)
        view.addSubview(submit)
        view.addSubview(restart)
        view.addSubview(timer1)
        view.addSubview(voidView)
        view.addSubview(welcome)
        
        
        
        welcome.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().inset(12)
            
        }
        
        
        nameLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(175)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        score.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(220)
        }
        
        
        emoji.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
        }
        
        oper.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(310)
        }
        timer1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(370)
        }
        
        
        progressView.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(410)
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(8)
        }
        voidView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(360)
            make.height.equalTo(80)
            make.leading.trailing.equalToSuperview()
                .inset(12)
        }
        
        
        result.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(450)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
            
        }
        submit.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(530)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
            
        }
        restart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(580)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(50)
            
        }
    }
    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        
    }
    
    @objc func run() {
        self.maxTime -= 1
        print(self.maxTime)
        
        if self.maxTime <= 0 {
            timer?.invalidate()
        }

        self.progressView.setProgress(Float(self.maxTime/30), animated: true)
        timer1.text = String(format: "%02d:%02d", Int(maxTime) / 60, Int(maxTime) % 60)
    }
    @objc func segmentChanged(sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            firstRandom = Int.random(in: 0...9)
            secondRandom = Int.random(in: 0...9)
        } else if segmentControl.selectedSegmentIndex == 1 {
            firstRandom = Int.random(in: 10...99)
            secondRandom = Int.random(in: 10...99)
        } else {
            firstRandom = Int.random(in: 100...999)
            secondRandom = Int.random(in: 100...999)
        }
        oper.text = "\(firstRandom) \(["+", "-", "*", "/"].randomElement()!) \(secondRandom) = "
    }


    @objc func checkCorrect() {
         guard let userInput = result.text, !userInput.isEmpty else {
             return
         }
         if let userAnswer = Int(userInput) {
             let operation: String = oper.text ?? ""
             var correctAnswer = 0

             if operation.contains("+") {
                 correctAnswer = firstRandom + secondRandom
             } else if operation.contains("-") {
                 correctAnswer = firstRandom - secondRandom
             } else if operation.contains("/") {
                 correctAnswer = firstRandom / secondRandom
             } else if operation.contains("*") {
                 correctAnswer = firstRandom * secondRandom
             }

             if userAnswer == correctAnswer {
                 scoreValue += 1
                 score.text = "Score: \(scoreValue)"
             }
             result.text = ""
         }
     }
 }
    
    
    extension UIColor {
        static let myGreen = UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 1)
        static let myBiege = UIColor.init(red: 236/255, green: 227/255, blue: 206/255, alpha: 1)
    }

