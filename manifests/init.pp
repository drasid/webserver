class webserver {
  # this module manage my web server 
  
  file { "C:\\inetpub":
    ensure => directory, 
  }
  
  file { "C:\\inetpub\\website":
    ensure => directory, 
  }

  file { 'index': 
    ensure => file, 
    path   => "C:\\inetpub\\website\\index.html",
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

iis_site { 'website':
  ensure          => 'started',
  physicalpath    => 'C:\\inetpub\\website',
  applicationpool => 'DefaultAppPool',
  require         => [
    File['index'],
    Iis_site['Default Web Site']
  ],
}

}
