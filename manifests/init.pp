class common {
  include apt
  include maven

  apt::ppa { ['ppa:webupd8team/sublime-text-3', 'ppa:ubuntu-wine/ppa', 'ppa:webupd8team/java', 'ppa:brightbox/ruby-ng']:
    release => 'trusty',
    options => '-y';
  }

  apt::key { 'spotify': id => 'E22CBE98B5575C1857671254082CCEDF94558F59'; }

  apt::source { 'spotify':
    location => 'http://repository.spotify.com',
    release  => 'stable',
    repos    => 'non-free';
  }

  file { '/etc/apt/responsefile': source => 'puppet:///modules/common/responsefile'; }

  package {
    [
      'vim',
      'curl',
      'iotop',
      'sublime-text-installer',
      'spotify-client',
      'python-pip',
      'python-gpgme',
      'vagrant',
      'virtualbox-4.3',
      'wine1.7',
      'oracle-java7-installer',
      'daemon',
      'gir1.2-gtop-2.0',
      'heimdal-clients',
      'tidy',
      'keepassx',
      'rdesktop',
      'ruby2.1']:
      responsefile => '/etc/apt/responsefile',
      require      => Class['apt::update'];

    ['r10k', 'aws-sdk', 'grouper']:
      provider => 'gem';
  }
}
