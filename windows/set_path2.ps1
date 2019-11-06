#requires -version 4.0
#requires #-runasadministrator

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID);

# Get the security principal for the administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

# Check to see if we are currently running as an administrator
if ($myWindowsPrincipal.IsInRole($adminRole))
{
    # We are running as an administrator, so change the title and background colour to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)";
    $Host.UI.RawUI.BackgroundColor =0;
    Clear-Host;
}
else {
    # We are not running as an administrator, so relaunch as administrator

    # Create a new process object that starts PowerShell
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

    # Specify the current script path and name as a parameter with added scope and support for scripts with spaces in it's path
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"

    # Indicate that the process should be elevated
    $newProcess.Verb = "runas";

    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess);

    # Exit from the current, unelevated, process
    Exit;
}


#������������
Function Create-EnvVar
{param([Parameter(Mandatory=$true)] $Name, $Value)
   
    [System.Environment]::SetEnvironmentVariable($Name, $Value, [System.EnvironmentVariableTarget]::Machine)

}

#�����еĻ������������ֵ
Function Append-PATH
{param ($Value)

    $OldValue = [environment]::GetEnvironmentVariable("Path",[System.EnvironmentVariableTarget]::Machine)
    # ���Ҫ��ӵ�ֵ�к��� %����Ϊ�õ���������������
    if($Value.Contains("%")){
        $Base = $Value.Split("%")[1]
        # ���û�������ϵͳ����ͬʱ����
        $BaseReal = [environment]::GetEnvironmentVariable($Base)
        $RealValue = $Value.Split("%")[0]+$BaseReal+$Value.Split("%")[2]
        if($OldValue.Contains($RealValue)){
            Write-Host "PATH contains" $Value
            return;
        }
    }  
   
    
    if($OldValue.Contains($Value)){
        Write-Host "PATH contains" $Value
    } else {
        if($OldValue.Trim().EndsWith(";")){
            $NewValue=$OldValue+$Value
        } else{
            $NewValue=$OldValue+";"+$OldValue
        }
        [Environment]::SetEnvironmentVariable("Path", $NewValue, [System.EnvironmentVariableTarget]::Machine )
    }
}


Create-EnvVar -Name "JAVA_HOME" -Value "D:\Program Files (Dev)\Java\jdk1.8.0_201"
Append-PATH -Value "%JAVA_HOME%\bin"
Append-PATH -Value "D:\Program Files (Dev)\Git\bin"

# read-host
pause