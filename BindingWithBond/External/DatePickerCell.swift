//
//  DVDatePickerTableViewCell.swift
//  DVDatePickerTableViewCellDemo
//
//  Created by Dylan Vann on 2014-10-21.
//  Copyright (c) 2014 Dylan Vann. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Inline/Expanding date picker for table views.
 */
public class DatePickerCell: UITableViewCell {
  
  /**
   *  UIView subclass. Used as a subview in UITableViewCells. Does not change color when the UITableViewCell is selected.
   */
  class DVColorLockView:UIView {
    
    var lockedBackgroundColor:UIColor {
      set {
        super.backgroundColor = newValue
      }
      get {
        return super.backgroundColor!
      }
    }
    
    override var backgroundColor:UIColor? {
      set {
      }
      get {
        return super.backgroundColor
      }
    }
  }
  
  // Class variable workaround.
  struct Stored {
    static var dateFormatter = NSDateFormatter()
  }
  
  /// The selected date, set to current date/time on initialization.
  public var date:NSDate = NSDate() {
    didSet {
      datePicker.date = date
      DatePickerCell.Stored.dateFormatter.dateStyle = dateStyle
      DatePickerCell.Stored.dateFormatter.timeStyle = timeStyle
      rightLabel.text = DatePickerCell.Stored.dateFormatter.stringFromDate(date)
    }
  }
  /// The timestyle.
  public var timeStyle = NSDateFormatterStyle.ShortStyle
  /// The datestyle.
  public var dateStyle = NSDateFormatterStyle.MediumStyle
  
  /// Label on the left side of the cell.
  public var leftLabel = UILabel()
  /// Label on the right side of the cell.
  public var rightLabel = UILabel()
  /// Default color of the right label.
  public var rightLabelTextColor = UIColor(hue: 0.639, saturation: 0.041, brightness: 0.576, alpha: 1.0) //Color of normal detail label.
  
  var seperator = DVColorLockView()
  
  var datePickerContainer = UIView()
  /// The datepicker embeded in the cell.
  public var datePicker: UIDatePicker = UIDatePicker()
  
  /// Is the cell expanded?
  public var expanded = false
  var unexpandedHeight = CGFloat(44)
  
