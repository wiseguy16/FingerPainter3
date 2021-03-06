//
//  ViewController.swift
//  FingerPainter3
//
//  Created by Gregory Weiss on 8/25/16.
//  Copyright © 2016 Gregory Weiss. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController
{
    
    @IBOutlet weak var gestureNameLabel: UILabel!
    @IBOutlet weak var canvas: UIImageView!
     var start: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearImage(sender: UIBarButtonItem)
    {
        canvas.image = nil
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first
        start = touch!.locationInView(view)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touch = touches.first
        let end = touch!.locationInView(view)
        if let start = self.start
        {
            drawFromPoint(start, toPoint: end)
        }
        self.start = end
    }
    
    func drawFromPoint(start: CGPoint, toPoint end: CGPoint)
    {
        // set the context to that of an image
        UIGraphicsBeginImageContext(canvas.frame.size)
        let context = UIGraphicsGetCurrentContext()
        // draw the existing image onto the current context
        canvas.image?.drawInRect(CGRect(x: 0, y: 0,
            width: canvas.frame.size.width, height: canvas.frame.size.height))
        // draw the new line segment
        CGContextSetLineWidth(context, 5)
        CGContextSetStrokeColorWithColor(context, UIColor.magentaColor().CGColor)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, end.x, end.y)
        CGContextStrokePath(context)
        // obtain a UIImage object from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // set the UIImageView's image to the new, generated image
        canvas.image = newImage
    }

    
    
    @IBAction func saveDrawing(sender: UIBarButtonItem)
    {
        
        showGestureName()
        
        
        
    }
    
    func showGestureName()
    {
       gestureNameLabel.text = "Drawing Saved"
        UIView.animateWithDuration(1.0, animations: {
            self.gestureNameLabel.alpha = 1
            }, completion: {
                _ in
                UIView.animateWithDuration(1.0, animations: {
                    self.gestureNameLabel.alpha = 0
                })
        })
        
        
    }

}








