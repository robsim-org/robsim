# RobSIM

RobSIM is a robot simulator that allows you to test your algorithms in a simulated environment. It is focused on the MicroMouse competition, but can be used for other purposes as well.

Unfortunately, the simulator can only be run on Windows, as it uses some of the windows API to communicate with the C++ code.

## Requirements

You will need to have the .NET SDK installed on your machine to run the project. You can download it [here](https://dotnet.microsoft.com/download).

> For this project, .NET 8.0 was used, but other versions may work.

You will also need G++ to compile the C++ code. You can download it [here](https://sourceforge.net/projects/mingw/).

## Writing your own algorithm

Please check out the [robsim-algo](https://github.com/zRafaF/robsim-algo) repository to see how to write your own algorithm.

## Acknowledgements

- [Godot Jolt](https://github.com/godot-jolt/godot-jolt) this projects makes use of Godot Jolt to use Jolt as the physics engine.
