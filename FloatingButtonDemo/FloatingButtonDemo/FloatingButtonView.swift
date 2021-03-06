//
//  FloatingButtonView.swift
//  FloatingButtonView
//
//  Created by Molder on 2021/9/5.
//

import UIKit
protocol FloatingButtonViewDelegate: AnyObject {
    func btnViewAciton()
}

class FloatingButtonView: UIView {

    var targetView : UIView?
    weak var delegate: FloatingButtonViewDelegate?
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    override init(frame: CGRect) {
        super.init(frame: frame)
        selfView()
        setConstraints()
    }

    func selfView() {
        self.frame = CGRect.init(x: screenWidth - (screenWidth * 0.25),
                                 y: screenHeight/2,
                                 width: screenWidth * 0.25,
                                 height: screenWidth * 0.25)

        let panner = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panner.minimumNumberOfTouches = 1
        self.addGestureRecognizer(panner)
        self.backgroundColor = .clear
    }
    
    lazy var topButton: UIButton = {
        let topButton = UIButton(type: .custom)
        topButton.setImage(UIImage(named: "close"), for: .normal)
        topButton.frame = CGRect.init(x: 0, y: 0, width: self.frame.width * 0.4, height: self.frame.width * 0.4)
        topButton.autoresizingMask = []
        topButton.addTarget(self, action: #selector(closeBtn), for: .touchUpInside)
        topButton.backgroundColor = .clear
        topButton.translatesAutoresizingMaskIntoConstraints = false
        return topButton
    }()

    lazy var downButton: UIButton = {
        let downButton = UIButton(type: .custom)
        downButton.frame = CGRect.init(x: 0, y: 0, width: self.frame.width * 0.65, height: self.frame.width * 0.65)
        downButton.autoresizingMask = []
        downButton.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        downButton.backgroundColor = .clear
        downButton.setBackgroundImage(UIImage(named: "gift"), for: .normal)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        return downButton
    }()
    
    func setConstraints() {
        self.addSubview(downButton)
        downButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        downButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        downButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        downButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.65).isActive = true
        self.addSubview(topButton)
        topButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        topButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    /// ????????????
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        // ??????????????????
        let location = gesture.location(in: targetView)
        // ?????????
        if gesture.state == .changed {
            self.center = location
        // ????????????
        } else if gesture.state == .ended {
            var lineBtnRect = self.frame
            // ??????
            if location.x < screenWidth/2 {
                lineBtnRect.origin.x = 0
            // ??????
            } else {
                lineBtnRect.origin.x = screenWidth - self.frame.width
            }
            // ??????
            if location.y - self.frame.height/2 < 44 {
                lineBtnRect.origin.y = 44
            // ??????
            } else if location.y + self.frame.height/2 > screenHeight - 44 {
                lineBtnRect.origin.y = screenHeight - 44 - self.frame.height - 10
            }
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.frame = lineBtnRect
            }, completion: nil)
        }
    }

    /// ??????topButton??????
    @objc func closeBtn() {
        removeFloatingButton()
    }
    
    /// ??????downButton??????
    @objc func clickBtn() {
        delegate?.btnViewAciton()
    }

    /// ????????????FloatingButton??????
    func addFloatingButton(target: UIView) {
        let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
        let window = sceneDelegate.window
        window?.rootViewController?.view.addSubview(self)
        self.targetView = target
    }

    /// ????????????FloatingButton??????
    func removeFloatingButton() {
        self.removeFromSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
