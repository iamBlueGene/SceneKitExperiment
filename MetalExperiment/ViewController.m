//
//  ViewController.m
//  MetalExperiment
//
//  Created by Eliyahu Braginskiy on 01/10/2015.
//  Copyright © 2015 BlueGene. All rights reserved.
//

#import "ViewController.h"
@import SceneKit;
@import GLKit;


@interface ViewController ()


@property (strong, nonatomic) IBOutlet SCNView *sceneView;


@property (strong,nonatomic) NSArray *geometryNodes;
@property (assign,nonatomic) CGFloat currentAngle;
@property (assign,nonatomic) CGFloat currentYAngle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    

    self.currentAngle = 0.0;
    self.currentYAngle = 0.0;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


    
    SCNScene *characterScene = [SCNScene sceneNamed:@"character-male-muscle.dae"];
    SCNNode *man = [characterScene.rootNode childNodeWithName:@"Model_1" recursively:YES];
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents = [UIImage imageNamed:@"model-1-txtr"];
    
    
    
    SCNNode *camNode = [characterScene.rootNode childNodeWithName:@"TurnTableCamera" recursively:YES];
    camNode.rotation = SCNVector4Make(-0.69474, -0.694747, -0.186157, 0.736200);
    camNode.position = SCNVector3Make(-221,262, 386);
    
    camNode.rotation = SCNVector4Make(-0, 0, 0, 0);
    camNode.position = SCNVector3Make(0,0, 450);
    
    
    SCNMaterial *mat1 = [SCNMaterial material];
    mat1.diffuse.contents = [UIColor redColor];
    
    
    
    //If running on simulator - the Man node has child nodes with geometry
    //If running on device - the Man node doesnt have child nodes, and the man node itself has geometry
    

    
//    man.childNodes[0].childNodes[0].geometry.materials = @[mat1];
//    man.childNodes[0].childNodes[1].geometry.materials = @[material];
//    man.childNodes[0].childNodes[2].geometry.materials = @[material];
//    man.childNodes[0].childNodes[3].geometry.materials = @[material];
//    man.childNodes[0].childNodes[4].geometry.materials = @[material];
//    man.childNodes[0].childNodes[5].geometry.materials = @[material];
//    man.childNodes[0].childNodes[6].geometry.materials = @[material];
//    man.childNodes[0].childNodes[7].geometry.materials = @[material];
//    man.childNodes[0].childNodes[8].geometry.materials = @[material];
//    man.childNodes[0].childNodes[9].geometry.materials = @[material];
//    man.childNodes[0].childNodes[10].geometry.materials = @[material];
//    man.childNodes[0].childNodes[11].geometry.materials = @[material];
//    man.childNodes[0].childNodes[12].geometry.materials = @[material];
    
    
    
    self.geometryNodes = man.childNodes[0].childNodes;
//    man.geometry.materials = @[material];

    
    

    
    
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [self.sceneView addGestureRecognizer:recognizer];
    
    self.sceneView.scene = characterScene;
    
    self.sceneView.autoenablesDefaultLighting = YES;
//    self.sceneView.allowsCameraControl = YES;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    CGFloat newAngle = translation.x * M_PI / 180.0;
    newAngle += self.currentAngle;

    
    

    
    for (SCNNode *node in self.geometryNodes) {
        node.transform = SCNMatrix4MakeRotation(newAngle, 0,0, 1);
    }
    
    
    
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        self.currentAngle = newAngle;
    }
}

@end
