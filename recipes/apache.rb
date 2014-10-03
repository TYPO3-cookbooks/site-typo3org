#
# Apache instance that serves TYPO3 pages from PHP
#

include_recipe 'site-typo3org::php'

include_recipe 'apache2'

package 'libapache2-mod-rpaf'
apache_module 'rpaf'