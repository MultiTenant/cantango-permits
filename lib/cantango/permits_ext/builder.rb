module CanTango
  module Builder
    sweet_scope :ns => {:CanTango => 'cantango/permits_ext'} do
      sweetload :Permit
    end
  end
end