$my_full_name = "developer"
$group=oracle

include java::install


group { "oracle":
	ensure		=> present,
}

group { "admin":
	ensure		=> present,
}

user { "oracle":
	ensure		=> present,
	comment		=> "$my_full_name",
	gid			=> "oracle",
		groups		=> ["admin", "sudo" ,"root"],
#	membership	=> minimum,
	shell		=> "/bin/bash",
	home		=> "/u01/app/oracle",
}


exec { "oracle homedir":
	command	=> "/bin/cp -R /etc/skel /home/$username; /bin/chown -R $username:$group /home/$username",
	creates	=> "/home/$username",
	require	=> User[oracle],
}

$oracle_product_home_directories = ["/u01","/u01/app","/u01/app/oracle"]

file { $oracle_product_home_directories:
  ensure => directory,
  group => 'oracle',
  owner => 'oracle',
  require => User[oracle],
}

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec["apt-update"]	-> Package <| |>


## this configuration calls for the installation of OEP using the oep module and its oep::install configuration
## the installation requires the existence of the swap file and the installation of Java
## parameters can be passed to the oep::install configuration to specify what should be installed (and where)






