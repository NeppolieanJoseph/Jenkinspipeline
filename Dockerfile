FROM microsoft/windowsservercore

RUN dism /online /enable-feature /all /featurename:IIS-ASPNET45 /NoRestart
RUN dism /online /enable-feature /all /featurename:iis-webserver /NoRestart

RUN start /w dism /online /enable-feature /featurename:Web-Server
RUN start /w dism /online /enable-feature /featurename:Web-WebServer
RUN start /w dism /online /enable-feature /featurename:Web-Common-Http
RUN start /w dism /online /enable-feature /featurename:Web-Default-Doc
RUN start /w dism /online /enable-feature /featurename:Web-Dir-Browsing
RUN start /w dism /online /enable-feature /featurename:Web-Http-Errors
RUN start /w dism /online /enable-feature /featurename:Web-Static-Conten
RUN start /w dism /online /enable-feature /featurename:Web-Http-Redirect
RUN start /w dism /online /enable-feature /featurename:NET-Framework-Features
RUN start /w dism /online /enable-feature /featurename:NET-Framework-Core
RUN start /w dism /online /enable-feature /featurename:NET-HTTP-Activation
RUN start /w dism /online /enable-feature /featurename:NET-Non-HTTP-Activ
RUN start /w dism /online /enable-feature /featurename:NET-Framework-46-Features
RUN start /w dism /online /enable-feature /featurename:NET-Framework-46-Core
RUN start /w dism /online /enable-feature /featurename:NET-Framework-46-ASPNET
RUN start /w dism /online /enable-feature /featurename:NET-WCF-tests46
RUN start /w dism /online /enable-feature /featurename:NET-WCF-HTTP-Activation46
RUN start /w dism /online /enable-feature /featurename:NET-WCF-MSMQ-Activation46
RUN start /w dism /online /enable-feature /featurename:NET-WCF-Pipe-Activation46
RUN start /w dism /online /enable-feature /featurename:NET-WCF-TCP-Activation46
RUN start /w dism /online /enable-feature /featurename:NET-WCF-TCP-PortSharing46
RUN start /w dism /online /enable-feature /featurename:Web-Asp-Net46
RUN start /w dism /online /enable-feature /featurename:Web-CGI
RUN start /w dism /online /enable-feature /featurename:Web-Security
RUN start /w DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
RUN start /w dism /online /enable-feature /featurename:Web-Default-Doc
RUN start /w dism /online /enable-feature /featurename:Web-Dir-Browsing
RUN start /w dism /online /enable-feature /featurename:Web-Http-Errors
RUN start /w dism /online /enable-feature /featurename:Web-Static-Content
RUN start /w dism /online /enable-feature /featurename:Web-Http-Logging
RUN start /w dism /online /enable-feature /featurename:Web-Request-Monitor
RUN start /w dism /online /enable-feature /featurename:Web-Stat-Compression
RUN start /w dism /online /enable-feature /featurename:Web-Filtering
RUN start /w dism /online /enable-feature /featurename:Web-Windows-Auth
RUN start /w dism /online /enable-feature /featurename:Web-Net-Ext46
RUN start /w dism /online /enable-feature /featurename:Web-Asp-Net46
RUN start /w dism /online /enable-feature /featurename:Web-ISAPI-Ext
RUN start /w dism /online /enable-feature /featurename:Web-ISAPI-Filter
RUN start /w dism /online /enable-feature /featurename:Web-Metabase

RUN start /w dism /online /enable-feature /featurename:HttpWebRequest

RUN start /w dism /Enable-Feature /online /featurename:IIS-IPSecurity /all

RUN powershell -Command mkdir C:\inetpub\wwwroot\test

ADD test/ C:/inetpub/wwwroot/test

RUN powershell -NoProfile -Command \
	remove-item C:\inetpub\wwwroot\iisstart.*
	
RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
                New-WebApplication -Name test -Site 'Default Web Site' -PhysicalPath C:\inetpub\wwwroot\test -ApplicationPool DefaultAppPool

RUN powershell -NoProfile -Command \
	icacls C:\inetpub\wwwroot\test /grant Everyone:F /t /q
	
ADD https://download.microsoft.com/download/C/9/E/C9E8180D-4E51-40A6-A9BF-776990D8BCA9/rewrite_amd64.msi /install/rewrite_amd64.msi

RUN msiexec.exe /i c:\install\rewrite_amd64.msi /passive

RUN powershell -Command cd C:\inetpub\wwwroot

EXPOSE 80

RUN powershell -Command C:\Windows\System32\inetsrv\appcmd.exe set config /section:directoryBrowse /enabled:true


# To run it with a static IP with port mapping run the following command in your powershell
# docker run -it --name staticwebapp --network=nat --ip 172.31.112.3 -p 888:80 webapp powershell