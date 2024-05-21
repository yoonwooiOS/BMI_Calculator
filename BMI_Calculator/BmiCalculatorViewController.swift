//
//  BmiCalculatorViewController.swift
//  BMI_Calculator
//
//  Created by 김윤우 on 5/21/24.
// BMI 계산 방법 : 체중 / 신장^2
// 1. 버튼을 누른다
// 2. textField의 값이 bmiCalculate로 들어간다
// 3. 계산한 값을 반환해서 알럿창에 띄워준다.
import UIKit

class BmiCalculatorViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLable: UILabel!
    @IBOutlet var heightQuestionLabel: UILabel!
    @IBOutlet var weightQuestionLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var randomBmiButton: UIButton!
    
    @IBOutlet var bmiCalculateResultButton: UIButton!
    
    @IBOutlet var BmiCalulatorImage: UIImageView!
    
    var userWeight:String = ""
    var userHeight:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelUiDesign(labelName: titleLabel, labelText: "BMI Calculator", labelTextColor: .black, textAlignment: .left, fontSize: 21)
        labelUiDesign(labelName: subTitleLable, labelText: "당신의 BMI 지수를\n알려드릴게요.", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        
        labelUiDesign(labelName: heightQuestionLabel, labelText: "키가 어떻게 되시나요?", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        labelUiDesign(labelName: weightQuestionLabel, labelText: "몸무게는 어떻게 되시나요?", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        
        buttonUiDesign(buttonLabelName: randomBmiButton, buttontitle: "랜덤으로 BMI 계산하기", backGroundColor: .white, tintColor: .red, titleFontSize: 12)
        buttonUiDesign(buttonLabelName: bmiCalculateResultButton, buttontitle: "결과 확인", backGroundColor: .purple, tintColor: .white, titleFontSize: 17)
        
        imangeUiDesign(imageViewName: BmiCalulatorImage, imageName: "image", contentmode: .scaleAspectFill)
        
        textFieldUiDesgin(textFieldName: weightTextField, placeHolderText: "ex)60, 60.0")
        textFieldUiDesgin(textFieldName: heightTextField, placeHolderText: "ex) 176, 178.2")
        
    }
    
    @IBAction func heightTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            // 옵셔널 타입이 아닐 때 입력 값이 없을 때
            if text.count == 0 {
                sender.layer.borderColor = UIColor.red.cgColor
                sender.layer.borderWidth = 1.0
                sender.placeholder = "키를 입력해주세요"
                userHeight = ""
            } else {
                // 값이 있을 때
                userHeight = text
            }
        } else {
            // 옵셔널 타입일 때
            print("옵셔널 타입입니다.")
        }
        
    }
    
    
    @IBAction func weightTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            // 입력값이 있을 때
            if text.count == 0 {
                // 입력값이 없을 때
                sender.layer.borderColor = UIColor.red.cgColor
                sender.layer.borderWidth = 1.0
                sender.placeholder = "몸무게를 입력해주세요"
                userWeight = ""
            } else {
                userWeight = text
            }
        } else {
            // 옵셔널 타입일 때
            print("옵셔널 타입입니다.")
        }
    }
    
    
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        if let height = Double(userHeight) {
            if let weight = Double(userWeight) {
                let bmi = bmiCalculate(weight: weight, height: height)
                
                let alert = UIAlertController(title: String(format: "%.2f", bmi) + "점", message: nil, preferredStyle: .actionSheet)
                
                let open = UIAlertAction(title: "확인", style: .default)
                let cancel = UIAlertAction(title: "취소", style: .destructive)
                
                alert.addAction(open)
                alert.addAction(cancel)
                                
                present(alert, animated: true)
                
                
            } else {
                print("weight이 옵셔널 타입니다")
            }
        } else {
            print("height이 옵셔널 타입입니다")
        }
    }
    
    
    @IBAction func randomBmi(_ sender: UIButton) {
        let randomHeight = Double.random(in: 130...220)
        let randomWeight = Double.random(in: 30...200)
        
        let bmi = bmiCalculate(weight: randomWeight, height: randomHeight)
        
        let alert = UIAlertController(title: String(format: "%.2f", bmi) + "점", message: nil, preferredStyle: .actionSheet)
        
        let open = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(open)
        alert.addAction(cancel)
        
        
        present(alert, animated: true)
        
        
        
    }
    
    
    
    
    func labelUiDesign(labelName name:UILabel, labelText text:String, labelTextColor color:UIColor, textAlignment alignment:NSTextAlignment, fontSize:Int) {
        name.text = "\(text)"
        name.textColor = color
        name.textAlignment = alignment
        //        name.font = UIFont.boldSystemFont(ofSize: fontSize)
        name.font = .systemFont(ofSize: CGFloat(fontSize))
        name.numberOfLines = 0
    }
    func buttonUiDesign(buttonLabelName name:UIButton, buttontitle title:String, backGroundColor color:UIColor, tintColor titleColor:UIColor , titleFontSize size:Int) {
        name.setTitle(title, for: .normal)
        name.backgroundColor = color
        name.tintColor = titleColor
        name.layer.cornerRadius = 15
        name.titleLabel?.font = .systemFont(ofSize: CGFloat(size))
    }
    
    func imangeUiDesign(imageViewName name:UIImageView, imageName:String, contentmode:UIView.ContentMode ) {
        name.image = UIImage(named: imageName)
        name.contentMode = contentmode
    }
    
    func textFieldUiDesgin(textFieldName:UITextField, placeHolderText text:String) {
        textFieldName.placeholder = text
        textFieldName.keyboardType = .decimalPad
        textFieldName.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        // leftViewMode를 설정하지 않으면 적용되지 않음
        textFieldName.leftViewMode = .always
        textFieldName.borderStyle = .roundedRect
        textFieldName.layer.borderWidth = 1
        textFieldName.layer.cornerRadius = 12
        
    }
    func bmiCalculate(weight: Double, height: Double) -> Double {
        let height = height / 100
        return weight / (height * height)
    }
    
}
