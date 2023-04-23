-- thanks to Cheeseot for the view model and attachment drawing stuff

local GUI = {}

GUI.Tab = gui.Tab(gui.Reference("Visuals"), "skyboxchams", "Skybox Chams")
GUI.GroupSelection = gui.Groupbox(GUI.Tab, "", 17, 17, 610, 20)
GUI.SelectionCombo = gui.Combobox(GUI.GroupSelection, "selection", "", "Enemy", "Friendly", "Local"); GUI.SelectionCombo:SetPosX(380); GUI.SelectionCombo:SetPosY(-50); GUI.SelectionCombo:SetWidth(200)
GUI.SelectionText = gui.Text(GUI.GroupSelection, "Selection"); GUI.SelectionText:SetPosY(-25)
GUI.SelectionText2 = gui.Text(GUI.GroupSelection, "Selection"); GUI.SelectionText2:SetPosY(-25)

GUI.EnemyModelGroup = gui.Groupbox(GUI.Tab, "Model", 17, 87, 610, 0)
GUI.EnemyModelOccluded = gui.Combobox(GUI.EnemyModelGroup, "enemy.model.occluded", "Occluded", "cock", "dick"); GUI.EnemyModelOccluded:SetWidth(280); GUI.EnemyModelOccluded:SetDescription("Material occluded by walls.")
GUI.EnemyModelOccludedColor = gui.ColorPicker(GUI.EnemyModelOccluded, "color", "", 28, 0, 152, 44 )
GUI.EnemyModelVisible = gui.Combobox(GUI.EnemyModelGroup, "enemy.model.visible", "Visible", "cock", "dick"); GUI.EnemyModelVisible:SetWidth(280); GUI.EnemyModelVisible:SetDescription("Visible material."); GUI.EnemyModelVisible:SetPosY(0); GUI.EnemyModelVisible:SetPosX(300)
GUI.EnemyModelVisibleColor = gui.ColorPicker(GUI.EnemyModelVisible, "color", "", 28, 0, 152, 44 )

GUI.EnemyAttachmentsGroup = gui.Groupbox(GUI.Tab, "Attachments", 17, 220, 610, 0)
GUI.EnemyAttachmentsOccluded = gui.Combobox(GUI.EnemyAttachmentsGroup, "enemy.attachments.occluded", "Occluded", "cock", "dick"); GUI.EnemyAttachmentsOccluded:SetWidth(280); GUI.EnemyAttachmentsOccluded:SetDescription("Material occluded by walls.")
GUI.EnemyAttachmentsOccludedColor = gui.ColorPicker(GUI.EnemyAttachmentsOccluded, "color", "", 28, 0, 152, 44 )
GUI.EnemyAttachmentsVisible = gui.Combobox(GUI.EnemyAttachmentsGroup, "enemy.attachments.visible", "Visible", "cock", "dick"); GUI.EnemyAttachmentsVisible:SetWidth(280); GUI.EnemyAttachmentsVisible:SetDescription("Visible material."); GUI.EnemyAttachmentsVisible:SetPosY(0); GUI.EnemyAttachmentsVisible:SetPosX(300)
GUI.EnemyAttachmentsVisibleColor = gui.ColorPicker(GUI.EnemyAttachmentsVisible, "color", "", 28, 0, 152, 44 )

GUI.FriendlyModelGroup = gui.Groupbox(GUI.Tab, "Model", 17, 87, 610, 0); GUI.FriendlyModelGroup:SetInvisible(true)
GUI.FriendlyModelOccluded = gui.Combobox(GUI.FriendlyModelGroup, "friendly.model.occluded", "Occluded", "cock", "dick"); GUI.FriendlyModelOccluded:SetWidth(280); GUI.FriendlyModelOccluded:SetDescription("Material occluded by walls.")
GUI.FriendlyModelOccludedColor = gui.ColorPicker(GUI.FriendlyModelOccluded, "color", "", 28, 0, 152, 44 )
GUI.FriendlyModelVisible = gui.Combobox(GUI.FriendlyModelGroup, "friendly.model.visible", "Visible", "cock", "dick"); GUI.FriendlyModelVisible:SetWidth(280); GUI.FriendlyModelVisible:SetDescription("Visible material."); GUI.FriendlyModelVisible:SetPosY(0); GUI.FriendlyModelVisible:SetPosX(300)
GUI.FriendlyModelVisibleColor = gui.ColorPicker(GUI.FriendlyModelVisible, "color", "", 28, 0, 152, 44 )

