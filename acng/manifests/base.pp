# Install ACNG
package { apt-cacher-ng: 
		ensure => installed,
		alias => 'acng'
}

# Configure it
file { "/etc/apt-cacher-ng":
	ensure => directory,
	force => true,
	owner => 'root',
	group => 'root',
	mode => 0775
}
file { "/etc/apt-cacher-ng/acng.conf":
	ensure => file,
	force => true,
	owner => 'root',
	group => 'root',
	mode => 0444,
	source => "/vagrant/manifests/files/acng.conf"
}
file { "/etc/apt-cacher-ng/gems_mirrors":
	ensure => file,
	force => true,
	owner => 'root',
	group => 'root',
	mode => 0444,
	source => "/vagrant/manifests/files/gems_mirrors"
}

# Ensure it runs
service { 'apt-cacher-ng':
	ensure => running,
	require => Package['apt-cacher-ng'],
	subscribe => [
		File['/etc/apt-cacher-ng/acng.conf'],
		File['/etc/apt-cacher-ng/gems_mirrors'],
	]
}
