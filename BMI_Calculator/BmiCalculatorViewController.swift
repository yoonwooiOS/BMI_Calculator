//
//  BmiCalculatorViewController.swift
//  BMI_Calculator
//
//  Created by 김윤우 on 5/21/24.
// BMI 계산 방법 : 체중 / 신장^2
// 1. 버튼을 누른다
// 2. textField의 값이 bmiCalculate로 들어간다
// 3. 계산한 값을 반환해서 알럿창에 띄워준다.

// texfield.text 값을 변수에 저장
// Doulbe 타입으로 타입 캐스팅 과정에서 옵셔널 바인딩
//
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
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var BmiCalulatorImage: UIImageView!
    
    @IBOutlet var resetButton: UIButton!
    
    var uesrHeight = ""
    var userWeight = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.text = "\(UserDefaults.standard.double(forKey: "키"))"
        weightTextField.text = "\(UserDefaults.standard.double(forKey: "몸무게"))"
        
        
        labelUiDesign(labelName: userName, labelText: "김윤우님", labelTextColor: .black, textAlignment: .left, fontSize: 30)
        labelUiDesign(labelName: titleLabel, labelText: "BMI Calculator", labelTextColor: .black, textAlignment: .left, fontSize: 21)
        labelUiDesign(labelName: subTitleLable, labelText: "당신의 BMI 지수를\n알려드릴게요.", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        
        labelUiDesign(labelName: heightQuestionLabel, labelText: "키가 어떻게 되시나요?", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        labelUiDesign(labelName: weightQuestionLabel, labelText: "몸무게는 어떻게 되시나요?", labelTextColor: .black, textAlignment: .left, fontSize: 15)
        
        buttonUiDesign(buttonLabelName: randomBmiButton, buttontitle: "랜덤으로 BMI 계산하기", backGroundColor: .white, tintColor: .red, titleFontSize: 12)
        buttonUiDesign(buttonLabelName: bmiCalculateResultButton, buttontitle: "결과 확인 및 저장", backGroundColor: .purple, tintColor: .white, titleFontSize: 17)
        
        buttonUiDesign(buttonLabelName: resetButton, buttontitle: "몸무게, 키, 이름 초기화", backGroundColor: .red, tintColor: .white, titleFontSize: 17)
        
        
        imangeUiDesign(imageViewName: BmiCalulatorImage, imageName: "image", contentmode: .scaleAspectFill)
        
        textFieldUiDesgin(textFieldName: weightTextField, placeHolderText: "ex)60, 60.0")
        textFieldUiDesgin(textFieldName: heightTextField, placeHolderText: "ex) 176, 178.2")
        
    
        
    }
    
    @IBAction func heightTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            uesrHeight = text
        }
    }
    
    
    @IBAction func weightTextField(_ sender: UITextField) {
        
        if let text = sender.text {
            userWeight = text
        }
    }


    @IBAction func resultButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        if let finalheight = Double(uesrHeight),
           let finalweight = Double(userWeight) {
            print(finalheight)
            print(finalweight)
            let bmi = bmiCalculate(calculateWeight: finalweight, calculateHeight: finalheight )
            
            let alert = UIAlertController(title: String(format: "%.2f", bmi) + "점", message: nil, preferredStyle: .alert)
            
            let open = UIAlertAction(title: "확인", style: .default)
            let cancel = UIAlertAction(title: "취소", style: .destructive)
            
            alert.addAction(open)
            alert.addAction(cancel)
            
            present(alert, animated: true)
            
            UserDefaults.standard.set(finalweight, forKey: "몸무게")
            UserDefaults.standard.set(finalheight, forKey: "키")
            
        }
    }

        
        
    @IBAction func resetButton(_ sender: UIButton) {
        weightTextField.text = ""
        heightTextField.text = ""
        userName.text = ""
//        UserDefaults.standard.set( weightTextField.text , forKey: "몸무게")
//        UserDefaults.standard.set( heightTextField.text, forKey: "키")
        
    }
    
    
    @IBAction func randomBmi(_ sender: UIButton) {
        let randomHeight = Double.random(in: 130...220)
        let randomWeight = Double.random(in: 30...200)
        
        let bmi = bmiCalculate(calculateWeight: randomWeight, calculateHeight: randomHeight)
        
        let alert = UIAlertController(title: String(format: "%.2f", bmi) + "점", message: nil, preferredStyle: .alert)
        
        let open = UIAlertAction(title: "확인", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(open)
        alert.addAction(cancel)
        
        
        present(alert, animated: true)
        
        
        
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    func labelUiDesign(labelName name:UILabel, labelText text:String, labelTextColor color:UIColor, textAlignment alignment:NSTextAlignment, fontSize:Int) {
        name.text = "\(text)"
        name.textColor = color
        name.textAlignment = alignment
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
    func bmiCalculate(calculateWeight weight: Double, calculateHeight height: Double) -> Double {
//        print(weight)
//        print(height)
     let bmiCalculateWeight = weight
     let bmiCalculateHeight = height
//        print(btnweight)
//        print(btnweight)
        let convertMeterHeight = bmiCalculateHeight / 100
//        print(sheight, "---")
        let bmiresult = bmiCalculateWeight / (convertMeterHeight * convertMeterHeight)
//        print(bmiresult)
        return bmiresult
        
    }
    
}
