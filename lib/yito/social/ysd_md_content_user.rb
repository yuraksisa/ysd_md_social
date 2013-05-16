require 'data_mapper' unless defined?DataMapper
require 'ysd-md-profile' unless defined?Users::Profile
require 'ysd_md_cms' unless defined?ContentManagerSystem::Content
require 'ysd-plugins' unless defined?Plugins::ModelAspect

module Yito
  module Social
    #
    # Represents the relationship between a content and a user
    #
    class ContentUser
      include DataMapper::Resource

      storage_names[:default] = 'social_content_users'

      belongs_to :user, 'Users::Profile', :child_key => [:user_username],
        :parent_key => [:username], :key => true
    
      belongs_to :content, 'ContentManagerSystem::Content', :child_key => [:content_id], 
        :parent_key => [:id], :key => true

    end
  
    #
    # A module used to manage the user join/unjoin
    #
    # If you want to join an user, do the following:
    #
    module JoinedUser
      include ::Plugins::ModelAspect

      def self.included(model)
        if model.respond_to?(:has)
          model.has Infinity, :joined_content_users, 'Yito::Social::ContentUser', 
            :child_key => [:content_id] , :parent_key => [:id], :constraint => :destroy
          model.has Infinity, :joined_users, 'Users::Profile', :through => :joined_content_users, 
            :via => :user, :constraint => :destroy
        end
      end
    
      # 
      # Check if the user has been joined
      #
      # @return [Boolean] If the user has been joined to the content
      def user_joined?(user)
        not ContentUser.first(:user => user, :content => self).nil?
      end

      #
      # Joins an user to the content
      # 
      # @param [Users::User]
      #
      def join(user)
        unless user_joined?(user)	
          joined_users << user 
          save
        end
        self
      end
    
      #
      # Removes the relationship between the content and the user
      # 
      # @param [Users::User] The user to remove from the list
      # @return [ContentManagerSystem::Content] The content
      def disjoin(user)
        joined_content_users.all(:user => user).destroy
        reload
        self
      end
   end #JoinedUser
  end #Social
end #Yito

module ContentManagerSystem  
  class Content
  	include Yito::Social::JoinedUser
  end
end