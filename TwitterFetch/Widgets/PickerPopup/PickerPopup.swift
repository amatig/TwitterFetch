//
//  ActionSheetPicker.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import UIKit

protocol PickerPopupDelegate : class {
    func onTapDone(row: PickerDataRow)
}

class PickerPopup: NSObject, PickerPopupProtocol {

    private enum Constants {
        static let cancel = "Cancel"
        static let done = "Done"
    }
    
    weak var delegate: PickerPopupDelegate?
    var datasource: [PickerDataRow] = []
    var alert: UIAlertController!
    var controller: UIViewController!
    var pickerView: UIPickerView!
    
    init(controller : UIViewController) {
        self.controller = controller
        super.init()
        setup()
    }
    
    fileprivate func setup() {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 270)
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 270))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
        alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: Constants.done, style: .default, handler: { [weak self]
            (alert: UIAlertAction!) -> Void in
            
            guard let strongSelf = self else {
                return
            }
        
            let row = strongSelf.pickerView.selectedRow(inComponent: 0)
            strongSelf.delegate?.onTapDone(row: strongSelf.datasource[row])
        }))
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil))
    }
    
    func show(title : String) {
        alert.title = title
        DispatchQueue.main.async {
            self.pickerView.reloadComponent(0)
            self.controller.present(self.alert, animated: true, completion: nil)
        }
        
    }
}

// MARK: - UIPickerViewDelegate
extension PickerPopup: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.datasource[row].label
    }
}

// MARK: - UIPickerViewDataSource
extension PickerPopup : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.datasource.count
    }
}
