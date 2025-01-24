# NT5-10a
This is based off of a Post on the WinXP Src Code

Everything, and all things, belong to Microsoft. 
I do NOT own anything here, everything here, rightfully belongs to Microsoft. 
Except this README.


# Build Instructions for Windows Source Code

These instructions will guide you through setting up the environment and building the Windows source code. Ensure you follow these steps carefully.

## Prerequisites
- **Hardware Requirements**: 
  - A minimum of 4 GB RAM and 4 processor cores.
  - At least 60–80 GB of free disk space (virtual disk or dedicated partition recommended).
- **Software Requirements**: 
  - A compatible Windows version: Windows 10, Windows XP, or Windows Server 2003 (recommended for compatibility).
  - NTVDM or an equivalent alternative if using x86 tools on x64 Windows.

---

## Setup Instructions

1. **Allocate Storage for Source Code**  
   - Create a 60–80 GB virtual disk or dedicate a partition with equivalent free space.  
   - Mount or assign this disk/partition to `D:\`.

2. **CD-ROM Drive Assignment**  
   - Ensure the CD-ROM drive is assigned to `G:\` for any additional tools or resources.

3. **Disable User Account Control (UAC)**  
   - Turn off UAC to avoid confirmation prompts during the build process.

4. **Disable Real-Time Protection**  
   - Disable any active antivirus or Windows Defender's real-time protection to prevent interference with the build tools.

5. **Download and Extract Source Code**  
   - Download the source code package and extract it to `D:\srv03rtm`.

6. **Adjust Folder Properties**  
   - Right-click on the `srv03rtm` folder, go to Properties, and uncheck the "Read-only" attribute. Apply changes to all subfolders and files.

---

## Build Process

1. **Open Command Prompt**  
   - Run **Command Prompt** as Administrator.  
   - Navigate to `D:\srv03rtm`.

2. **Set Up Build Environment**  
   - If on x64 Windows:  
     ```cmd
     tools\razzle64 free offline
     ```
   - If on x86 Windows:  
     ```cmd
     tools\razzle free offline
     ```

3. **Prepare the Build**  
   - Execute the following command to set up the build environment:  
     ```cmd
     tools\prebuild
     ```

4. **Compile the Source Code**  
   - Use the following command to compile using all available cores:  
     ```cmd
     build /cZP -M 4
     ```

5. **Post-Build Steps**  
   - Run the post-build script to finalize the compiled components:  
     ```cmd
     tools\postbuild -full
     ```

6. **Generate ISO File**  
   - Create the ISO for the desired Windows version:  
     ```cmd
     tools\oscdimg pro|per|srv
     ```  
     Replace `pro`, `per`, or `srv` for XP Professional, Home Edition, or Server 2003 Standard Edition.

---

## Notes and Recommendations

1. **Ensure File Integrity**:  
   - Verify that all necessary files are present and intact. Missing or corrupt files can cause build errors.

2. **System Compatibility**:  
   - For best results, use Windows XP or Server 2003 as the build host to avoid compatibility issues.  

3. **Razzle Options**:  
   - `razzle` offers multiple build configurations:  
     - `free`: Compile release binaries.  
     - `chk`: Compile debug binaries.  
     - `offline`: Skip environment syncing.  

     Example usage:  
     ```cmd
     razzle free offline
     razzle chk win32 offline
     ```
