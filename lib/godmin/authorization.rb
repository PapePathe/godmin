require "pundit"
require "godmin/authorization/policy"

module Godmin
  module Authorization
    extend ActiveSupport::Concern

    include Pundit

    included do
      rescue_from Pundit::NotAuthorizedError do
        render plain: "You are not authorized to do this", status: 403, layout: "godmin/login"
      end
    end

    def authorize(record, query = nil)
      super(engine_wrapper.namespaced_path.map(&:to_sym) << record, query)
    end

    def pundit_user
      admin_user
    end
  end
end
