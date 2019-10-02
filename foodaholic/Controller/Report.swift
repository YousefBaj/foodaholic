
import UIKit
import Firebase


class Report: UIViewController {
    
  
    
    @IBOutlet weak var header: headerView!
    
    @IBOutlet weak var foodper: UILabel!
    
    @IBOutlet weak var priceper: UILabel!
    @IBOutlet weak var serviceper: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       header.dropShadow()
        let ref = Database.database().reference()
        
         ref.child("percentage/").observeSingleEvent(of: .value, with: { (snapshot) in
            
              let data = snapshot.value as? [CGFloat]
           
            
            let food = data![0]
            let price = data![1]
            let service = data![2]
            self.foodper.text    = "\(Int(data![0]))%"
            self.priceper.text   = "\(Int(data![1]))%"
            self.serviceper.text = "\(Int(data![2]))%"
            
            self.draw(xaxis: 63,   yaxis: 400, per: food)
            self.draw(xaxis: 188,  yaxis: 400, per: price )
            self.draw(xaxis: 313,  yaxis: 400, per: service)
         })
            
        
        
    }
    
   
    
   
    
    
    
    
    
    @IBAction func closedPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
    
    func draw(xaxis: CGFloat, yaxis: CGFloat, per: CGFloat){
        
        let shapeLayer = CAShapeLayer()
        let shapeLayer1 = CAShapeLayer()
        // let's start by drawing a circle somehow
        
        let center = CGPoint(x: xaxis, y: yaxis)
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: (1.50 * CGFloat.pi), clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = #colorLiteral(red: 0, green: 0.662745098, blue: 0.6039215686, alpha: 1)
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 50, startAngle: (1.50 * CGFloat.pi) , endAngle: -CGFloat.pi / 2, clockwise: false)
        shapeLayer1.path = circularPath1.cgPath
        
        shapeLayer1.strokeColor = #colorLiteral(red: 0.8784313725, green: 0, blue: 0.3019607843, alpha: 1)
        shapeLayer1.lineWidth = 10
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineCap = CAShapeLayerLineCap.round
        shapeLayer1.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let basicAnimation1 = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue =  1 - (per / 100.0)
        basicAnimation1.toValue =  (per / 100.0)
        basicAnimation.duration = 2
        basicAnimation1.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation1.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation1.isRemovedOnCompletion = false
        
        shapeLayer1.add(basicAnimation, forKey: "urSoBasic")
        shapeLayer.add(basicAnimation1, forKey: "urSoBasic")
    }
    
    
}