GUI.FriendlyAttachmentsGroup = gui.Groupbox(GUI.Tab, "Attachments", 17, 220, 610, 0); GUI.FriendlyAttachmentsGroup:SetInvisible(true)
GUI.FriendlyAttachmentsOccluded = gui.Combobox(GUI.FriendlyAttachmentsGroup, "friendly.attachments.occluded", "Occluded", "cock", "dick"); GUI.FriendlyAttachmentsOccluded:SetWidth(280); GUI.FriendlyAttachmentsOccluded:SetDescription("Material occluded by walls.")
GUI.FriendlyAttachmentsOccludedColor = gui.ColorPicker(GUI.FriendlyAttachmentsOccluded, "color", "", 28, 0, 152, 44 )
GUI.FriendlyAttachmentsVisible = gui.Combobox(GUI.FriendlyAttachmentsGroup, "friendly.attachments.visible", "Visible", "cock", "dick"); GUI.FriendlyAttachmentsVisible:SetWidth(280); GUI.FriendlyAttachmentsVisible:SetDescription("Visible material."); GUI.FriendlyAttachmentsVisible:SetPosY(0); GUI.FriendlyAttachmentsVisible:SetPosX(300)
GUI.FriendlyAttachmentsVisibleColor = gui.ColorPicker(GUI.FriendlyAttachmentsVisible, "color", "", 28, 0, 152, 44 )

GUI.LocalModelGroup = gui.Groupbox(GUI.Tab, "Model", 17, 87, 610, 0); GUI.LocalModelGroup:SetInvisible(true)
GUI.LocalModelOccluded = gui.Combobox(GUI.LocalModelGroup, "local.model.occluded", "Occluded", "cock", "dick"); GUI.LocalModelOccluded:SetWidth(280); GUI.LocalModelOccluded:SetDescription("Material occluded by walls.")
GUI.LocalModelOccludedColor = gui.ColorPicker(GUI.LocalModelOccluded, "color", "", 28, 0, 152, 44 )
GUI.LocalModelVisible = gui.Combobox(GUI.LocalModelGroup, "local.model.visible", "Visible", "cock", "dick"); GUI.LocalModelVisible:SetWidth(280); GUI.LocalModelVisible:SetDescription("Visible material."); GUI.LocalModelVisible:SetPosY(0); GUI.LocalModelVisible:SetPosX(300)
GUI.LocalModelVisibleColor = gui.ColorPicker(GUI.LocalModelVisible, "color", "", 28, 0, 152, 44 )

GUI.LocalAttachmentsGroup = gui.Groupbox(GUI.Tab, "Attachments", 17, 220, 610, 0); GUI.LocalAttachmentsGroup:SetInvisible(true)
GUI.LocalAttachmentsOccluded = gui.Combobox(GUI.LocalAttachmentsGroup, "local.attachments.occluded", "Occluded", "cock", "dick"); GUI.LocalAttachmentsOccluded:SetWidth(280); GUI.LocalAttachmentsOccluded:SetDescription("Material occluded by walls.")
GUI.LocalAttachmentsOccludedColor = gui.ColorPicker(GUI.LocalAttachmentsOccluded, "color", "", 28, 0, 152, 44 )
GUI.LocalAttachmentsVisible = gui.Combobox(GUI.LocalAttachmentsGroup, "local.attachments.visible", "Visible", "cock", "dick"); GUI.LocalAttachmentsVisible:SetWidth(280); GUI.LocalAttachmentsVisible:SetDescription("Visible material."); GUI.LocalAttachmentsVisible:SetPosY(0); GUI.LocalAttachmentsVisible:SetPosX(300)
GUI.LocalAttachmentsVisibleColor = gui.ColorPicker(GUI.LocalAttachmentsVisible, "color", "", 28, 0, 152, 44 )

