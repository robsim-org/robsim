using Godot;
using System;
using System.Runtime.InteropServices;
using System.ComponentModel;

public partial class RobotScript : Node3D {
	// Import kernel32.dll to use LoadLibrary and FreeLibrary functions
	[DllImport("kernel32.dll", SetLastError = true)] private static extern IntPtr LoadLibrary(string lpFileName);

	[DllImport("kernel32.dll", SetLastError = true)] private static extern bool FreeLibrary(IntPtr hModule);

	[DllImport("kernel32.dll", SetLastError = true)] private static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

	/* ################################################ */
	// [UnmanagedFunctionPointer(CallingConvention.Cdecl)] public delegate void PrintCallbackType(string value);

	/* ################################################ */

	// Application -> DLL
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate void RsimLoopDelegate(double deltaTime);
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate int ReturnNumberTimesTwoDelegate(int value);
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] private delegate void RegisterPrintCallbackDelegate(IntPtr cb);


	// DLL -> Application
	[UnmanagedFunctionPointer(CallingConvention.Cdecl)] public delegate void PrintCallbackDelegate(string value);


	/* ################################################ */

	private IntPtr pDll;


	private RsimLoopDelegate rsimLoop;
	private ReturnNumberTimesTwoDelegate returnNumberTimesTwo;
	private RegisterPrintCallbackDelegate registerPrintCallback;
	private PrintCallbackDelegate printCallback;


	// Called when the node enters the scene tree for the first time.
	public override void _Ready() {
		LoadDLL();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta) {
		rsimLoop(delta);
	}

	public void PrintCallback(string value) {
		GD.Print(value);
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
		IntPtr pRegisterPrintCallback = GetProcAddress(pDll, "registerPrintCallback");

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
		if (pRegisterPrintCallback == IntPtr.Zero) {
			GD.Print("Could not get the registerPrintCallback pointer.");
			FreeLibrary(pDll);
			return;
		}

		// Convert the function pointers to delegates
		rsimLoop = Marshal.GetDelegateForFunctionPointer<RsimLoopDelegate>(pRsimLoop);
		returnNumberTimesTwo = Marshal.GetDelegateForFunctionPointer<ReturnNumberTimesTwoDelegate>(pReturnNumberTimesTwo);
		registerPrintCallback = Marshal.GetDelegateForFunctionPointer<RegisterPrintCallbackDelegate>(pRegisterPrintCallback);


		// Register the callback function

		printCallback = new PrintCallbackDelegate(PrintCallback);
		IntPtr pPrintCallback = Marshal.GetFunctionPointerForDelegate(printCallback);
		registerPrintCallback(pPrintCallback);


		GD.Print("DLL Loaded Successfully.");
	}

	public void UnloadDLL() {
		// rsimLoop = null;
		// returnNumberTimesTwo = null;
		// registerPrintCallback = null;
		// printCallback = null;


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
