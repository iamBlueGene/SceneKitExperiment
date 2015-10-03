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
    
    SCNScene *scene = [[SCNScene alloc] init];
    
    SCNNode*ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor colorWithRed:0.5 green:0.3 blue:0.8 alpha:1.0];
    
    SCNNode *omniLightNode = [SCNNode node];
    omniLightNode.light = [SCNLight light];
    omniLightNode.light.type = SCNLightTypeOmni;
    omniLightNode.light.color = [UIColor colorWithWhite:0.75 alpha:1.0];
    omniLightNode.position = SCNVector3Make(0, 50, 50);
    
    SCNNode *omniLightNode2 = [SCNNode node];
    omniLightNode2.light = [SCNLight light];
    omniLightNode2.light.type = SCNLightTypeOmni;
    omniLightNode2.light.color = [UIColor colorWithWhite:0.75 alpha:1.0];
    omniLightNode2.position = SCNVector3Make(0, -50, -50);
    
    
    
//    SCNBox *box = [SCNBox boxWithWidth:10.0 height:10.0 length:10.0 chamferRadius:1.0];
//    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
//    [scene.rootNode addChildNode:boxNode];
    

    
//    SCNPlane *plane = [SCNPlane planeWithWidth:50.0 height:50.0];
//    SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
//    planeNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-90), 0, 0);
//    planeNode.position = SCNVector3Make(0, -0.5, 0);
//    
//    
//    SCNNode *cameraNode = [SCNNode node];
//    cameraNode.camera = [SCNCamera camera];
//    cameraNode.position = SCNVector3Make(169, -60, -160);
//    cameraNode.scale = SCNVector3Make(-1, -164, -1);

    
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
//    
//    [[[[man.childNodes[0] childNodes] objectAtIndex:0] geometry] materials] = @[material];
    
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
    
    
//    SCNLookAtConstraint *constraint = [SCNLookAtConstraint lookAtConstraintWithTarget:man];
//    constraint.gimbalLockEnabled = YES;
//    cameraNode.constraints = @[constraint];
//////
//
    
//    
//    [scene.rootNode addChildNode:ambientLightNode];
//    [scene.rootNode addChildNode:omniLightNode];
//    [scene.rootNode addChildNode:omniLightNode2];
//    [scene.rootNode addChildNode:cameraNode];
//    [scene.rootNode addChildNode:planeNode];
//    [scene.rootNode addChildNode:man];


    
    

    
    
    
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
    
//    CGFloat yAngle = translation.y * M_PI / 180.0;
//    yAngle += self.currentYAngle;
    
    

    
    for (SCNNode *node in self.geometryNodes) {
        node.transform = SCNMatrix4MakeRotation(newAngle, 0,0, 1);
    }
    
    
    
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        self.currentAngle = newAngle;
    }
}

@end
