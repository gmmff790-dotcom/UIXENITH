if getgenv().Library then 
	getgenv().Library:Unload()
end

if not isfolder("eclipse") then
	makefolder("eclipse")
end

if not isfolder("eclipse/Assets") then
	makefolder("eclipse/Assets")
end

if not isfolder("eclipse/Configs") then
	makefolder("eclipse/Configs")
end

if not isfolder("eclipse/Themes") then
	makefolder("eclipse/Themes")
end

local Library do
	local Workspace = game:GetService("Workspace")
	local UserInputService = game:GetService("UserInputService")
	local Players = game:GetService("Players")
	local HttpService = game:GetService("HttpService")
	local RunService = game:GetService("RunService")
	local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
	local TweenService = game:GetService("TweenService")
	local Stats = game:GetService("Stats")

	gethui = gethui or function()
		return CoreGui
	end

	local LocalPlayer = Players.LocalPlayer
	local Camera = Workspace.CurrentCamera
	local Mouse = LocalPlayer:GetMouse()

	local FromRGB = Color3.fromRGB
	local FromHSV = Color3.fromHSV
	local FromHex = Color3.fromHex

	local RGBSequence = ColorSequence.new
	local RGBSequenceKeypoint = ColorSequenceKeypoint.new
	local NumSequence = NumberSequence.new
	local NumSequenceKeypoint = NumberSequenceKeypoint.new

	local UDim2New = UDim2.new
	local UDimNew = UDim.new
	local Vector2New = Vector2.new

	local MathClamp = math.clamp
	local MathFloor = math.floor
	local MathAbs = math.abs
	local MathSin = math.sin

	local TableInsert = table.insert
	local TableFind = table.find
	local TableRemove = table.remove
	local TableConcat = table.concat
	local TableClone = table.clone
	local TableUnpack = table.unpack

	local StringFormat = string.format
	local StringFind = string.find
	local StringGSub = string.gsub
	local StringLower = string.lower

	local InstanceNew = Instance.new

	local MathMax = math.max
	local MathRad = math.rad

	local Vector3New = Vector3.new
	local CFrameNew = CFrame.new
	local CFrameAngles = CFrame.Angles

	local RectNew = Rect.new

	local IsMobile = false

	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
		IsMobile = true
	elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		IsMobile = false
	elseif UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then 
		IsMobile = false
	end

	Library = {
		Theme =  { },
		Themes = { },

		MenuKeybind = tostring(Enum.KeyCode.RightControl), 
		Flags = { },

		Tween = {
			Time = 0.25,
			Style = Enum.EasingStyle.Quart,
			Direction = Enum.EasingDirection.Out
		},

		Folders = {
			Directory = "eclipse",
			Configs = "eclipse/Configs",
			Assets = "eclipse/Assets",
			Themes = "eclipse/Themes"
		},

		Images = {
			["Saturation"] = {"Saturation.png", "https://github.com/sametexe001/images/blob/main/saturation.png?raw=true" },
			["Value"] = { "Value.png", "https://github.com/sametexe001/images/blob/main/value.png?raw=true" },
			["Hue"] = { "Hue.png", "https://github.com/sametexe001/images/blob/main/horizontalhue.png?raw=true" },
			["Checkers"] = { "Checkers.png", "https://github.com/sametexe001/images/blob/main/checkers.png?raw=true" },
		},

		Pages = { },
		Sections = { },

		Connections = { },
		Threads = { },

		ThemeMap = { },
		ThemeItems = { },

		OpenFrames = { },

		CurrentPage = nil,

		SearchItems = { },

		ThemeColorpickers = { },

		SetFlags = { },

		UnnamedConnections = 0,
		UnnamedFlags = 0,

		Holder = nil,
		NotifHolder = nil,
		UnusedHolder = nil,
		Font = nil,
		KeyList = nil
	}

	Library.__index = Library

	Library.Sections.__index = Library.Sections
	Library.Pages.__index = Library.Pages

	local Keys = {
		["Unknown"]           = "Unknown",
		["Backspace"]         = "Back",
		["Tab"]               = "Tab",
		["Clear"]             = "Clear",
		["Return"]            = "Return",
		["Pause"]             = "Pause",
		["Escape"]            = "Escape",
		["Space"]             = "Space",
		["QuotedDouble"]      = '"',
		["Hash"]              = "#",
		["Dollar"]            = "$",
		["Percent"]           = "%",
		["Ampersand"]         = "&",
		["Quote"]             = "'",
		["LeftParenthesis"]   = "(",
		["RightParenthesis"]  = " )",
		["Asterisk"]          = "*",
		["Plus"]              = "+",
		["Comma"]             = ",",
		["Minus"]             = "-",
		["Period"]            = ".",
		["Slash"]             = "`",
		["Three"]             = "3",
		["Seven"]             = "7",
		["Eight"]             = "8",
		["Colon"]             = ":",
		["Semicolon"]         = ";",
		["LessThan"]          = "<",
		["GreaterThan"]       = ">",
		["Question"]          = "?",
		["Equals"]            = "=",
		["At"]                = "@",
		["LeftBracket"]       = "LeftBracket",
		["RightBracket"]      = "RightBracked",
		["BackSlash"]         = "BackSlash",
		["Caret"]             = "^",
		["Underscore"]        = "_",
		["Backquote"]         = "`",
		["LeftCurly"]         = "{",
		["Pipe"]              = "|",
		["RightCurly"]        = "}",
		["Tilde"]             = "~",
		["Delete"]            = "Delete",
		["End"]               = "End",
		["KeypadZero"]        = "Keypad0",
		["KeypadOne"]         = "Keypad1",
		["KeypadTwo"]         = "Keypad2",
		["KeypadThree"]       = "Keypad3",
		["KeypadFour"]        = "Keypad4",
		["KeypadFive"]        = "Keypad5",
		["KeypadSix"]         = "Keypad6",
		["KeypadSeven"]       = "Keypad7",
		["KeypadEight"]       = "Keypad8",
		["KeypadNine"]        = "Keypad9",
		["KeypadPeriod"]      = "KeypadP",
		["KeypadDivide"]      = "KeypadD",
		["KeypadMultiply"]    = "KeypadM",
		["KeypadMinus"]       = "KeypadM",
		["KeypadPlus"]        = "KeypadP",
		["KeypadEnter"]       = "KeypadE",
		["KeypadEquals"]      = "KeypadE",
		["Insert"]            = "Insert",
		["Home"]              = "Home",
		["PageUp"]            = "PageUp",
		["PageDown"]          = "PageDown",
		["RightShift"]        = "RightShift",
		["LeftShift"]         = "LeftShift",
		["RightControl"]      = "RightControl",
		["LeftControl"]       = "LeftControl",
		["LeftAlt"]           = "LeftAlt",
		["RightAlt"]          = "RightAlt"
	}

	local Themes = {
		["Default"] = {
			["Background"] = FromRGB(15, 12, 16),
			["Inline"] = FromRGB(22, 20, 24),
			["Border"] = FromRGB(41, 37, 45),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(255, 255, 255),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(232, 186, 248),
			["Element"] = FromRGB(36, 32, 39),
			["Gradient"] = FromRGB(216, 216, 216)
		},
		["Halloween"] = {
			["Background"] = FromRGB(48, 24, 7),
			["Inline"] = FromRGB(34, 14, 8),
			["Border"] = FromRGB(79, 40, 16),
			["Shadow"] = FromRGB(255, 98, 0),
			["Text"] = FromRGB(195, 195, 195),
			["Inactive Text"] = FromRGB(116, 116, 116),
			["Accent"] = FromRGB(255, 98, 0),
			["Element"] = FromRGB(68, 28, 0),
			["Gradient"] = FromRGB(150, 150, 150)
		},
		["Aqua"] = {
			["Background"] = FromRGB(19, 21, 23),
			["Inline"] = FromRGB(31, 35, 39),
			["Border"] = FromRGB(48, 56, 63),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(245, 245, 245),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(31, 106, 181),
			["Element"] = FromRGB(58, 66, 77),
			["Gradient"] = FromRGB(211, 211, 211)
		},
		["Onetap"] = {
			["Background"] = FromRGB(51, 51, 51),
			["Inline"] = FromRGB(30, 30, 30),
			["Border"] = FromRGB(0, 0, 0),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(255, 255, 255),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(237, 170, 0),
			["Element"] = FromRGB(45, 45, 45),
			["Gradient"] = FromRGB(211, 211, 211)
		},
		["Bitchbot"] = {
			["Background"] = FromRGB(33, 33, 33),
			["Inline"] = FromRGB(14, 14, 14),
			["Border"] = FromRGB(0, 0, 0),
			["Shadow"] = FromRGB(0, 0, 0),
			["Text"] = FromRGB(255, 255, 255),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(158, 79, 249),
			["Element"] = FromRGB(22, 20, 20),
			["Gradient"] = FromRGB(211, 211, 211)
		},
		["Gamesense"] = {
			["Background"] = FromRGB(22, 22, 22),
			["Inline"] = FromRGB(17, 17, 17),
			["Border"] = FromRGB(37, 37, 37),
			["Shadow"] = FromRGB(34, 34, 34),
			["Text"] = FromRGB(255, 255, 255),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(211, 255, 53),
			["Element"] = FromRGB(53, 53, 53),
			["Gradient"] = FromRGB(156, 156, 156)
		}
	}

	Library.Theme = TableClone(Themes["Default"])
	Library.Themes = Themes

	for Index, Value in Library.Folders do 
		if not isfolder(Value) then
			makefolder(Value)
		end
	end

	if not isfile(Library.Folders.Directory .. "/autoload.json") then 
		writefile(Library.Folders.Directory .. "/autoload.json", "")
	end

	for Index, Value in Library.Images do 
		local ImageData = Value
		local ImageName = ImageData[1]
		local ImageLink = ImageData[2]

		if not isfile(Library.Folders.Assets .. "/" .. ImageName) then
			writefile(Library.Folders.Assets .. "/" .. ImageName, game:HttpGet(ImageLink))
		end
	end

	local Tween = { } do
		Tween.__index = Tween

		Tween.Create = function(self, Item, Info, Goal, IsRawItem)
			Item = IsRawItem and Item or Item.Instance
			Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

			local NewTween = {
				Tween = TweenService:Create(Item, Info, Goal),
				Info = Info,
				Goal = Goal,
				Item = Item
			}

			NewTween.Tween:Play()
			setmetatable(NewTween, Tween)
			return NewTween
		end

		Tween.GetProperty = function(self, Item)
			Item = Item or self.Item 

			if Item:IsA("Frame") then
				return { "BackgroundTransparency" }
			elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
				return { "BackgroundTransparency", "ImageTransparency" }
			elseif Item:IsA("ScrollingFrame") then
				return { "BackgroundTransparency", "ScrollBarImageTransparency" }
			elseif Item:IsA("TextBox") then
				return { "TextTransparency", "BackgroundTransparency" }
			elseif Item:IsA("UIStroke") then 
				return { "Transparency" }
			end
		end

		Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
			local Item = Item or self.Item 
			local OldTransparency = Item[Property]
			Item[Property] = Visibility and 1 or OldTransparency

			local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
				[Property] = Visibility and OldTransparency or 1
			}, true)

			Library:Connect(NewTween.Tween.Completed, function()
				if not Visibility then 
					task.wait()
					Item[Property] = OldTransparency
				end
			end)

			return NewTween
		end
	end

	local Instances = { } do
		Instances.__index = Instances

		Instances.Create = function(self, Class, Properties)
			local NewItem = {
				Instance = InstanceNew(Class),
				Properties = Properties,
				Class = Class
			}

			setmetatable(NewItem, Instances)

			for Property, Value in NewItem.Properties do
				NewItem.Instance[Property] = Value
			end

			return NewItem
		end

		Instances.Border = function(self)
			if not self.Instance then return end
			local Item = self.Instance
			local UIStroke = Instances:Create("UIStroke", {
				Parent = Item,
				Color = Library.Theme.Border,
				Thickness = 1,
				LineJoinMode = Enum.LineJoinMode.Miter
			})
			UIStroke:AddToTheme({Color = "Border"})
			return UIStroke
		end

		Instances.Tooltip = function(self, Text)
			if not self.Instance or Text == nil then return end
			local Gui = self.Instance
			local MouseLocation = UserInputService:GetMouseLocation()
			local RenderStepped

			local Items = { } do
				Items["Tooltip"] = Instances:Create("Frame", {
					Parent = Library.Holder.Instance,
					Name = "\0",
					BackgroundColor3 = FromRGB(15, 12, 16),
					BorderSizePixel = 0,
					Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 22),
					Size = UDim2New(0, 0, 0, 0),
					BackgroundTransparency = 1,
					Visible = true,
					AutomaticSize = Enum.AutomaticSize.XY,
					ZIndex = 99
				})  Items["Tooltip"]:AddToTheme({BackgroundColor3 = "Background"})

				Items["Text"] = Instances:Create("TextLabel", {
					Parent = Items["Tooltip"].Instance,
					Name = "\0",
					FontFace = Library.Font,
					TextColor3 = FromRGB(255, 255, 255),
					BorderColor3 = FromRGB(0, 0, 0),
					Text = Text,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					Size = UDim2New(1, 0, 1, 0),
					ClipsDescendants = true,
					ZIndex = 99,
					TextTransparency = 1,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextSize = 14,
					BackgroundColor3 = FromRGB(15, 12, 16)
				})  Items["Text"]:AddToTheme({TextColor3 = "Text"})

				Instances:Create("UIPadding", {
					Parent = Items["Text"].Instance,
					Name = "\0",
					PaddingBottom = UDimNew(0, 8),
					PaddingLeft = UDimNew(0, 8),
					PaddingRight = UDimNew(0, 8),
					PaddingTop = UDimNew(0, 8),
				})

				Instances:Create("UICorner", {
					Parent = Items["Tooltip"].Instance,
					Name = "\0",
					CornerRadius = UDimNew(0, 5)
				})
			end

			Library:Connect(Gui.MouseEnter, function()
				Items["Tooltip"].Instance.Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 42)
				Items["Tooltip"]:Tween(nil, {BackgroundTransparency = 0})
				Items["Text"]:Tween(nil, {TextTransparency = 0})

				RenderStepped = RunService.RenderStepped:Connect(function()
					MouseLocation = UserInputService:GetMouseLocation()
					Items["Tooltip"]:Tween(nil, {Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 42)})
				end)
			end)

			Library:Connect(Gui.MouseLeave, function()
				Items["Tooltip"]:Tween(nil, {BackgroundTransparency = 1})
				Items["Text"]:Tween(nil, {TextTransparency = 1})

				if RenderStepped then 
					RenderStepped:Disconnect()
					RenderStepped = nil
				end
			end)
		end

		Instances.AddToTheme = function(self, Properties)
			if not self.Instance then return end
			Library:AddToTheme(self, Properties)
		end

		Instances.ChangeItemTheme = function(self, Properties)
			if not self.Instance then return end
			Library:ChangeItemTheme(self, Properties)
		end

		Instances.Connect = function(self, Event, Callback, Name)
			if not self.Instance or not self.Instance[Event] then return end
			if Event == "MouseButton1Down" or Event == "MouseButton1Click" then 
				if IsMobile then Event = "TouchTap" end
			elseif Event == "MouseButton2Down" or Event == "MouseButton2Click" then 
				if IsMobile then Event = "TouchLongPress" end
			end
			return Library:Connect(self.Instance[Event], Callback, Name)
		end

		Instances.Tween = function(self, Info, Goal)
			if not self.Instance then return end
			return Tween:Create(self, Info, Goal)
		end

		Instances.Clean = function(self)
			if not self.Instance then return end
			self.Instance:Destroy()
			self = nil
		end

		Instances.MakeDraggable = function(self)
			if not self.Instance then return end
			local Gui = self.Instance
			local Dragging = false 
			local DragStart
			local StartPosition 

			local Set = function(Input)
				local DragDelta = Input.Position - DragStart
				self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(StartPosition.X.Scale, StartPosition.X.Offset + DragDelta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + DragDelta.Y)})
			end

			self:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = Input.Position
					StartPosition = Gui.Position

					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end)
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if Dragging then
						Set(Input)
					end
				end
			end)

			return Dragging
		end

		Instances.MakeResizeable = function(self, Minimum, Maximum)
			if not self.Instance then return end
			local Gui = self.Instance
			local Resizing = false 
			local Start = UDim2New()
			local Delta = UDim2New()
			local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

			local ResizeButton = Instances:Create("ImageButton", {
				Parent = Gui,
				Image = "rbxassetid://7368471234",
				AnchorPoint = Vector2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 6, 0, 6),
				Position = UDim2New(1, -4, 1, -4),
				Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				ZIndex = 5,
				AutoButtonColor = false,
				Visible = true,
			})

			ResizeButton:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Resizing = true
					Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)

					Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Resizing = false
						end
					end)
				end
			end)

			Library:Connect(UserInputService.InputChanged, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
					if Resizing then
						ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize
						Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
						Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))
						Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
					end
				end
			end)

			return Resizing
		end
	end

	local CustomFont = { } do
		function CustomFont:New(Name, Weight, Style, Data)
			if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
				return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
			end

			if not isfile(Library.Folders.Assets .. "/" .. Name .. ".ttf") then 
				writefile(Library.Folders.Assets .. "/" .. Name .. ".ttf", game:HttpGet(Data.Url))
			end

			local FontData = {
				name = Name,
				faces = { {
					name = "Regular",
					weight = Weight,
					style = Style,
					assetId = getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".ttf")
				} }
			}

			writefile(Library.Folders.Assets .. "/" .. Name .. ".json", HttpService:JSONEncode(FontData))
			return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
		end

		function CustomFont:Get(Name)
			if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
				return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
			end
		end

		CustomFont:New("Inter", 200, "Regular", {
			Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
		})

		Library.Font = CustomFont:Get("Inter")
	end

	Library.Holder = Instances:Create("ScreenGui", {
		Parent = gethui(),
		Name = "\0",
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		DisplayOrder = 2,
		ResetOnSpawn = false
	})

	Library.UnusedHolder = Instances:Create("ScreenGui", {
		Parent = gethui(),
		Name = "\0",
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		Enabled = false,
		ResetOnSpawn = false
	})

	Library.NotifHolder = Instances:Create("Frame", {
		Parent = Library.Holder.Instance,
		Name = "\0",
		BorderColor3 = FromRGB(0, 0, 0),
		AnchorPoint = Vector2New(1, 0),
		BackgroundTransparency = 1,
		Position = UDim2New(1, 0, 0, 0),
		Size = UDim2New(0, 0, 1, 0),
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = FromRGB(255, 255, 255)
	})

	Instances:Create("UIListLayout", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		Padding = UDimNew(0, 12),
		SortOrder = Enum.SortOrder.LayoutOrder
	})

	Instances:Create("UIPadding", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		PaddingTop = UDimNew(0, 12),
		PaddingBottom = UDimNew(0, 12),
		PaddingRight = UDimNew(0, 12),
		PaddingLeft = UDimNew(0, 12)
	})

	Library.Unload = function(self)
		for Index, Value in self.Connections do 
			Value.Connection:Disconnect()
		end

		for Index, Value in self.Threads do 
			coroutine.close(Value)
		end

		if self.Holder then 
			self.Holder:Clean()
		end

		Library = nil 
		getgenv().Library = nil
		UserInputService.MouseIconEnabled = true
	end

	Library.GetImage = function(self, Image)
		local ImageData = self.Images[Image]
		if not ImageData then return end
		return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
	end

	Library.Round = function(self, Number, Float)
		local Multiplier = 1 / (Float or 1)
		return MathFloor(Number * Multiplier) / Multiplier
	end

	Library.Thread = function(self, Function)
		local NewThread = coroutine.create(Function)
		coroutine.wrap(function()
			coroutine.resume(NewThread)
		end)()
		TableInsert(self.Threads, NewThread)
		return NewThread
	end

	Library.SafeCall = function(self, Function, ...)
		local Arguements = { ... }
		local Success, Result = pcall(Function, TableUnpack(Arguements))
		if not Success then
			warn(Result)
			return false
		end
		return Success
	end

	Library.Connect = function(self, Event, Callback, Name)
		Name = Name or StringFormat("Connection%s%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))
		local NewConnection = {
			Event = Event,
			Callback = Callback,
			Name = Name,
			Connection = nil
		}
		Library:Thread(function()
			NewConnection.Connection = Event:Connect(Callback)
		end)
		TableInsert(self.Connections, NewConnection)
		return NewConnection
	end

	Library.NextFlag = function(self)
		local FlagNumber = self.UnnamedFlags + 1
		return StringFormat("flag_number_%s_%s", FlagNumber, HttpService:GenerateGUID(false))
	end

	Library.AddToTheme = function(self, Item, Properties)
		Item = Item.Instance or Item 
		local ThemeData = {
			Item = Item,
			Properties = Properties,
		}
		for Property, Value in ThemeData.Properties do
			if type(Value) == "string" then
				Item[Property] = self.Theme[Value]
			else
				Item[Property] = Value()
			end
		end
		TableInsert(self.ThemeItems, ThemeData)
		self.ThemeMap[Item] = ThemeData
	end

	Library.RemoveFromTheme = function(self, Item)
		Item = Item.Instance or Item
		if not self.ThemeMap[Item] then return end
		self.ThemeMap[Item].Properties = nil
		self.ThemeMap[Item] = nil
	end

	Library.GetConfig = function(self)
		local Config = { } 
		Library:SafeCall(function()
			for Index, Value in Library.Flags do 
				if type(Value) == "table" and Value.Key then
					Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
				elseif type(Value) == "table" and Value.Color then
					Config[Index] = {Color = "#" .. Value.Color, Alpha = Value.Alpha}
				else
					Config[Index] = Value
				end
			end
		end)
		return HttpService:JSONEncode(Config)
	end

	Library.LoadConfig = function(self, Config)
		local Decoded = HttpService:JSONDecode(Config)
		local Success, Result = Library:SafeCall(function()
			for Index, Value in Decoded do 
				local SetFunction = Library.SetFlags[Index]
				if not SetFunction then continue end
				if type(Value) == "table" and Value.Key then 
					SetFunction(Value)
				elseif type(Value) == "table" and Value.Color then
					SetFunction(Value.Color, Value.Alpha)
				else
					SetFunction(Value)
				end
			end
		end)
		return Success, Result
	end

	Library.DeleteConfig = function(self, Config)
		if isfile(Library.Folders.Configs .. "/" .. Config) then 
			delfile(Library.Folders.Configs .. "/" .. Config)
		end
	end

	Library.RefreshConfigsList = function(self, Element)
		local CurrentList = {}
		local List = {}
		local ConfigFolderName = string.gsub(self.Folders.Configs, self.Folders.Directory .. "/", "")

		for Index, Value in listfiles(self.Folders.Configs) do
			local v = tostring(Value):gsub("\\", "/")
			local root = (self.Folders.Directory .. "/" .. ConfigFolderName .. "/")
			root = root:gsub("([%^%$%(%)%.%[%]%*%+%-%?])", "%%%1")
			local FileName = v:gsub("^" .. root, "")

			if not string.find(FileName, tostring(game.GameId), 1, true) then
				continue
			end

			local RealName = string.gsub(FileName, tostring(game.GameId), "")
			List[Index] = { Name = RealName, RealName = FileName }
		end

		Element:Clear()
		for _, Value in List do
			Element:Add(Value.Name)
		end
	end

	Library.ChangeTheme = function(self, Theme, Color)
		self.Theme[Theme] = Color
		for _, Item in self.ThemeItems do
			if not Item.Properties then continue end
			for Property, Value in Item.Properties do
				if type(Value) == "string" and Value == Theme then
					Item.Item[Property] = Color
				elseif type(Value) == "function" then
					Item.Item[Property] = Value()
				end
			end
		end
	end

	Library.IsMouseOverFrame = function(self, Frame, XOffset, YOffset)
		Frame = Frame.Instance
		XOffset = XOffset or 0 
		YOffset = YOffset or 0
		local MousePosition = Vector2New(Mouse.X + XOffset, Mouse.Y + YOffset)
		return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
			and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
	end

	Library.Window = function(self, Properties)
		Properties = Properties or { }

		local Window = {
			Name = Properties.Name or Properties.name or "eclipse",
			Size = Properties.Size or Properties.size or (not IsMobile and UDim2New(0, 770, 0, 526) or UDim2New(0, 526, 0, 350)),
			FadeSpeed = Properties.FadeSpeed or Properties.fadespeed or 0.25,
			BackgroundIcon = Properties.BackgroundIcon or Properties.backgroundicon or "rbxassetid://",
			Pages = { },
			IsOpen = false,
			Items = { }
		}

		local Items = { } do
			Items["MainFrame"] = Instances:Create("Frame", {
				Parent = (Library.Holder and Library.Holder.Instance) or nil,
				Name = "\0",
				BorderColor3 = FromRGB(0, 0, 0),
				AnchorPoint = Vector2New(0, 0),
				BackgroundTransparency = 0.3,
				Position = UDim2New(0, Camera.ViewportSize.X / 3.5, 0, Camera.ViewportSize.Y / 3.5),
				Size = Window.Size,
				ClipsDescendants = true,
				Visible = true,
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(15, 12, 16)
			})  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

			Items["MainFrame"]:MakeDraggable()
			Items["MainFrame"]:MakeResizeable(Vector2New(Window.Size.X.Offset, Window.Size.Y.Offset), Vector2New(9999, 9999))

			-- [ ปรับแต่งเพิ่มโลโก้ค่ายตรงนี้ ] --
			Items["CompanyLogo"] = Instances:Create("ImageLabel", {
				Parent = Items["MainFrame"].Instance,
				Name = "CompanyLogo",
				Image = "rbxassetid://126239192307237",
				BackgroundTransparency = 1,
				Size = UDim2New(0, 16, 0, 16),
				Position = UDim2New(0, 8, 0, 8),
				ZIndex = 3,
				ScaleType = Enum.ScaleType.Fit
			})

			Items["Title"] = Instances:Create("TextLabel", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				FontFace = Library.Font,
				TextColor3 = FromRGB(255, 255, 255),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Window.Name,
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2New(0, 0, 0, 15),
				BackgroundTransparency = 1,
				Position = UDim2New(0, 30, 0, 8), -- ขยับข้อความ Title หลบโลโก้เล็กน้อย
				BorderSizePixel = 0,
				ZIndex = 2,
				TextSize = 14,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})  Items["Title"]:AddToTheme({TextColor3 = "Text"})

			Items["Pages"] = Instances:Create("Frame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				BorderColor3 = FromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Position = UDim2New(0, 0, 0, 30),
				Size = not IsMobile and UDim2New(0, 224, 1, -30) or UDim2New(0, 150, 1, -30),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})

			Instances:Create("UIPadding", {
				Parent = Items["Pages"].Instance,
				Name = "\0",
				PaddingRight = UDimNew(0, 8),
				PaddingLeft = UDimNew(0, 8)
			})

			Instances:Create("UIListLayout", {
				Parent = Items["Pages"].Instance,
				Name = "\0",
				Padding = UDimNew(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder
			})

			Items["Content"] = Instances:Create("Frame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				BorderColor3 = FromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Position = not IsMobile and UDim2New(0, 225, 0, 30) or UDim2New(0, 163, 0, 30),
				Size = not IsMobile and UDim2New(1, -233, 1, -38) or UDim2New(1, -171, 1, -38),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})

			Items["MinimizeButton"] = Instances:Create("ImageButton", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 17, 0, 17),
				AutoButtonColor = false,
				AnchorPoint = Vector2New(1, 0),
				Image = "rbxassetid://94817928404736",
				Position = UDim2New(1, -27, 0, 3),
				BackgroundTransparency = 1,
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})

			Instances:Create("Frame", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				Size = UDim2New(0, 1, 1, 0),
				Position = not IsMobile and UDim2New(0, 220, 0, 0) or UDim2New(0, 152, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(41, 37, 45)
			}):AddToTheme({BackgroundColor3 = "Border"})

			Items["CloseButton"] = Instances:Create("ImageButton", {
				Parent = Items["MainFrame"].Instance,
				Name = "\0",
				ScaleType = Enum.ScaleType.Fit,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 17, 0, 17),
				AutoButtonColor = false,
				AnchorPoint = Vector2New(1, 0),
				Image = "rbxassetid://76001605964586",
				BackgroundTransparency = 1,
				Position = UDim2New(1, -8, 0, 8),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})

			Items["Search"] = Instances:Create("Frame", {
				Parent = Items["Content"].Instance,
				Name = "\0",
				Size = UDim2New(1, 0, 0, 35),
				BorderColor3 = FromRGB(0, 0, 0),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(22, 20, 24)
			})  Items["Search"]:AddToTheme({BackgroundColor3 = "Inline"})

			Instances:Create("UICorner", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Icon"] = Instances:Create("ImageLabel", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				ScaleType = Enum.ScaleType.Fit,
				ImageTransparency = 0.4000000059604645,
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 20, 0, 20),
				AnchorPoint = Vector2New(0, 0.5),
				Image = "rbxassetid://71924825350727",
				BackgroundTransparency = 1,
				Position = UDim2New(0, 8, 0.5, 0),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})

			Items["Input"] = Instances:Create("TextBox", {
				Parent = Items["Search"].Instance,
				Name = "\0",
				FontFace = Library.Font,
				AnchorPoint = Vector2New(0, 0.5),
				PlaceholderColor3 = FromRGB(185, 185, 185),
				PlaceholderText = "Search..",
				TextSize = 14,
				Size = UDim2New(1, -43, 0, 15),
				TextColor3 = FromRGB(255, 255, 255),
				BorderColor3 = FromRGB(0, 0, 0),
				Text = "",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,
				Position = UDim2New(0, 35, 0.5, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(255, 255, 255)
			})  Items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Inactive Text"})

			Items["Cursor"] = Instances:Create("Frame", {
				Parent = Library.Holder.Instance,
				Name = "\0",
				BackgroundTransparency = 1,
				Position = UDim2New(0, 0, 0, 0),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 16, 0, 16),
				BorderSizePixel = 0,
				BackgroundColor3 = FromRGB(0, 0, 0)
			})

			Items["Image"] = Instances:Create("ImageLabel", {
				Parent = Items["Cursor"].Instance,
				Name = "\0",
				ImageColor3 = FromRGB(232, 186, 248),
				BorderColor3 = FromRGB(0, 0, 0),
				Image = "rbxassetid://132511743665753",
				BackgroundTransparency = 1,
				Size = UDim2New(0, 16, 0, 16),
				BorderSizePixel = 0,
				ZIndex = 10001,
				Rotation = -90,
				BackgroundColor3 = FromRGB(232, 186, 248)
			})  Items["Image"]:AddToTheme({ImageColor3 = "Accent"})

			Window.Items = Items
		end

		UserInputService.MouseIconEnabled = false

		function Window:SetBackgroundTransparency(Value)
			Items["MainFrame"].Instance.BackgroundTransparency = Value
		end

		local RenderStepped
		Items["Input"]:Connect("Focused", function()
			local PageSearchData = Library.SearchItems[Library.CurrentPage]
			if not PageSearchData then return end
			RenderStepped = RunService.RenderStepped:Connect(function()
				for Index, Value in PageSearchData do 
					local Name = Value.Name
					local Element = Value.Item
					if StringFind(StringLower(Name), StringLower(Items["Input"].Instance.Text)) then
						Element.Instance.Visible = true 
					else
						Element.Instance.Visible = false
					end
				end
			end)
		end)

		Items["Input"]:Connect("FocusLost", function()
			if RenderStepped then 
				RenderStepped:Disconnect()
				RenderStepped = nil
			end
		end)

		local IsMinisize = false
		local IsOpen = false
		local OldSize = Items["MainFrame"].Instance.AbsoluteSize

		function Window:Minimize(Bool)
			IsMinisize = Bool
			if IsMinisize then 
				Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, OldSize.X, 0, 35)})
			else
				Items["MainFrame"]:Tween(nil, {Size = UDim2New(0, OldSize.X, 0, OldSize.Y)})
			end
		end

		function Window:SetOpen(Bool)
			IsOpen = Bool
			Items["MainFrame"].Instance.Visible = IsOpen
		end

		Library:Connect(UserInputService.InputBegan, function(Input)
			if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
				Window.IsOpen = not Window.IsOpen
				Items["Image"].Instance.Visible = Window.IsOpen
				UserInputService.MouseIconEnabled = not Window.IsOpen
				Items["MainFrame"].Instance.Visible = Window.IsOpen
			end
		end)

		Library:Connect(RunService.RenderStepped, function()
			local MouseLocation = UserInputService:GetMouseLocation() 
			Items["Cursor"].Instance.Position = UDim2New(0, MouseLocation.X - 1, 0, MouseLocation.Y - 56)           
		end)

		Items["MinimizeButton"]:Connect("MouseButton1Down", function()
			Window:Minimize(not IsMinisize)
		end)

		Items["CloseButton"]:Connect("MouseButton1Down", function()
			Items["MainFrame"].Instance.Visible = false
			task.wait(0.1)
			Library:Unload()
		end)

		return setmetatable(Window, self)
	end

	return Library
end
