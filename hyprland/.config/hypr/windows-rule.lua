hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "Picture in Picture mode",
    match = { title = "Incrustation vidéo", title = "Picture in Picture" },
    float = true,
})

hl.window_rule({
    name  = "Center Volume Control",
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
})
