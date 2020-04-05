# Motionator
Motionator is a work-in-progress implementation of real-time motion tracking for Blender using iPhone X, 
inspired by the [Blender](https://blender.org) community and Pascal Jardin's work on [BMC](https://github.com/pjardin/Blender-Motion-Capture).

The code is based on Apple's [Tracking and Visualising Faces](https://developer.apple.com/documentation/arkit/tracking_and_visualizing_faces)
sample, hooked up with [Figure 53's OSC library](https://github.com/Figure53/F53OSC).

For OSC support in Blender, JPfeP's [Addroutes addon](http://www.jpfep.net/pages/addroutes/) is just the thing :-)

Motionator sends one message for head orientation
```
/head x, y, z
```
and a float value for all of the Apple blendShapes

```
/browDown_L
/browDown_R
/browInnerUp
/browOuterUp_L
/browOuterUp_R
/cheekPuff
/cheekSquint_L
/cheekSquint_R
/eyeBlink_L
/eyeBlink_R
/eyeLookDown_L
/eyeLookDown_R
/eyeLookIn_L
/eyeLookIn_R
/eyeLookOut_L
/eyeLookOut_R
/eyeLookUp_L
/eyeLookUp_R
/eyeSquint_L
/eyeSquint_R
/eyeWide_L
/eyeWide_R
/jawForward
/jawLeft
/jawOpen
/jawRight
/mouthClose
/mouthDimple_L
/mouthDimple_R
/mouthFrown_L
/mouthFrown_R
/mouthFunnel
/mouthLeft
/mouthLowerDown_L
/mouthLowerDown_R
/mouthPress_L
/mouthPress_R
/mouthPucker
/mouthRight
/mouthRollLower
/mouthRollUpper
/mouthShrugLower
/mouthShrugUpper
/mouthSmile_L
/mouthSmile_R
/mouthStretch_L
/mouthStretch_R
/mouthUpperUp_L
/mouthUpperUp_R
/noseSneer_L
/noseSneer_R
/tongueOut
```

I'm totally new to OSC, iOS and Blender, so there may be better ways to do all of this.

