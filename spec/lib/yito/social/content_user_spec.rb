require 'spec_helper'

describe Yito::Social::JoinedUser do 

  before :each do

    @user_group = Users::Group.create({:group => 'registered_users' , 
    	:name => 'registered_users' , :description => 'Registered Users'})

    @user = Users::RegisteredProfile.create({:username => 'mike',
    	:usergroups => [@user_group]})

    @content_type = ContentManagerSystem::ContentType.create(
    	{:id => 'event', :name => 'Event', :description => 'Event',
         :publishing_workflow_id => 'standard', 
         :usergroups => [@user_group]})

    @content = ContentManagerSystem::Content.create(
    	{:content_type => @content_type,
    	 :title => 'Hello World',
    	 :body => 'Hello World!'
    	})

  end

  after :each do
    
    ContentManagerSystem::Content.destroy
    ContentManagerSystem::ContentType.destroy
    Users::RegisteredProfile.destroy
    Users::Group.destroy

  end

  describe "#join" do
    
    subject { @content.join(@user) }
    its(:joined_users) { should_not be_empty }
    its(:joined_users) { should include(@user) }

  end

  describe "#unjoin" do

    before :each do
      @content.join(@user)
    end    

    subject { @content.disjoin(@user) }
    its(:joined_users) { should be_empty }

  end

  describe "#user_joined" do

    before :each do
      @content.join(@user)
    end
 
    subject { @content.user_joined?(@user) }
    it { should == true}

  end

	
end