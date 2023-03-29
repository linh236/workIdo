require 'rails_helper'

RSpec.describe User, type: :model do
  it "returns the full_name for a user" do
    user = create(:user)
    user2 = create(:user)
    expect(user.full_name).to eq "linhnq1" 
    expect(user2.full_name).to eq "linhnq2" 
  end
end
