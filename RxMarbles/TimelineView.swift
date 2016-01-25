//
//  TimelineView.swift
//  RxMarbles
//
//  Created by Roman Tutubalin on 21.01.16.
//  Copyright © 2016 Roman Tutubalin. All rights reserved.
//

import UIKit

class TimelineView: UIView {
    var sourceEvents = [EventView]()
    let timeArrow = UIImageView(image: Image.timeLine)
    var _addButton: UIButton?
    weak var sceneView: SceneView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timeArrow)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeArrow.frame = CGRectMake(0, 0, frame.width, Image.timeLine.size.height)
        timeArrow.center.y = bounds.height / 2.0
        if _addButton != nil {
            _addButton?.center.y = bounds.height / 2.0
            _addButton?.center.x = frame.size.width - 10.0
            let timeArrowFrame = timeArrow.frame
            let newTimeArrowFrame = CGRectMake(timeArrowFrame.origin.x, timeArrowFrame.origin.y, timeArrowFrame.size.width - 23.0, timeArrowFrame.size.height)
            timeArrow.frame = newTimeArrowFrame
        }
        bringStopEventViewsToFront(sourceEvents)
    }
    
    func maxNextTime() -> Int? {
        let times = sourceEvents.map({ $0.recorded.time })
        return times.maxElement()
    }
    
    func xPositionByTime(time: Int) -> CGFloat {
        let maxTime: CGFloat = 1000.0
        let width = bounds.size.width
        return (width / maxTime) * CGFloat(time)
    }
    
    func timeByXPosition(x: CGFloat) -> Int {
        let maxTime: CGFloat = 1000.0
        let width = bounds.size.width
        return Int((maxTime / width) * x)
    }
    
    func bringStopEventViewsToFront(sourceEvents: [EventView]) {
        sourceEvents.forEach({ if $0.recorded.value.isStopEvent { self.bringSubviewToFront($0) } })
    }
}