-- ESP.lua | AFSE Modular Script

return function(Tabs, Fluent)

    Tabs.ESP:AddParagraph({
        Title = "ESP Features",
        Content = "Toggle the features below to enable or disable ESP visuals."
    })

    -- === Chikara Boxes ESP ===
    local CurrentChikaraFill = Color3.fromRGB(255, 0, 0)
    local CurrentChikaraOutline = Color3.fromRGB(255, 255, 255)
    local chikaraHighlights = {}
    local chikaraConnection = nil

    local function updateChikaraHighlights()
        for _, h in pairs(chikaraHighlights) do 
            if h and h.Parent then 
                h.FillColor = CurrentChikaraFill 
                h.OutlineColor = CurrentChikaraOutline 
            end 
        end
    end

    Tabs.ESP:AddColorpicker("ChikaraFillColor", {
        Title = "Chikara Fill Color",
        Default = CurrentChikaraFill,
        Callback = function(c)
            CurrentChikaraFill = c
            updateChikaraHighlights()
        end
    })

    Tabs.ESP:AddColorpicker("ChikaraOutlineColor", {
        Title = "Chikara Outline Color",
        Default = CurrentChikaraOutline,
        Callback = function(c)
            CurrentChikaraOutline = c
            updateChikaraHighlights()
        end
    })

    Tabs.ESP:AddToggle("ChikaraBoxes", {
        Title = "Chikara Boxes",
        Default = false,
        Callback = function(state)
            local folder = workspace.Scriptable.ChikaraBoxes
            local function addHighlight(obj)
                if not chikaraHighlights[obj] then
                    local h = Instance.new("Highlight")
                    h.FillColor = CurrentChikaraFill
                    h.OutlineColor = CurrentChikaraOutline
                    h.FillTransparency = 0.5
                    h.OutlineTransparency = 0
                    h.Parent = obj
                    chikaraHighlights[obj] = h
                    obj.Destroying:Connect(function() chikaraHighlights[obj] = nil end)
                end
            end

            if state then
                for _, obj in ipairs(folder:GetChildren()) do addHighlight(obj) end
                chikaraConnection = folder.ChildAdded:Connect(addHighlight)
            else
                for _, h in pairs(chikaraHighlights) do if h then h:Destroy() end end
                chikaraHighlights = {}
                if chikaraConnection then chikaraConnection:Disconnect() chikaraConnection = nil end
            end
        end
    })

    -- === Mob ESP ===
    local CurrentMobFill = Color3.fromRGB(255, 0, 255)
    local CurrentMobOutline = Color3.fromRGB(255, 255, 255)
    local mobHighlights = {}
    local mobConnection = nil

    local function updateMobHighlights()
        for _, h in pairs(mobHighlights) do
            if h and h.Parent then
                h.FillColor = CurrentMobFill
                h.OutlineColor = CurrentMobOutline
            end
        end
    end

    local function clearAllMobHighlights()
        if mobConnection then mobConnection:Disconnect() mobConnection = nil end
        for _, h in pairs(mobHighlights) do if h then h:Destroy() end end
        mobHighlights = {}
    end

    local function addMobHighlight(obj)
        if not mobHighlights[obj] then
            local h = Instance.new("Highlight")
            h.Name = "MobESP"
            h.FillColor = CurrentMobFill
            h.OutlineColor = CurrentMobOutline
            h.FillTransparency = 0.4
            h.OutlineTransparency = 0
            h.Parent = obj
            mobHighlights[obj] = h
            obj.Destroying:Connect(function() mobHighlights[obj] = nil end)
        end
    end

    local function applyMobESP(mobType)
        clearAllMobHighlights()
        if mobType == "None" then return end

        local mobFolder = workspace.Scriptable.Mobs
        local mobMap = {
            Sarka = "1",
            Gen = "2",
            Igicho = "3",
            Booh = "5",
            Saytamu = "6",
            Remgonuk = "7"
        }

        local targetName = mobMap[mobType]
        if not targetName then return end

        for _, obj in ipairs(mobFolder:GetChildren()) do
            if obj.Name == targetName then
                addMobHighlight(obj)
            end
        end

        mobConnection = mobFolder.ChildAdded:Connect(function(child)
            if child.Name == targetName then
                addMobHighlight(child)
            end
        end)
    end

    Tabs.ESP:AddColorpicker("MobFillColor", {
        Title = "Mob Fill Color",
        Default = CurrentMobFill,
        Callback = function(c)
            CurrentMobFill = c
            updateMobHighlights()
        end
    })

    Tabs.ESP:AddColorpicker("MobOutlineColor", {
        Title = "Mob Outline Color",
        Default = CurrentMobOutline,
        Callback = function(c)
            CurrentMobOutline = c
            updateMobHighlights()
        end
    })

    Tabs.ESP:AddDropdown("MobESPSelector", {
        Title = "Mob ESP",
        Values = {"None", "Sarka", "Gen", "Igicho", "Booh", "Remgonuk", "Saytamu"},
        Default = "None",
        Callback = function(value)
            applyMobESP(value)
        end
    })

end