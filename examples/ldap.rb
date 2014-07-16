require 'public_keys/ldap'

ldap = PublicKeys::LDAP.new(ENV['LDAP_HOST'], ENV['LDAP_PORT'], ENV['LDAP_USER'], ENV['LDAP_PASS'])
puts 'user keys:  ', ldap.user_keys('uid=pawel,ou=arkency,ou=people,dc=arkency,dc=com')
puts 'group keys: ', ldap.group_keys('cn=authorized_keys,ou=internal,ou=groups,dc=arkency,dc=com', 'dc=arkency,dc=com')

