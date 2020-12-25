module Omniauth
  module Douyin
    class AccessToken < ::OAuth2::AccessToken
      class << self
        # Initializes an AccessToken from a Hash
        #
        # @param client [Client] the OAuth2::Client instance
        # @param hash [Hash] a hash of AccessToken property values
        # @return [AccessToken] the initalized AccessToken
        def from_hash(client, hash)
          hash = hash['data'].dup
          new(client, hash.delete('access_token') || hash.delete(:access_token), hash)
        end
      end
    end
  end
end
