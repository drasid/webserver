class webserver {
  # this module manage my web server 
  
  file { "C:\\inetpub\\website":
    ensure => directory, 
  }

  file {"C:\\inetpub\\website\\index.html"
  ensure => file, 
  source => 'puppet:///modules/webserver/index.html',
  }
}
