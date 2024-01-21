RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Lesson' do
    exclude_fields :photo, :pdf, :video

    field :photo, :active_storage do
      delete_method :remove_photo
      pretty_value do
        if bindings[:object].photo.attached?
          path = Rails.application.routes.url_helpers.rails_blob_path(bindings[:object].photo.variant(resize: '100x100'), only_path: true)
          bindings[:view].content_tag(:a, bindings[:view].image_tag(path, class: 'thumbnail'), href: path, target: '_blank')
        else
          'No photo'
        end
      end
    end

    field :pdf, :active_storage do
      delete_method :remove_pdf
    end

    field :video, :active_storage do
      delete_method :remove_video
    end
  end

  config.model 'Course' do
    exclude_fields :photo, :pdf, :video

    field :photo, :active_storage do
      delete_method :remove_photo
      pretty_value do
        if bindings[:object].photo.attached?
          path = Rails.application.routes.url_helpers.rails_blob_path(bindings[:object].photo.variant(resize: '100x100'), only_path: true)
          bindings[:view].content_tag(:a, bindings[:view].image_tag(path, class: 'thumbnail'), href: path, target: '_blank')
        else
          'No photo'
        end
      end
    end

    field :pdf, :active_storage do
      delete_method :remove_pdf
    end

    field :video, :active_storage do
      delete_method :remove_video
    end
  end

end
