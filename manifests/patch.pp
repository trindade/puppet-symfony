############################################################################################
# Patch for the AppKernel
# Optimizes Symfony apps running with Vagrant by moving the cache and log dirs outside NFS
# As stated here: http://www.whitewashing.de/2013/08/19/speedup_symfony2_on_vagrant_boxes.html
############################################################################################

define symfony::patch(
) {

  file {'patch-file':
    ensure => present,
    path   => '/tmp/AppKernel.patch',
    mode   => '0644',
    source => 'puppet:///modules/symfony/AppKernel.patch',
  }

  exec { "AppKernel-patch":
    cwd     => "/vagrant/app",
    command => "/usr/bin/patch -ts </tmp/AppKernel.patch",
  }
}