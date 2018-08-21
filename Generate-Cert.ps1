# This simply generates a self-signed certificate which will import into Secret Server
# Replace the variables below (pass, dnsname, filename)
# Requires .NET 4.5 or above
# Please Run As Administrator

###--Variables to Replace--###
# Certificate Password for PFX
$pass = 'PASSWORDHERE'
# DNS name in certificate
$dnsname = 'DNSNAMEHERE'
# Filename of PFX
$filename = 'PFXNAMEHERE.PFX'

###--Commands--###
# NOTE: The provider must be set in order to be compatible with .NET 4.5 newer versions of .NET can import certs from more providers
$securepass = ConvertTo-SecureString -String $pass -Force -AsPlainText
$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $dnsname -HashAlgorithm SHA256 -KeyLength 4096 -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider"
$path = 'cert:\localmachine\my\' + $cert.thumbprint
Export-PfxCertificate -cert $path -FilePath $filename -Password $securepass
# remove from cert store
Remove-Item $path
