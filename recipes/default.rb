
include_recipe 'apt'

include_recipe 'site-typo3org::apache'
include_recipe 'site-typo3org::varnish'
include_recipe 'site-typo3org::nginx'