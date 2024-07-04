using Godot;
using System;
using System.Runtime.InteropServices;

public partial class Robot : RigidBody3D {
	// Application -> DLL
	[DllImport("robsim_algo.dll", CallingConvention = CallingConvention.Cdecl)] public static extern void RegisterPrintCallback(CallbackType cb);

	[DllImport("robsim_algo.dll", CallingConvention = CallingConvention.Cdecl)] static extern void rsimSetup();

	[DllImport("robsim_algo.dll", CallingConvention = CallingConvention.Cdecl)] static extern void rsimLoop(double deltaTime);



	// DLL -> Application
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] public delegate void CallbackType(string value);

	private static void RegisterCallbacks() {
		RegisterPrintCallback(PrintCallback);
	}

	public override void _Ready() {
		RegisterCallbacks();
		rsimSetup();



	}

	public override void _Process(double delta) {
		rsimLoop(delta);
		GD.Print("Robot _Process");
	}




	// Callback function implementation
	public static void PrintCallback(string value) {
		GD.Print(value);
	}

}
