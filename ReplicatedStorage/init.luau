--[[ 
    Animator
    
    Toggle animation state controller.  

--]]

local Animation = {}

--function Animation:New(animator, movement_id, idle_id)
function Animation:New(props : { animator : RigAnimatorInstance, movement_id : int, idle_id : int? }) : Animation

	local animation = {}
	setmetatable(animation, {__index = self})
	--
	animation.movement_id = props.movement_id
	animation.idle_id = props.idle_id

	animation.movement_animation = Instance.new("Animation")
	animation.movement_animation.AnimationId = "rbxassetid://"..tostring(animation.movement_id)
	if animation.idle_id ~= nil then 
		animation.idle_animation = Instance.new("Animation")
		animation.idle_animation.AnimationId = "rbxassetid://"..tostring(animation.idle_id)
	end
	--
	animation:Load(animator)
	--
	return animation
end

function Animation:Load(animator)
	if animator ~= nil then 
		self.track = animator:LoadAnimation(self.movement_animation)
		self.length = self.track.Length
		--
		if self.idle_animation ~= nil then 
			self.idle_track = animator:LoadAnimation(self.idle_animation)
			self.idle_track.Looped = true
		end
	end
end

function Animation:Play(loop)
	if self.track ~= nil then
		self.track.Looped = loop or false 
		self.track:Play()
	end
end

function Animation:PlayAndComplete()
	self:Play()
	wait(self.length+0.1)
end

function Animation:PlayThenIdle(old_idle)
	self:PlayAndComplete()
	if old_idle ~= nil then 
		old_idle:IdleStop()
	end
	if self.idle_track ~= nil then 
		self.idle_track:Play()
	else 
		warn(self,self.movement_animation," does not have an idle track, call PlayAndComplete instead.")
	end
end

function Animation:Stop()
	if self.track ~= nil then 
		self.track:Stop()
	end
end

function Animation:IdleStop()
	if self.idle_track ~= nil then 
		self.idle_track:Stop()
	end
end

--[[ New to create rig animator ]]

function Animation:GetRigAnimator(props : {Rig : Instance}) : AnimatorInstance
	local AnimationController = Rig:FindFirstChild ("AnimationController") or Instance.new("AnimationController", Rig)
	local Animator = AnimationController:FindFirstChild ("Animator") or Instance.new("Animator", AnimationController)
	--
	return Animator
end

return Animation