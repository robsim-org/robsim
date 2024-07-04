using Godot;
using System;
using System.Runtime.InteropServices;
using System.ComponentModel;

public partial class RobotScript : Node3D {
	// Import kernel32.dll to use LoadLibrary and FreeLibrary functions
	[DllImport("kernel32.dll", SetLastError = true)] private static extern IntPtr LoadLibrary(string lpFileName);

	[DllImport("kernel32.dll", SetLastError = true)] private static extern bool FreeLibrary(IntPtr hModule);

	[DllImport("kernel32.dll", SetLastError = true)] private static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate void rsimLoopDelegate(double deltaTime);
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate int returnNumberTimesTwoDelegate(int value);

	private IntPtr pDll;

	private rsimLoopDelegate rsimLoop;
	private returnNumberTimesTwoDelegate returnNumberTimesTwo;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready() {
		LoadDLL();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta) {
		rsimLoop(delta);
	}

	public void UseMe() {
		GD.Print("UseMe");
	}

	public void LoadDLL() {
		GD.Print("Loading the DLL...");

		// Load the DLL dynamically
		pDll = LoadLibrary("robsim_algo.dll");
		if (pDll == IntPtr.Zero) {
			printWindowsError();
			return;
		}

		// Get the function pointers for the exported functions
		IntPtr pRsimLoop = GetProcAddress(pDll, "rsimLoop");
		IntPtr pReturnNumberTimesTwo = GetProcAddress(pDll, "returnNumberTimesTwo");

		if (pRsimLoop == IntPtr.Zero) {
			GD.Print("Could not get the rsimLoop pointer.");
			FreeLibrary(pDll);
			return;
		}
		if (pReturnNumberTimesTwo == IntPtr.Zero) {
			GD.Print("Could not get the returnNumberTimesTwo pointer.");
			FreeLibrary(pDll);
			return;
		}

		// Convert the function pointers to delegates
		rsimLoop = Marshal.GetDelegateForFunctionPointer<rsimLoopDelegate>(pRsimLoop);
		returnNumberTimesTwo = Marshal.GetDelegateForFunctionPointer<returnNumberTimesTwoDelegate>(pReturnNumberTimesTwo);


		GD.Print("DLL Loaded Successfully.");
	}

	public void UnloadDLL() {
		rsimLoop = null;
		returnNumberTimesTwo = null;

		if (FreeLibrary(pDll)) {
			GD.Print("DLL Unloaded Successfully.");
			pDll = IntPtr.Zero;

		} else {
			printWindowsError();
		}


	}

	private void printWindowsError() {
		int errorCode = Marshal.GetLastWin32Error();
		string errorMessage = new Win32Exception(errorCode).Message;
		GD.Print($"Error code: {errorCode}, Message: {errorMessage}");
	}


}
