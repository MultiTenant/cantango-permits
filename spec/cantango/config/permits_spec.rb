require 'spec_helper'
require 'cantango/config/permit_registry_ex'

class Menu
end

class WaiterPermit < CanTango::Permit::UserType
  def initialize ability
    super
  end

  protected

  def calc_rules
    can :read, Menu
    cannot :write, Menu
  end
end

class ChefPermit < CanTango::Permit::UserType
  def initialize ability
    super
  end

  protected

  def calc_rules
    can :publish, Menu
    can :write, Menu
  end
end

class Context
  include CanTango::Api::Ability::User
end

describe CanTango::Config::Permits do
  subject { CanTango::Config::Permits.instance }

  it_should_behave_like CanTango::Config::Permits::Registration

  describe 'clear_permits_executed!' do
    specify { CanTango.config.permits.executed.should be_empty }
    
    before do
      CanTango.config.permits.executed[:x] = 1
      subject.clear_permits_executed!
    end
    
    specify { CanTango.config.permits.executed.should be_empty }
  end

  describe 'debugging permits' do
    let(:context) { Context.new }
    let (:user) do
      User.new 'kris', 'kris@gmail.com', :role => :waiter
    end

    before do
      CanTango.config.debug.set :on
      # context.user_ability(user).can? :read, Menu
    end

    describe 'should tell which permits allowe :read' do
      it 'should show WaiterRolePermit as the permit that allowed :read of Menu' do
        CanTango.permits_allowed(user, :read, Menu).should include(WaiterPermit)
      end
    end

    describe 'should tell which permits denied :write' do
      it 'should show WaiterRolePermit as the permit that denied :write of Menu' do
        CanTango.permits_denied(user, :write, Menu).should include(WaiterPermit)
      end
    end
  end
end