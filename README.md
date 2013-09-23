puppet-symfony
==============

An experimental puppet module helper for Symfony apps running in Vagrant boxes. For now, its based on Apache.
This module was built to create optimized symfony boxes.

##Usage - Basic
Basic usage with default parameters.yml, MySQL database

``class { 'symfony':
    db_name  => 'my_db_name',
    db_user  => 'my_db_user',
    db_pass  => 'my_db_pass',
}``

#Optimization
The cache/logs optimization is not done by default, since it changes the AppKernel file. This optimization is strongly recommended,
since it decreases the page load time for about 1 to 2 seconds, opposed to the horrible performance we have by default with NFS and Symfony.
This post describes the problem: http://www.whitewashing.de/2013/08/19/speedup_symfony2_on_vagrant_boxes.html

The optimization applies a patch to add 2 methods in the AppKernel.php file. It will not remove or change your bundles and the change will
only affect the "dev" and "test" environment, by changing the cache and logs directory for a temporary folder outside the NFS.

To add the optimization:

``symfony::patch { 'vagrantee':}``

Thats all.

##Console Commands
You can easily run console commands via your puppet manifest with this module. Examples:

``symfony::console { 'doctrine:migrations:migrate': }``

``symfony::console { 'doctrine:fixtures:load':
    require => Symfony::Console['doctrine:migrations:migrate'],
}``

``symfony::console { 'assetic:dump': }``

