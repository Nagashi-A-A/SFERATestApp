//
//  ViewController.swift
//  SFERATestApp
//
//  Created by Anton Yaroshchuk on 15.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    var timerText: UILabel!
    var bottomTimerText: UILabel!
    var nameTextField: UITextField!
    var timerValueTextField: UITextField!
    var addTimerButton: UIButton!
    var addTimerView: UIView!
    var timers = [CustomTimer]()
    var mainTimer = Timer()
    var subView = UIView()
    var subTableView = UITableView()
    
    
    func loadMyView() {
        view.backgroundColor = .white
        let cgWidth: CGFloat = view.frame.size.width
        let frame = CGRect(x: 0, y: 0, width: cgWidth, height: 300)
        subView.frame = frame
        subView.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        view.addSubview(subView)
        
        let someColor = CGColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        let someTextColor = CGColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        timerText = UILabel()
        timerText.translatesAutoresizingMaskIntoConstraints = false
        timerText.font = UIFont.systemFont(ofSize: 20)
        timerText.textColor = UIColor.init(cgColor: someTextColor)
        timerText.backgroundColor = UIColor.init(cgColor: someColor)
        timerText.text = "Добавление таймеров"
        subView.addSubview(timerText)
        
        bottomTimerText = UILabel()
        bottomTimerText.translatesAutoresizingMaskIntoConstraints = false
        bottomTimerText.font = UIFont.systemFont(ofSize: 20)
        bottomTimerText.textColor = UIColor.init(cgColor: someTextColor)
        bottomTimerText.backgroundColor = UIColor.init(cgColor: someColor)
        bottomTimerText.text = "Таймеры"
        subView.addSubview(bottomTimerText)
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderColor = someColor
        nameTextField.layer.cornerRadius = 5
        nameTextField.isUserInteractionEnabled = true
        nameTextField.placeholder = "Название таймера"
        subView.addSubview(nameTextField)

        timerValueTextField = UITextField()
        timerValueTextField.borderStyle = .roundedRect
        timerValueTextField.layer.cornerRadius = 10
        timerValueTextField.translatesAutoresizingMaskIntoConstraints = false
        timerValueTextField.placeholder = "Время в секундах"
        subView.addSubview(timerValueTextField)

        let size = CGSize(width: 150, height: 100)
        addTimerButton = UIButton(type: .system)
        addTimerButton.translatesAutoresizingMaskIntoConstraints = false
        addTimerButton.frame.size = size
        addTimerButton.layer.cornerRadius = 10
        addTimerButton.layer.backgroundColor = someColor
        addTimerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addTimerButton.setTitle("Добавить", for: .normal)
        addTimerButton.addTarget(self, action: #selector(addTimerTapped), for: .touchUpInside)
        subView.addSubview(addTimerButton)

        NSLayoutConstraint.activate([
            timerText.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            timerText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerText.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomTimerText.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomTimerText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTimerText.topAnchor.constraint(equalTo: addTimerButton.bottomAnchor, constant: 40),
            nameTextField.topAnchor.constraint(equalTo: subView.layoutMarginsGuide.topAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: subView.layoutMarginsGuide.leadingAnchor, constant: 0.5),
            nameTextField.widthAnchor.constraint(equalTo: subView.widthAnchor, multiplier: 0.6),
            timerValueTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            timerValueTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            timerValueTextField.leadingAnchor.constraint(equalTo: subView.layoutMarginsGuide.leadingAnchor, constant: 0.5),
            addTimerButton.topAnchor.constraint(equalTo: timerValueTextField.bottomAnchor, constant: 40),
            addTimerButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
            addTimerButton.widthAnchor.constraint(equalTo: subView.widthAnchor, multiplier: 0.92),
            subView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            subView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мульти таймер"
        loadMyView()
        configureTableView()
        let corutine = CADisplayLink(target: self, selector: #selector(updateTimers))
        corutine.add(to: .current, forMode: .common)
    }
    
    
    func configureTableView(){
        subTableView = UITableView()
        subTableView.rowHeight = 50
        subTableView.translatesAutoresizingMaskIntoConstraints = false
        subTableView.register(TimerCell.self, forCellReuseIdentifier: TimerCell.identifier)
        subTableView.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(subTableView)
        subTableView.delegate = self
        subTableView.dataSource = self
            NSLayoutConstraint.activate([
                subTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
                subTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                subTableView.topAnchor.constraint(equalTo: subView.bottomAnchor, constant: 100)
            ])
        }
    
    
    
    @objc func addTimerTapped(_ sender: UIButton){
        if nameTextField.hasText && timerValueTextField.hasText{
            guard let amountText = timerValueTextField.text else { return }
            guard let name = nameTextField.text else { return }
            guard let amount = Int(amountText) else { return }
            let timer = CustomTimer(name: name, amountOfTime: amount)
            timers.append(timer)
            timers.sort(by: {$0.amountOfTime > $1.amountOfTime})
            nameTextField.text = ""
            timerValueTextField.text = ""
            
            subTableView.reloadData()
        }
    }
    
    @objc func pauseTimer(_ sender: UIButton, index: Int){
        timers[index].pauseTimer()
    }
    
    @objc func updateTimers(){
        for (index, timer) in timers.enumerated() {
            if timer.amountOfTime == 0{
                timers.remove(at: index)
            }
        }
        subTableView.reloadData()
    }
    
    @objc func deleteTimers(){
        for i in 0..<timers.count {
            if timers[i].amountOfTime == 0{
                timers.remove(at: i)
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier) as? TimerCell else {
            fatalError("Can't find Timer cell")
        }
        cell.counterLabel.text = timers[indexPath.row].countDownText
        cell.nameLabel.text = timers[indexPath.row].name
        cell.pauseButton.addTarget(timers[indexPath.row], action: #selector(timers[indexPath.row].pauseTimer), for: .touchUpInside)

        return cell
    }
}

