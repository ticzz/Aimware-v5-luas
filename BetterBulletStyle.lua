if not beam_info_t then
    ffi.cdef [[
    typedef struct  {
        float x;
        float y;
        float z;    
    }vec3_t;
    struct beam_info_t {
        int         m_type;
        void* m_start_ent;
        int         m_start_attachment;
        void* m_end_ent;
        int         m_end_attachment;
        vec3_t      m_start;
        vec3_t      m_end;
        int         m_model_index;
        const char  *m_model_name;
        int         m_halo_index;
        const char  *m_halo_name;
        float       m_halo_scale;
        float       m_life;
        float       m_width;
        float       m_end_width;
        float       m_fade_length;
        float       m_amplitude;
        float       m_brightness;
        float       m_speed;
        int         m_start_frame;
        float       m_frame_rate;
        float       m_red;
        float       m_green;
        float       m_blue;
        bool        m_renderable;
        int         m_num_segments;
        int         m_flags;
        vec3_t      m_center;
        float       m_start_radius;
        float       m_end_radius;
    };
    typedef void (__thiscall* draw_beams_t)(void*, void*);
    typedef void*(__thiscall* create_beam_points_t)(void*, struct beam_info_t&);
]]

    beam_info_t = true
end
local render_beams_signature = "B9 ?? ?? ?? ?? A1 ?? ?? ?? ?? FF 10 A1 ?? ?? ?? ?? B9"
local match = mem.FindPattern("client.dll", render_beams_signature) or error("render_beams_signature not found")
local render_beams = ffi.cast("void**", ffi.cast("char*", match) + 1)[0] or error("render_beams is nil")
local render_beams_class = ffi.cast("void***", render_beams)
local render_beams_vtbl = render_beams_class[0]

local draw_beams = ffi.cast("draw_beams_t", render_beams_vtbl[6]) or error("couldn't cast draw_beams_t", 2)
local create_beam_points = ffi.cast("create_beam_points_t", render_beams_vtbl[12]) or error("couldn't cast create_beam_points_t", 2)

local sprites = {
    "sprites/purplelaser1.vmt",
    "sprites/physbeam.vmt",
    "sprites/blueglow1.vmt",
    "sprites/bubble.vmt",
    "sprites/glow01.vmt",
    "sprites/purpleglow1.vmt",
    "sprites/radio.vmt",
    "sprites/white.vmt",
    "sprites/defuser.vmt",
    "sprites/richo1.vmt",
    "sprites/numbers.vmt",
    "sprites/hostage_following.vmt",
    "sprites/halo.vmt",
    "sprites/crosshairs.vmt",
}

local gui_ref = gui.Reference("Visuals", "World", "Extra")
--local gui_tab = gui.Tab(gui_ref, "bullet_tracers", "Bullet Tracers")
local gui_group = gui.Groupbox(gui_ref, "Bullet Tracer Options") --, 15, 15, 300, 400);

local tracer_color = gui.ColorPicker(gui_group, "bullet_tracer.color", "Bullet tracer color", 255, 255, 255, 255);
local tracer_type = gui.Combobox(gui_group, "bullet_tracer.type", "Bullet tracer type", "Default", "Physbeam", "blueglow1", "bubble", "glow01", "purpleglow1", "radio", "white", "defuser", "richo1", "numbers", "hostage_following", "halo", "crosshairs")
local tracer_width = gui.Slider(gui_group, "bullet_tracer.width", "Bullet tracer width", 10, 1, 20);
local tracer_duration = gui.Slider(gui_group, "bullet_tracer.duration", "Bullet tracer duration", 2, 1, 5);
local tracer_speed = gui.Slider(gui_group, "bullet_tracer.speed", "Bullet tracer speed", 2, 1, 20);
local tracer_amplitude = gui.Slider(gui_group, "bullet_tracer.amplitude", "Bullet tracer amplitude", 2.3, 2.0, 20, 0.1);
local tracer_segments = gui.Slider(gui_group, "bullet_tracer.segments", "Bullet tracer segments", 2, 2, 100);

local function create_beams(beamtype, startpos, endpos, red, green, blue, alpha, width, duration, amplitude, speed, segments)
    local beam_info = ffi.new("struct beam_info_t")
    beam_info.m_type = 0x00
    beam_info.m_model_index = -1
    beam_info.m_halo_scale = 0

    beam_info.m_life = duration
    beam_info.m_fade_length = 1

    beam_info.m_width = width * 0.1
    beam_info.m_end_width = width * 0.1

    beam_info.m_model_name = beamtype

    beam_info.m_amplitude = amplitude
    beam_info.m_speed = speed * 0.1

    beam_info.m_start_frame = 0
    beam_info.m_frame_rate = 0

    beam_info.m_red = red
    beam_info.m_green = green
    beam_info.m_blue = blue
    beam_info.m_brightness = alpha

    beam_info.m_num_segments = segments
    beam_info.m_renderable = true

    beam_info.m_flags = bit.bor(0x00000100 + 0x00000200 + 0x00008000)

    beam_info.m_start = startpos
    beam_info.m_end = endpos

    local beam = create_beam_points(render_beams_class, beam_info)
    if beam ~= nil then
        draw_beams(render_beams, beam)
    end
end

client.AllowListener("bullet_impact")

local oldTick = 0
callbacks.Register("FireGameEvent", function(e)
        if oldTick < globals.TickCount() and e:GetName() and e:GetName() == "bullet_impact" then
            oldTick = globals.TickCount()
            local lp = entities.GetLocalPlayer()
            local idx = lp:GetIndex()
            local pos = lp:GetAbsOrigin() + Vector3(0, 0, lp:GetPropFloat("localdata", "m_vecViewOffset[2]"))
            local r, g, b, a = tracer_color:GetValue()

            if (client.GetPlayerIndexByUserID(e:GetInt("userid")) == idx and client.GetPlayerIndexByUserID(e:GetInt("attacker")) ~= idx) then
                create_beams(sprites[tracer_type:GetValue() + 1], {pos.x, pos.y, pos.z - 1}, {e:GetFloat("x"), e:GetFloat("y"), e:GetFloat("z")}, r, g, b, a, tracer_width:GetValue(), tracer_duration:GetValue(), tracer_amplitude:GetValue(), tracer_speed:GetValue(), tracer_segments:GetValue())
            end
        end
    end
)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

