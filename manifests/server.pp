define nagios::server($admin_username = 'nagiosadmin', $admin_email = 'root@localhost', $admin_password = 'nagiosadmin') {
  
  package {'nagios3':
    ensure  => installed,
  }->
  file {'nagios.conf':
    ensure  => file,
    path    => '/etc/nagios3/nagios.cfg',
    content => template("nagios/nagios.cfg.erb"),
  }->
  exec {"nagios_users":
    command => "htpasswd -bc /etc/nagios3/htpasswd.users ${admin_username} ${admin_password}",
    creates => "/etc/nagios3/htpasswd.users",
  }
  service {'nagios3':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }

}