GUI.LocalArmsGroup = gui.Groupbox(GUI.Tab, "Viewmodel Arms", 17, 353, 610, 0); GUI.LocalArmsGroup:SetInvisible(true)
GUI.LocalArmsOccluded = gui.Combobox(GUI.LocalArmsGroup, "local.arms.occluded", "Occluded", "cock", "dick"); GUI.LocalArmsOccluded:SetWidth(280); GUI.LocalArmsOccluded:SetDescription("Material occluded by walls.")
GUI.LocalArmsOccludedColor = gui.ColorPicker(GUI.LocalArmsOccluded, "color", "", 28, 0, 152, 44 )
GUI.LocalArmsVisible = gui.Combobox(GUI.LocalArmsGroup, "local.arms.visible", "Visible", "cock", "dick"); GUI.LocalArmsVisible:SetWidth(280); GUI.LocalArmsVisible:SetDescription("Visible material."); GUI.LocalArmsVisible:SetPosY(0); GUI.LocalArmsVisible:SetPosX(300)
GUI.LocalArmsVisibleColor = gui.ColorPicker(GUI.LocalArmsVisible, "color", "", 28, 0, 152, 44 )

GUI.LocalWeaponGroup = gui.Groupbox(GUI.Tab, "Viewmodel Weapon", 17, 486, 610, 0); GUI.LocalWeaponGroup:SetInvisible(true)
GUI.LocalWeaponOccluded = gui.Combobox(GUI.LocalWeaponGroup, "local.weapon.occluded", "Occluded", "cock", "dick"); GUI.LocalWeaponOccluded:SetWidth(280); GUI.LocalWeaponOccluded:SetDescription("Material occluded by walls.")
GUI.LocalWeaponOccludedColor = gui.ColorPicker(GUI.LocalWeaponOccluded, "color", "", 28, 0, 152, 44 )
GUI.LocalWeaponVisible = gui.Combobox(GUI.LocalWeaponGroup, "local.weapon.visible", "Visible", "cock", "dick"); GUI.LocalWeaponVisible:SetWidth(280); GUI.LocalWeaponVisible:SetDescription("Visible material."); GUI.LocalWeaponVisible:SetPosY(0); GUI.LocalWeaponVisible:SetPosX(300)
GUI.LocalWeaponVisibleColor = gui.ColorPicker(GUI.LocalWeaponVisible, "color", "", 28, 0, 152, 44 )

ffi.cdef[[
    void* GetProcAddress(void*, const char*);
    void* GetModuleHandleA(const char*);

    typedef void* (*GetInterfaceFn)();
    typedef struct {
        GetInterfaceFn Interface;
        char* InterfaceName;
        void* NextInterface;
    } CInterface;

    bool VirtualProtect(void*, size_t, int, int*);
]]

mem.CreateInterface = function(module, interfaceName)
    local pCreateInterface = ffi.cast("int", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(module), "CreateInterface"))
    local interface = ffi.cast("CInterface***", pCreateInterface + ffi.cast("int*", pCreateInterface + 5)[0] + 15)[0][0]

    while interface ~= ffi.NULL do
        if string.sub(ffi.string(interface.InterfaceName), 0, -4) == interfaceName then
            return interface.Interface()
        end

        interface = ffi.cast("CInterface*", interface.NextInterface)
    end

    return 0
end

mem.VMTBind = function(typedef, instance, index)
    local func = ffi.cast(ffi.typeof(typedef), ffi.cast("void***", instance)[0][index])
    return function(...)
        return func(instance, ...)
    end
end

local Hook = {}

