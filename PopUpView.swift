//
//  PopUpView.swift
//  ReminderApp
//
//  Created by Luis Gonzalez on 4/30/20.
//  Copyright © 2020 Luis Gonzalez. All rights reserved.
//

import Foundation
import UIKit



/*
 The fix for the out of frame box PopUpView
 - The size is not corrent make is an even 200 * 400;
 - !!
 */


class PopUpView: UIView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var values = [String]();
    
    var leftButton: UIButton = {
        let button = UIButton();
        button.setTitle("Cancel", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.backgroundColor = .red;
        return button
    }();
    
    var rightButton: UIButton = {
        let button = UIButton();
        button.setTitle("Ok", for: .normal);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.backgroundColor = .blue;
        return button
    }();
    
    lazy var picker: UIPickerView = {
        let picker = UIPickerView();
        picker.translatesAutoresizingMaskIntoConstraints = false;
        picker.dataSource = nil;
        return picker;
    }();
    
    var upperLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Pick from the following";
        label.textColor = .black;
        label.backgroundColor = .blue;
        label.textAlignment = .center;
        label.font = UIFont(name: "Helvetica-Light", size: CGFloat(18));
        return label;
    }()

    var pickerValue: String = "";
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero);
        self.picker.delegate = self;
        self.picker.dataSource = self;
    }
    
    init(valuesForArray: [String]){
        self.values = valuesForArray;
        super.init(frame: .zero);
        setAllViews();
    }
    
    public func setAllViews()->Void {
        translatesAutoresizingMaskIntoConstraints = false;
        heightAnchor.constraint(equalToConstant: 270).isActive = true;
        backgroundColor = .white;
        // Shadowing Function
        shadowingAction();
        picker.delegate = self;
        
        
        addSubview(rightButton);
        addSubview(leftButton);
        addSubview(upperLabel);
        addSubview(picker);
        constraintsForViews();
    }
    
    private func shadowingAction()->Void {
        layer.masksToBounds = false;
        layer.shadowColor = UIColor.lightGray.cgColor;
        layer.shadowOffset = .zero;
        layer.shadowRadius = 10
        layer.shadowOpacity = 1;
        alpha = 0.0;
    }
    
    public func constraintsForViews()->Void {
        leftButton.anchorView(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: centerXAnchor);
        rightButton.anchorView(top: nil, leading: centerXAnchor, bottom: bottomAnchor, trailing: trailingAnchor);
        upperLabel.anchorView(top: topAnchor, leading: leadingAnchor, bottom: picker.topAnchor, trailing: trailingAnchor);
        picker.anchorView(top: upperLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor);
        picker.bottomAnchor.constraint(equalTo: rightButton.topAnchor, constant: 5).isActive = true;
        picker.bottomAnchor.constraint(equalTo: leftButton.topAnchor, constant: 5).isActive = true;
    }
    
    // Set colors
    public func titleColor(color: UIColor) { upperLabel.backgroundColor = color;}
    public func rightButtonColor(color: UIColor) {rightButton.backgroundColor = color;}
    public func leftButtonColor(color: UIColor) {leftButton.backgroundColor = color;}
    public func pickerValueColor(color: UIColor){picker.backgroundColor = color;}
    // Set Upper label font
    public func setFonts(font: String, size: CGFloat) { upperLabel.font = UIFont(name: font, size: size);}
    
    // Number of rows!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        values.count;
    }
    // Values
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    // Actual Picker values, From here we should be able to return
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValue = values[row];
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1;
    }
    
    // First attempt to be able to return selected string value;
    public func returnStringValue()->String {
        if (pickerValue == "" ){return ""}else {return pickerValue;}
    }
    
    
    // Ok Button click returns String Value at PickerValue
    public func okButtonClick()->String {
        var string: String = "";
        UIView.animate(withDuration: 0.8, animations: {
            self.alpha = 0.0;
        })
        string = self.pickerValue;
        return string;
    }
    
    public func leftButtonCancel()->Void {
        UIView.animate(withDuration: 0.8, animations: {
            self.frame.origin.y -= 100;
            self.alpha = 0.0;
            self.removeFromSuperview();
        })
    }
}
