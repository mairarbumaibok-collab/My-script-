-- =================================================================
-- SCRIPT NAME: SMART MASTER (FULL HUB - TAB 1 & TAB 2)
-- THEME: Minimalist Black
-- =================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- -----------------------------------------------------------------
-- GUI INITIALIZATION
-- -----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SmartMaster_AdminGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 680, 0, 450)
MainFrame.Position = UDim2.new(0.5, -340, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 8)
MainUICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SMART MASTER - ADMIN HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.Padding = UDim.new(0, 5)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -150, 1, -50)
ContentContainer.Position = UDim2.new(0, 145, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Page Frames
local Pages = {}

local function CreatePage(pageName)
	local ScrollContent = Instance.new("ScrollingFrame")
	ScrollContent.Name = pageName .. "_Page"
	ScrollContent.Size = UDim2.new(1, 0, 1, 0)
	ScrollContent.BackgroundTransparency = 1
	ScrollContent.BorderSizePixel = 0
	ScrollContent.ScrollBarThickness = 4
	ScrollContent.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
	ScrollContent.Visible = false
	ScrollContent.Parent = ContentContainer

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = ScrollContent
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 12)

	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.PaddingTop = UDim.new(0, 5)
	UIPadding.Parent = ScrollContent

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollContent.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
	end)

	Pages[pageName] = ScrollContent
	return ScrollContent
end

local Page_MySelf = CreatePage("MySelf")
local Page_Attack = CreatePage("Attack")

local function SwitchTab(selectedName)
	for name, page in pairs(Pages) do
		page.Visible = (name == selectedName)
	end
end

local function CreateTabButton(btnText, pageName, isDefault)
	local Btn = Instance.new("TextButton")
	Btn.Name = "Tab_" .. pageName
	Btn.Size = UDim2.new(1, -10, 0, 35)
	Btn.BackgroundColor3 = isDefault and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(28, 28, 28)
	Btn.Text = btnText
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Font = Enum.Font.GothamSemibold
	Btn.TextSize = 13
	Btn.Parent = Sidebar

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Btn

	Btn.MouseButton1Click:Connect(function()
		for _, child in ipairs(Sidebar:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			end
		end
		Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		SwitchTab(pageName)
	end)

	if isDefault then SwitchTab(pageName) end
end

CreateTabButton("👤 My Self", "MySelf", true)
CreateTabButton("⚔️ Attack", "Attack", false)

-- Floating Action Buttons Container
local FloatingContainer = Instance.new("Frame")
FloatingContainer.Name = "FloatingContainer"
FloatingContainer.Size = UDim2.new(0, 250, 0, 50)
FloatingContainer.Position = UDim2.new(0.02, 0, 0.65, 0)
FloatingContainer.BackgroundTransparency = 1
FloatingContainer.Parent = ScreenGui

local FloatingList = Instance.new("UIListLayout")
FloatingList.Parent = FloatingContainer
FloatingList.FillDirection = Enum.FillDirection.Horizontal
FloatingList.Padding = UDim.new(0, 8)

-- -----------------------------------------------------------------
-- UI BUILDER HELPERS
-- -----------------------------------------------------------------
local function CreateSectionHeader(parentPage, titleText, layoutOrder)
	local HeaderFrame = Instance.new("Frame")
	HeaderFrame.Size = UDim2.new(1, 0, 0, 22)
	HeaderFrame.BackgroundTransparency = 1
	HeaderFrame.LayoutOrder = layoutOrder

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, 0, 1, 0)
	Label.BackgroundTransparency = 1
	Label.Text = "--- " .. titleText .. " ---"
	Label.TextColor3 = Color3.fromRGB(180, 180, 180)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 12
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = HeaderFrame

	HeaderFrame.Parent = parentPage
	return HeaderFrame
end

local function CreateToggle(parentPage, nameText, defaultState, layoutOrder, callback)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 0, 35)
	Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame.LayoutOrder = layoutOrder
	
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Frame

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(0.7, 0, 1, 0)
	Label.Position = UDim2.new(0, 10, 0, 0)
	Label.BackgroundTransparency = 1
	Label.Text = nameText
	Label.TextColor3 = Color3.fromRGB(220, 220, 220)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Frame

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0, 65, 0, 23)
	Button.Position = UDim2.new(1, -70, 0.5, -11)
	Button.BackgroundColor3 = defaultState and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
	Button.Text = defaultState and "ON" or "OFF"
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 11
	Button.Parent = Frame

	local BtnCorner = Instance.new("UICorner")
	BtnCorner.CornerRadius = UDim.new(0, 4)
	BtnCorner.Parent = Button

	local state = defaultState
	Button.MouseButton1Click:Connect(function()
		state = not state
		Button.Text = state and "ON" or "OFF"
		Button.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
		callback(state)
	end)

	Frame.Parent = parentPage
	return Frame
