##################################################
# Symfony Console Helper
##################################################

define symfony::console (
  $doc_root = '/vagrant'
) {

  exec { "${name}":
    command => "php ${doc_root}/app/console ${name}",
  }
}