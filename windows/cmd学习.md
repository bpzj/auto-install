复制当前目录的路径到粘贴板
    cmd.exe /c set/p="%cd%"<nul | clip
    cmd.exe /c cd | clip
    
cmd后面的/c /k 参数：
    /C 是 /Close的简写，命令运行之后关闭窗口
    /K 是 /Keep的简写，命令运行之后保留窗口。