end

local function CreateSlider(parentPage, nameText, minVal, maxVal, defaultVal, layoutOrder, callback)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1, 0, 0, 48)
	Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame.LayoutOrder = layoutOrder

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Frame

	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(0.5, 0, 0, 20)
	Label.Position = UDim2.new(0, 10, 0, 4)
	Label.BackgroundTransparency = 1
	Label.Text = nameText
	Label.TextColor3 = Color3.fromRGB(220, 220, 220)
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 12
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Frame

	local TextBox = Instance.new("TextBox")
	TextBox.Size = UDim2.new(0, 55, 0, 18)
	TextBox.Position = UDim2.new(1, -60, 0, 4)
	TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TextBox.Text = tostring(defaultVal)
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.Font = Enum.Font.Gotham
	TextBox.TextSize = 11
	TextBox.Parent = Frame

	local BoxCorner = Instance.new("UICorner")
	BoxCorner.CornerRadius = UDim.new(0, 4)
	BoxCorner.Parent = TextBox

	local SliderBack = Instance.new("Frame")
	SliderBack.Size = UDim2.new(1, -20, 0, 5)
	SliderBack.Position = UDim2.new(0, 10, 0, 30)
	SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	SliderBack.BorderSizePixel = 0
	SliderBack.Parent = Frame

	local SliderFill = Instance.new("Frame")
	SliderFill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
	SliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderFill.BorderSizePixel = 0
	SliderFill.Parent = SliderBack

	local isDragging = false

	local function UpdateVal(value)
		local clamped = math.clamp(value, minVal, maxVal)
		TextBox.Text = tostring(math.floor(clamped))
		SliderFill.Size = UDim2.new((clamped - minVal)/(maxVal - minVal), 0, 1, 0)
		callback(clamped)
	end

	SliderBack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
			UpdateVal(minVal + (maxVal - minVal) * pos)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
			UpdateVal(minVal + (maxVal - minVal) * pos)
		end
	end)

	TextBox.FocusLost:Connect(function()
		local num = tonumber(TextBox.Text)
		if num then UpdateVal(num) else TextBox.Text = tostring(minVal) end
	end)

	Frame.Parent = parentPage
	return Frame
end

local function CreateFloatingButton(textIcon)
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(0, 42, 0, 42)
	Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Btn.Text = textIcon
	Btn.TextSize = 16
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Visible = false
	Btn.Parent = FloatingContainer

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = Btn

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(80, 80, 80)
	Stroke.Thickness = 1.5
	Stroke.Parent = Btn

	return Btn
end

-- -----------------------------------------------------------------
-- TAB 1: MY SELF
-- -----------------------------------------------------------------

-- === 1. Walk & Auto Walk ===
CreateSectionHeader(Page_MySelf, "1. การเดิน (Walking)", 1)

local currentSpeed = 16
CreateSlider(Page_MySelf, "Ultra Speed", 16, 500, 16, 2, function(val)
	currentSpeed = val
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = val
	end
end)

local autoWalkEnabled, autoWalkActive = false, false
local autoWalkBtn = CreateFloatingButton("👟")

CreateToggle(Page_MySelf, "Auto Walk", false, 3, function(state)
	autoWalkEnabled = state
	autoWalkBtn.Visible = state
	if not state then autoWalkActive = false autoWalkBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
end)

autoWalkBtn.MouseButton1Click:Connect(function()
	if autoWalkEnabled then
		autoWalkActive = not autoWalkActive
		autoWalkBtn.BackgroundColor3 = autoWalkActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 30)
	end
end)

RunService.RenderStepped:Connect(function()
	if autoWalkEnabled and autoWalkActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
		local hrp = LocalPlayer.Character.HumanoidRootPart
		LocalPlayer.Character.Humanoid:Move(Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z), false)
	end
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		if LocalPlayer.Character.Humanoid.WalkSpeed ~= currentSpeed and currentSpeed ~= 16 then
			LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
		end
	end
end)

-- === 2. Jump & Auto Jump ===
CreateSectionHeader(Page_MySelf, "2. การกระโดด (Jumping)", 4)

local currentJumpPower = 50
CreateSlider(Page_MySelf, "Ultra Jump", 50, 500, 50, 5, function(val)
	currentJumpPower = val
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.UseJumpPower = true
		LocalPlayer.Character.Humanoid.JumpPower = val
	end
end)

local autoJumpEnabled, autoJumpActive = false, false
local autoJumpBtn = CreateFloatingButton("🦘")

CreateToggle(Page_MySelf, "Auto Jump", false, 6, function(state)
	autoJumpEnabled = state
	autoJumpBtn.Visible = state
	if not state then autoJumpActive = false autoJumpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end
end)

autoJumpBtn.MouseButton1Click:Connect(function()
	if autoJumpEnabled then
		autoJumpActive = not autoJumpActive
		autoJumpBtn.BackgroundColor3 = autoJumpActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(30, 30, 30)
	end
end)

