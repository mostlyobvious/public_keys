require 'net/ldap'

module PublicKeys
  class LDAP
    def initialize(host, port, user_dn = nil, password = nil)
      @client = Net::LDAP.new
      @client.host = host
      @client.port = port
      @client.auth(user_dn, password) if user_dn
    end

    def group_keys(group_dn, base_dn)
      filter = Net::LDAP::Filter.eq("sshPublicKey", "*") &
               Net::LDAP::Filter.eq("memberof", group_dn)
      Array(@client.search(:base => base_dn, :filter => filter)).flat_map { |entry| entry[:sshPublicKey] }
    end

    def user_keys(user_dn)
      filter = Net::LDAP::Filter.eq("sshPublicKey", "*")
      Array(@client.search(:base => user_dn, :filter => filter)).flat_map { |entry| entry[:sshPublicKey] }
    end
  end
end
