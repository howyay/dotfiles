{ pkgs, ... }:
with pkgs;
#let  
#in 
mkShell {
  buildInputs = [
    vulkan-tools
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    spirv-tools
    #glfw
    glfw-wayland
    glm
    shaderc
    xorg.libXxf86vm
    xorg.libXi
    xorg.libX11
    xorg.libXrandr
  ];
}
