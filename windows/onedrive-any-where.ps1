# 
function Select-FolderDialog{
    param([string] $Directory,[string] $Description)

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.RootFolder = $Directory
    $objForm.Description = $Description
    $objForm.ShowNewFolderButton = $false
    $Show = $objForm.ShowDialog()

    If ($Show -eq "OK") {
        Return $objForm.SelectedPath
    } Else{
        #��Ҫ���������Ϣ�Ļ�����ȡ����һ�е�ע��
        #Write-Error "error information here"
    }
}

$folder_path = Select-FolderDialog -Directory "Desktop" -Description "��ѡ��Ҫͬ����OneDrive���ļ���"
Write-Host "��Ҫ��" $folder_path "�ļ���ͬ���� Onedrive"

pause