function Hook:New(base)
    assert(base)
    return setmetatable({base = ffi.cast("void***", base), orig = {}}, {__index = self})
end

function Hook:HookMethod(index, func)
    self.orig[index] = self:_ReplaceMethodPtr(index, func)
end

function Hook:_ReplaceMethodPtr(index, func)
    assert(self.base)
    assert(index > 0)
    assert(func)

    local prevFunc = self.base[0][index]

    local oldProtection = ffi.new("int[1]", 0)
    ffi.C.VirtualProtect(self.base[0] + index, 4, 0x40, oldProtection)
    self.base[0][index] = ffi.cast("void*", func)
    ffi.C.VirtualProtect(self.base[0] + index, 4, oldProtection[0], oldProtection)

    return prevFunc
end

local FileSystemManager = {
    _findFirst = nil,
    _findNext  = nil,
    _findClose = nil,
    allocAddr  = nil,
    handle     = nil,
}

function FileSystemManager:Initialize()
    self.fileSystem = ffi.cast("void***", mem.CreateInterface("filesystem_stdio.dll", "VFileSystem"))
    assert(self.fileSystem)

    self._findFirst = mem.VMTBind("const char* (__thiscall*)(void*, const char*, int*)", self.fileSystem, 32)
    self._findNext  = mem.VMTBind("const char* (__thiscall*)(void*, int)"              , self.fileSystem, 33)
    self._findClose = mem.VMTBind("void (__thiscall*)(void*, int)"                     , self.fileSystem, 35)
end

function FileSystemManager:FindFirst(path)
    assert(self._findFirst)
    assert(handle == nil)

    self.allocAddr = mem.Alloc(4)
    local file = self._findFirst(path, ffi.cast("int*", self.allocAddr))
    self.handle = ffi.cast("int*", self.allocAddr)[0]
    
    if file == ffi.NULL then return nil end
    return ffi.string(file)
end

function FileSystemManager:FindNext()
    assert(self._findNext)
    assert(self.handle)

    local file = self._findNext(self.handle)
    if file == ffi.NULL then return nil end
    return ffi.string(file)
end

function FileSystemManager:FindClose()
    assert(self._findClose)
    assert(self.handle)
    assert(self.allocAddr)

    self._findClose(self.handle)
    mem.Free(self.allocAddr)
    self.handle = nil
    self.allocAddr = nil
end

