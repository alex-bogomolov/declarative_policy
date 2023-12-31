# frozen_string_literal: true

module DeclarativePolicy
  module PreferredScope
    PREFERRED_SCOPE_KEY = :"DeclarativePolicy.preferred_scope"

    def with_preferred_scope(scope)
      old_scope = Thread.current[PREFERRED_SCOPE_KEY]
      Thread.current[PREFERRED_SCOPE_KEY] = scope
      yield
    ensure
      Thread.current[PREFERRED_SCOPE_KEY] = old_scope
    end

    def preferred_scope
      Thread.current[PREFERRED_SCOPE_KEY]
    end

    def user_scope(&block)
      with_preferred_scope(:user, &block)
    end

    def subject_scope(&block)
      with_preferred_scope(:subject, &block)
    end

    def preferred_scope=(scope)
      Thread.current[PREFERRED_SCOPE_KEY] = scope
    end
  end
end
