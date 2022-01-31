# pair with task scheduler to automate sending of emails #



#  Mail Report Setup Variables #

[string]$MailReportEmailFromAddress = "from address"
[string]$MailReportEmailToAddress = "to address"
[string]$MailReportEmailSubject = "subject"
[string]$MailReportSMTPServer = "smtp"
[int32]$MailReportSMTPPort = "smtp port"
[boolean]$MailReportSMTPServerEnableSSL = $False
[string]$MailReportSMTPServerUsername = "smtp sending account"
[string]$MailReportSMTPServerPassword = "your password"

#       Mail the Report        #

function MailReport {
    param (
        [ValidateSet("TXT","HTML")] 
        [String] $MessageContentType = "HTML"
    )
    $message = New-Object System.Net.Mail.MailMessage
    $mailer = New-Object System.Net.Mail.SmtpClient ($MailReportSMTPServer, $MailReportSMTPPort)
    $mailer.EnableSSL = $MailReportSMTPServerEnableSSL
    if ($MailReportSMTPServerUsername -ne "") {
        $mailer.Credentials = New-Object System.Net.NetworkCredential($MailReportSMTPServerUsername, $MailReportSMTPServerPassword)
    }
    $message.From = $MailReportEmailFromAddress
    $message.To.Add($MailReportEmailToAddress)
    $message.Subject = $MailReportEmailSubject
    $message.Body = "Just a test email body"
    $message.IsBodyHtml = $False
    $mailer.send(($message))
}
