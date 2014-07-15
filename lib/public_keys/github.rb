require 'octokit'

module PublicKeys
  class Github
    UnauthorizedError = Class.new(StandardError)

    def initialize(*args)
      @client = Octokit::Client.new(*args)
    end

    def user_keys(user)
      @client.user_keys(user).map { |user| user['key'] }
    end

    def team_keys(organization, team_name)
      team_id = @client.organization_teams(organization).find { |team| team['name'] == team_name }['id']
      @client.team_members(team_id).flat_map { |member| user_keys(member['login']) }
    rescue Octokit::Unauthorized
      raise UnauthorizedError.new('You have to authenticate to get team keys.')
    end

    def organization_keys(organization)
      @client.organization_members(organization).flat_map { |member| user_keys(member['login']) }
    end
  end
end