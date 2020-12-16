require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Douyin < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, 'douyin'

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options,
             { site: 'https://open.douyin.com', token_url: '/oauth/access_token/', token_method: :get }

      # You may specify that your strategy should use PKCE by setting
      # the pkce option to true: https://tools.ietf.org/html/rfc7636
      option :pkce, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['openid'] }

      info do
        {
          province: raw_info['province'],
          unionid: raw_info['unionid'],
          avatar: raw_info['avatar'],
          e_account_role: raw_info['e_account_role'],
          nickname: raw_info['nickname'],
          city: raw_info['city'],
          country: raw_info['country'],
          description: raw_info['description'],
          gender: raw_info['gender']
        }
      end

      extra do
        {
          'raw_info' => raw_info['data']
        }
      end

      # @see https://open.douyin.com/platform/doc/6848806527751489550
      def raw_info
        @uid ||= access_token['openid']
        @raw_info ||= access_token.get('/oauth/userinfo/', params: { 'openid' => @uid },
                                                           parse: :json).parsed
      end

      def authorize_params
        super.tap do |params|
          params[:scope] = 'user_info'
        end
      end

      private

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      # @see https://open.douyin.com/platform/doc/6848806493387606024
      def build_access_token
        params = {
          'client_key' => client.id,
          'client_secret' => client.secret,
          'code' => request.params['code'],
          'grant_type' => 'authorization_code',
          'redirect_uri' => callback_url
        }.merge(token_params.to_hash(symbolize_keys: true))
        client.get_token(params, deep_symbolize(options.auth_token_params))
      end
    end
  end
end
