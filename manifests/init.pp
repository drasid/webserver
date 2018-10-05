class webserver {
  # this module manage my web server 
  
  file { "C:\\inetpub":
    ensure => directory, 
  }
  
  file { "C:\\inetpub\\website":
    ensure => directory, 
  }

  #$folders = ["C:\\Inetpub",]

  file {"C:\\inetpub\\website\\index.html":
  ensure => file, 
  source => 'puppet:///modules/webserver/index.html',
  }

$iis_features = ['Web-WebServer','Web-Scripting-Tools']

iis_feature { $iis_features:
  ensure => 'present',
}

# Delete the default website to prevent a port binding conflict.
iis_site {'Default Web Site':
  ensure  => absent,
  require => Iis_feature['Web-WebServer'],
}

iis_site { 'minimal':
  ensure          => 'started',
  physicalpath    => 'c:\\inetpub\\minimal',
  applicationpool => 'DefaultAppPool',
  require         => [
    File['minimal'],
    Iis_site['Default Web Site']
  ],
}

file { 'minimal':
  ensure => 'directory',
  path   => 'c:\\inetpub\\minimal',
}

}