  /**
   Creates the DatePickerCell
   
   :param: style           A constant indicating a cell style. See UITableViewCellStyle for descriptions of these constants.
   :param: reuseIdentifier A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view. Pass nil if the cell object is not to be reused. You should use the same reuse identifier for all cells of the same form.
   
   :returns: An initialized DatePickerCell object or nil if the object could not be created.
   */
  override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  private func setup() {
    // The datePicker overhangs the view slightly to avoid invalid constraints.
    self.clipsToBounds = true
    
    var views = [leftLabel, rightLabel, seperator, datePickerContainer, datePicker]
    for view in views {
      self.contentView .addSubview(view)
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    datePickerContainer.clipsToBounds = true
    datePickerContainer.addSubview(datePicker)
    
    // Add a seperator between the date text display, and the datePicker. Lighter grey than a normal seperator.
    seperator.lockedBackgroundColor = UIColor(white: 0, alpha: 0.1)
    datePickerContainer.addSubview(seperator)
    datePickerContainer.addConstraints([
      NSLayoutConstraint(
        item: seperator,
        attribute: NSLayoutAttribute.Left,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.Left,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: seperator,
        attribute: NSLayoutAttribute.Right,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.Right,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: seperator,
        attribute: NSLayoutAttribute.Height,
        relatedBy: NSLayoutRelation.Equal,
        toItem: nil,
        attribute: NSLayoutAttribute.NotAnAttribute,
        multiplier: 1.0,
        constant: 0.5
      ),
      NSLayoutConstraint(
        item: seperator,
        attribute: NSLayoutAttribute.Top,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.Top,
        multiplier: 1.0,
        constant: 0
      ),
      ])
    
    
    rightLabel.textColor = rightLabelTextColor
    
    // Left label.
    self.contentView.addConstraints([
      NSLayoutConstraint(
        item: leftLabel,
        attribute: NSLayoutAttribute.Height,
        relatedBy: NSLayoutRelation.Equal,
        toItem: nil,
        attribute: NSLayoutAttribute.NotAnAttribute,
        multiplier: 1.0,
        constant: 44
      ),
      NSLayoutConstraint(
        item: leftLabel,
        attribute: NSLayoutAttribute.Top,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Top,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: leftLabel,
        attribute: NSLayoutAttribute.Left,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Left,
        multiplier: 1.0,
        constant: self.separatorInset.left
      ),
      ])
    
    // Right label
    self.contentView.addConstraints([
      NSLayoutConstraint(
        item: rightLabel,
        attribute: NSLayoutAttribute.Height,
        relatedBy: NSLayoutRelation.Equal,
        toItem: nil,
        attribute: NSLayoutAttribute.NotAnAttribute,
        multiplier: 1.0,
        constant: 44
      ),
      NSLayoutConstraint(
        item: rightLabel,
        attribute: NSLayoutAttribute.Top,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Top,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: rightLabel,
        attribute: NSLayoutAttribute.Right,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Right,
        multiplier: 1.0,
        constant: -self.separatorInset.left
      ),
      ])
    
    // Container.
    self.contentView.addConstraints([
      NSLayoutConstraint(
        item: datePickerContainer,
        attribute: NSLayoutAttribute.Left,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Left,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: datePickerContainer,
        attribute: NSLayoutAttribute.Right,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Right,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: datePickerContainer,
        attribute: NSLayoutAttribute.Top,
        relatedBy: NSLayoutRelation.Equal,
        toItem: leftLabel,
        attribute: NSLayoutAttribute.Bottom,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: datePickerContainer,
        attribute: NSLayoutAttribute.Bottom,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self.contentView,
        attribute: NSLayoutAttribute.Bottom,
        multiplier: 1.0,
        constant: 1
      ),
      ])
    
    // Picker constraints.
    datePickerContainer.addConstraints([
      NSLayoutConstraint(
        item: datePicker,
        attribute: NSLayoutAttribute.Left,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.Left,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: datePicker,
        attribute: NSLayoutAttribute.Right,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.Right,
        multiplier: 1.0,
        constant: 0
      ),
      NSLayoutConstraint(
        item: datePicker,
        attribute: NSLayoutAttribute.CenterY,
        relatedBy: NSLayoutRelation.Equal,
        toItem: datePickerContainer,
        attribute: NSLayoutAttribute.CenterY,
        multiplier: 1.0,
        constant: 0
      ),
      ])
    
    datePicker.addTarget(self, action: "datePicked", forControlEvents: UIControlEvents.ValueChanged)
    let timeIntervalSinceReferenceDateWithoutSeconds = floor(date.timeIntervalSinceReferenceDate / 60.0) * 60.0 // Clear seconds.
    self.date = NSDate(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDateWithoutSeconds)
    leftLabel.text = "Date Picker"
  }
  
  /**
   Needed for initialization from a storyboard.
   
   :param: aDecoder An unarchiver object.
   :returns: An initialized DatePickerCell object or nil if the object could not be created.
   */
  required public init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setup()
  }
  
  /**
   Determines the current desired height of the cell. Used in the UITableViewDelegate's heightForRowAtIndexPath method.
   
   :returns: The cell's height.
   */
  public func datePickerHeight() -> CGFloat {
    var expandedHeight = unexpandedHeight + CGFloat(datePicker.frame.size.height)
    return expanded ? expandedHeight : unexpandedHeight
  }
  
  /**
   Used to notify the DatePickerCell that it was selected. The DatePickerCell will then run its selection animation and expand or collapse.
   
   :param: tableView The tableview the DatePickerCell was selected in.
   */
  public func selectedInTableView(tableView: UITableView) {
    expanded = !expanded
    
    UIView.transitionWithView(rightLabel, duration: 0.25, options:UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
      self.rightLabel.textColor = self.expanded ? self.tintColor : self.rightLabelTextColor
      }, completion: nil)
    
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  // Action for the datePicker ValueChanged event.
  func datePicked() {
    date = datePicker.date
  }
}