function FileSystemManager:GetFilesInDirectory(path)
    local files = {}

    local file = self:FindFirst(path .. "/*")
    while file do
        if string.sub(file, 1, 1) ~= "." then
            files[#files + 1] = file
        end
        file = self:FindNext()
    end

    return files
end

function FileSystemManager:AllowLooseFileLoad()
    local fileSystemHook = Hook:New(self.fileSystem)
    fileSystemHook:HookMethod(128, ffi.cast("bool(__fastcall*)(void*, void*)", function(ecx, edx)
        return true
    end ))
end


local GUIManager = {
    prevSelection = 0,
    selectionGroups = {
        {
            GUI.EnemyModelGroup,
            GUI.EnemyAttachmentsGroup
        },
        {
            GUI.FriendlyModelGroup,
            GUI.FriendlyAttachmentsGroup
        },
        {
            GUI.LocalModelGroup,
            GUI.LocalAttachmentsGroup,
            GUI.LocalArmsGroup,
            GUI.LocalWeaponGroup,
        }
    },
    materialCombos = {
        GUI.EnemyModelOccluded,
        GUI.EnemyModelVisible,
        GUI.EnemyAttachmentsOccluded,
        GUI.EnemyAttachmentsVisible,
        GUI.FriendlyModelOccluded,
        GUI.FriendlyModelVisible,
        GUI.FriendlyAttachmentsOccluded,
        GUI.FriendlyAttachmentsVisible,
        GUI.LocalModelOccluded,
        GUI.LocalModelVisible,
        GUI.LocalAttachmentsOccluded,
        GUI.LocalAttachmentsVisible,
        GUI.LocalArmsOccluded,
        GUI.LocalArmsVisible,
        GUI.LocalWeaponOccluded,
        GUI.LocalWeaponVisible
    },

    prevGuiState = {},
    guiStateFilled = false,
    materialNames = {}
}

local MaterialManager = {}

function GUIManager:CheckGUIUpdates()
    local updated = false

    for k, element in pairs(GUI) do
        local val = {element:GetValue()}
        if #val == 1 then val = val[1] else val = val[1] + val[2] + val[3] + val[4] end

        if self.guiStateFilled then
            if self.prevGuiState[k] ~= val and not updated then
                MaterialManager:UpdateMaterials()
                updated = true
            end
        end
        self.prevGuiState[k] = val
    end

    self.guiStateFilled = true
end

function GUIManager:HandleSelection()
    local selectionValue = GUI.SelectionCombo:GetValue()

    if selectionValue ~= self.prevSelection then
        self:UpdateMaterialList()

        for _, group in pairs(self.selectionGroups[self.prevSelection + 1]) do
            group:SetInvisible(true)
        end

        for _, group in pairs(self.selectionGroups[selectionValue + 1]) do
            group:SetInvisible(false)
        end
    end

    self.prevSelection = selectionValue
end

function GUIManager:UpdateMaterialList()
    local files = FileSystemManager:GetFilesInDirectory("materials/skybox_chams")
    local materials = {}

    for _, file in pairs(files) do
        if string.sub(file, -4) == ".vtf" then
            materials[#materials + 1] = string.sub(file, 1, -5)
        end
    end

    table.insert(materials, 1, "Off")

    for _, combo in pairs(self.materialCombos) do
        combo:SetOptions(unpack(materials))
    end

    self.materialNames = materials
end

function GUIManager:OnDraw()
    if globals.FrameCount() % 16 == 0 then
        self:HandleSelection()
        self:CheckGUIUpdates()
    end
end

MaterialManager = {
    materials = {
        enemy = {
            model = {
                visible = {nil, nil},
                occluded = {nil, nil}
            },
            attachments = {
                visible = {nil, nil},
                occluded = {nil, nil}
            }
        },
        friendly = {
            model = {
                visible = {nil, nil},
                occluded = {nil, nil}
            },
            attachments = {
                visible = {nil, nil},
                occluded = {nil, nil}
            }
        },
        ["local"] = {
            model = {
                visible = {nil, nil},
                occluded = {nil, nil}
            },
            attachments = {
                visible = {nil, nil},
                occluded = {nil, nil}
            },
            arms = {
                visible = {nil, nil},
                occluded = {nil, nil}
            },
            weapon = {
                visible = {nil, nil},
                occluded = {nil, nil}
            }
        }
    }
}

function MaterialManager:CreateMaterials(group, subgroup, visibility)
    if gui.GetValue("esp.skyboxchams." .. group .. "." .. subgroup .. "." .. visibility) == 0 then
        self.materials[group][subgroup][visibility] = {main = nil, overlay = nil}
        return
    end

    local materialName = GUIManager.materialNames[gui.GetValue("esp.skyboxchams." .. group .. "." .. subgroup .. "." .. visibility) + 1]
    local materialColor = {gui.GetValue("esp.skyboxchams." .. group .. "." .. subgroup .. "." .. visibility .. ".color")}

    local mainMaterial = materials.Create("skychams_" .. group .. "_" .. subgroup .. "_" .. visibility, [[
        UnlitTwoTexture
        {
            "$moondome" "1"
            "$basetexture" "vgui/white"
            "$cubeparallax" "0.00005"
            "$texture2" "skybox_chams/]] .. materialName .. [["
            "$nofog" "1"
            "$ignorez" "]] .. (visibility == "visible" and "0" or "1") .. [["
        }
    ]])

    local overlayMaterial = materials.Create("skychams_" .. group .. "_" .. subgroup .. "_" .. visibility .. "_overlay", [[
        VertexLitGeneric
        {
            "$additive" "1"
            "$envmap" "models/effects/cube_white"
            "$envmaptint" "[]] .. materialColor[1] / 255 .. [[ ]] .. materialColor[2] / 255 .. [[ ]] .. materialColor[3] / 255 .. [[]"
            "$envmapfresnel" "1"
            "$envmapfresnelminmaxexp" "[0 1 2]"
            "$alpha" "]] .. materialColor[4] / 255 .. [["
        }
    ]])

    self.materials[group][subgroup][visibility] = {main = mainMaterial, overlay = overlayMaterial}
end

function MaterialManager:UpdateMaterials()
    local groups = {"enemy", "friendly", "local"}
    local subgroups = {"model", "attachments"}
    local visibility = {"visible", "occluded"}

    for _, group in pairs(groups) do
        for __, subgroup in pairs(subgroups) do
            for ___, visibility in pairs(visibility) do
                self:CreateMaterials(group, subgroup, visibility)
            end
        end
    end

    self:CreateMaterials("local", "arms", "visible")
    self:CreateMaterials("local", "arms", "occluded")
    self:CreateMaterials("local", "weapon", "visible")
    self:CreateMaterials("local", "weapon", "occluded")
end

function MaterialManager:GetMaterial(group, subgroup, visibility)
    return self.materials[group][subgroup][visibility]
end

function MaterialManager:DrawModel(context, group, subgroup)
    local visible = self:GetMaterial(group, subgroup, "visible")
    local occluded = self:GetMaterial(group, subgroup, "occluded")

    if occluded.main then
        context:ForcedMaterialOverride(occluded.main)
        context:DrawExtraPass()
    end

    if visible.main then
        context:ForcedMaterialOverride(visible.main)
        if visible.overlay then
            context:DrawExtraPass()
            context:ForcedMaterialOverride(visible.overlay)
        end
    end
end

function MaterialManager:GetGroupFromEntity(entity)
    if entity:GetIndex() == client.GetLocalPlayerIndex() then
        return "local"
    elseif entity:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() then
        return "friendly"
    else
        return "enemy"
    end
end

function MaterialManager:ShouldScopeFix()
    local weaponClass = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetClass()
    return (weaponClass == "CWeaponAug" or weaponClass == "CWeaponSG556") and entities.GetLocalPlayer():GetProp("m_bIsScoped") == 1
end

function MaterialManager:OnDrawModel(context)
    local entity = context:GetEntity()
    if not entity then return end

    local class = entity:GetClass()

    local isPlayer = class == "CCSPlayer"
    local isAttachment = (class == "CBaseWeaponWorldModel" or class == "CBreakableProp") and entity:GetProp("m_nModelIndex") < 67000000
    local isArms = class == "CBaseAnimating"
    local isWeapon = class == "CPredictedViewModel"

    local group, subgroup

    if isPlayer then
        subgroup = "model"
        group = self:GetGroupFromEntity(entity)
    end

    if isAttachment then
        subgroup = "attachments"

        local owner
        if class == "CBaseWeaponWorldModel" then
            owner = entity:GetPropEntity("m_hCombatWeaponParent"):GetPropEntity("m_hOwnerEntity")
        else
            owner = entity:GetPropEntity("moveparent")
        end

        group = self:GetGroupFromEntity(owner)
    end

    if isArms then
        if self:ShouldScopeFix() then return end

        group = "local"
        subgroup = "arms"
    end

    if isWeapon then
        if self:ShouldScopeFix() then return end

        group = "local"
        subgroup = "weapon"
    end

    if group and subgroup then
        self:DrawModel(context, group, subgroup)
    end
end

local function main()
    FileSystemManager:Initialize()
    FileSystemManager:AllowLooseFileLoad()
    
    GUIManager:UpdateMaterialList()

    callbacks.Register("Draw", function() 
        GUIManager:OnDraw()
    end)

    callbacks.Register("DrawModel", function(context)
        MaterialManager:OnDrawModel(context)
    end)
end

main()





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")