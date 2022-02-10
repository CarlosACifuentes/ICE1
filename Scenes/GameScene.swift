
import AVFoundation
import UIKit
import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?


class GameScene: SKScene
{
    var gameMAnager: GameManager?
    
    //instance variables
    var ocean: Ocean?
    var island: Island?
    var plane: Plane?
    var clouds: [Cloud] = []
    
    
    override func didMove(to view: SKView) {
        
        screenWidth = frame.width
        screenHeight = frame.height
        
        name = "GAME"
        
        //adding ocean
        ocean = Ocean()
        ocean?.position = CGPoint(x: 0, y: 700)
        addChild(ocean!) //add ocean to the scene
        
        //adding island
        island = Island()
        
        addChild(island!)
        
        //add plane to scene
        plane = Plane()
        plane?.position = CGPoint(x:0, y: -500)
        addChild(plane!)
        
        //add a single cloud
//        cloud = Cloud()
//        addChild(cloud!)
//
        for index in 0...2
        {
            let cloud: Cloud = Cloud()
            clouds.append(cloud)
            addChild(clouds[index])
        }
    
    
    //Adding sounds
    let engineSound = SKAudioNode(fileNamed: "engine_v2.mp3")
    self.addChild(engineSound)
    engineSound.autoplayLooped = true
        
    //preload / prewarm impulse
        do
        {
            let sounds:[String] = ["thunder_v2","yay_v2"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        }
        catch
        {
            
        }
        
        
    }
    
    func touchDown(atPoint pos : CGPoint)
    {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -500))
        
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -500))
        
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -500))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        ocean?.Update()
        island?.Update()
        plane?.Update()
       // cloud?.Update()
        for cloud in clouds
        {
            cloud.Update()
            CollissionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: cloud)
        }
        
        CollissionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: island!)
        
        if(ScoreManager.Lives < 1)
        {
            gameMAnager?.PresentEndScene()
        }
        
    }
}
