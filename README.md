## Animator

Stateful Toggle Animation Controller

## API 

Load an animation with an idle state: 
```lua
StateAnimator:New(Animator : object, ID : int--[[ Move ]], ID : int--[[ Idle ]])
```

Load an animation with no idle state:
```lua
StateAnimator:New(Animator : object, ID : int--[[ track id ]])
```

Play an animation - can set repeat state to do it until stopped.
```lua
StateAnimator:Play(Repeat : bool)
```

For animations with idle tracks:
*(thread blocking)*
```lua
StateAnimator:PlayThenIdle()
```

Play animation and wait for completion: 
*(thread blocking)*
```lua
StateAnimator:PlayAndComplete()
```

Stop the current animation or cancel the idle loop:
```lua
StateAnimator:Stop()
--OR 
StateAnimator:IdleStop()
```


### How to use:

1. Upload your animation set to Roblox 

2. Grab the animation IDs

3. Instantiate an AnimationController and an Animator within the Animation Controller: 
```lua
local Rig = script.Parent
local AnimationController = Instance.new("AnimationController", Rig)
local Animator = Instance.new("Animator", AnimationController)
```

4. Use the animator module to control your rig:

```lua 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Houses = ReplicatedStorage.Houses
local StateAnimator = require(Houses.StateAnimator)

-- See Animator object from example above
local openAnimation = StateAnimator:New(Animator : object, ID : int--[[ Move ]], ID : int--[[ Idle ]])

openAnimation:PlayThenIdle()
```