RunService.RenderStepped:Connect(function()
	if autoJumpEnabled and autoJumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.Jump = true
	end
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		if currentJumpPower ~= 50 then
			LocalPlayer.Character.Humanoid.UseJumpPower = true
			LocalPlayer.Character.Humanoid.JumpPower = currentJumpPower
		end
	end
end)

local geppoEnabled = false
CreateToggle(Page_MySelf, "Geppo (Air Jump)", false, 7, function(state) geppoEnabled = state end)

UserInputService.JumpRequest:Connect(function()
	if geppoEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- === 3. Noclip & Invisibility ===
CreateSectionHeader(Page_MySelf, "3. ทะลุกำแพง & ล่องหน", 8)

local kamuiEnabled = false
CreateToggle(Page_MySelf, "Kamui (Noclip)", false, 9, function(state) kamuiEnabled = state end)

-- FIXED NOCLIP LOOP
RunService.Stepped:Connect(function()
	local shouldNoclip = kamuiEnabled or flyKamuiEnabled or isTweeningToTarget
	if shouldNoclip and LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end
end)

-- Invisibility Function (FE Invisible Trick)
local invisibleEnabled = false
CreateToggle(Page_MySelf, "Invisibility (ล่องหนคนมองไม่เห็น)", false, 10, function(state)
	invisibleEnabled = state
	local char = LocalPlayer.Character
	if char then
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") or p:IsA("Decal") then
				p.Transparency = state and 1 or 0
			end
		end
	end
end)

-- === 4. God Mode (อมตะ รูปแบบที่ 1) ===
CreateSectionHeader(Page_MySelf, "4. ระบบอมตะ (God Mode)", 11)

local godModeEnabled = false
CreateToggle(Page_MySelf, "God Mode (Lock Health)", false, 12, function(state)
	godModeEnabled = state
	if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Dead, true)
	end
end)

RunService.Stepped:Connect(function()
	if godModeEnabled and LocalPlayer.Character then
		local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Health = hum.MaxHealth
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		end
	end
end)

-- === 5. Physics Fly (Mobile Native) ===
CreateSectionHeader(Page_MySelf, "5. ระบบบิน (Physics Fly Mobile)", 13)

local flySpeed = 5
CreateSlider(Page_MySelf, "Fly Speed", 1, 100, 5, 14, function(val) flySpeed = val end)

local flyEnabled, flyKamuiEnabled = false, false
local flyKamuiSpeed = 5
CreateSlider(Page_MySelf, "Fly Kamui Speed", 1, 100, 5, 16, function(val) flyKamuiSpeed = val end)

local bodyVelocity, bodyGyro = nil, nil

local function StopPhysicsFly()
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end
end

local function StartPhysicsFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end

	StopPhysicsFly()
	hum.PlatformStand = true

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = hrp

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
	bodyGyro.P = 10000
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp
end

CreateToggle(Page_MySelf, "Fly (Superman Flight)", false, 15, function(state)
	flyEnabled = state
	if flyEnabled then StartPhysicsFly() else StopPhysicsFly() end
end)

CreateToggle(Page_MySelf, "Fly Kamui (Noclip Fly)", false, 17, function(state)
	flyKamuiEnabled = state
	if flyKamuiEnabled then StartPhysicsFly() else StopPhysicsFly() end
end)

RunService.RenderStepped:Connect(function()
	local isFlying = flyEnabled or flyKamuiEnabled
	local activeSpeed = flyKamuiEnabled and flyKamuiSpeed or flySpeed

	if isFlying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local char = LocalPlayer.Character
		local hrp = char.HumanoidRootPart
		local hum = char:FindFirstChildOfClass("Humanoid")
		local cam = workspace.CurrentCamera

		if not bodyVelocity or not bodyGyro or bodyVelocity.Parent ~= hrp then StartPhysicsFly() end

		local moveVector = hum and hum.MoveDirection or Vector3.zero
		local realVelocity = activeSpeed * 10

		if moveVector.Magnitude > 0 then
			local camCFrame = cam.CFrame
			local flyDirection = (camCFrame.LookVector * -moveVector.Z) + (camCFrame.RightVector * moveVector.X)
			if flyDirection.Magnitude > 0 then flyDirection = flyDirection.Unit end

			bodyVelocity.Velocity = flyDirection * realVelocity
			bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flyDirection) * CFrame.Angles(math.rad(-70), 0, 0)
		else
			bodyVelocity.Velocity = Vector3.zero
			bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + cam.CFrame.LookVector)
		end
	end
end)

-- === 6. Night Vision ===
CreateSectionHeader(Page_MySelf, "6. เติมแสง (Night Vision VIP)", 18)

_G.FullBrightEnabled = false
if not _G.FullBrightExecuted 
