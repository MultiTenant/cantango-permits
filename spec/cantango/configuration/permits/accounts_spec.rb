require 'spec_helper'

class Accounts
  include Singleton
  
  include CanTango::Configuration::Permits::Accounts
end

describe CanTango::Configuration::Permits::Accounts do
  subject { Accounts.new }
  
  describe 'accounts=' do
    pending
  end

  describe 'accounts' do
    pending
  end

  describe 'account_hash name' do
    pending
  end
end