
import GameplayKit
import SpriteKit

class Plane: GameObject
{
    //initializer
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func CheckBounds() {
        if(position.x <= -310)
        {
            position.x = -310
        }
        if(position.x >= 310)
        {
            position.x = 310
        }
    }
    override func Start()
    {
        zPosition = 2
        
    }
    override func Update()
    {
        CheckBounds()
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
}
