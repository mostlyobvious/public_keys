require 'public_keys/github'

github = PublicKeys::Github.new(:access_token => ENV['GITHUB_TOKEN'])

puts 'pawelpacana keys: ',         github.user_keys('pawelpacana').inspect
puts 'arkency keys: ',             github.organization_keys('arkency').inspect
puts 'drugpl wroc_love.rb team: ', github.team_keys('drugpl', 'wroc_love.rb').inspect
